// TODO: weird bug! On heroku, if SECURE_SSL is required, then static files are not loading =[
// but we can still https to it, just can't require...
// TODO: pre-load normalroom, check if a room uses it, put in dispatcher queue
// TODO: production and dev env (different git branches?) - ssl redirect, debug false, saving users
// TODO: Maybe debug staticfiles serving
// TODO: Look up server pushing to client and race conditions
// TODO: Write Bertrand Russell Markov generator
// TODO: Write text cleaning functions for terminal and refactor them
// etc. capitalize, process...
// TODO: standardize text and input trimming --- trim them at the event listener
// instead of doVerb + trim them before passing to any functions
// TODO: add to logout view: redirect to login view
// TODO: set login_require's login_url to login view too
// TODO: check authentication when user loads for the first time and put them
// where they were last or an intro screen (probaby require separate login view)
// TODO: automatically log out when user closes browswer? Log back in at their last location?
// TODO: figure out how to design the object-oriented-ness of items, how to store them, and how they interact back- and front-end

// Need to also:
// Load top command layer (does not change, load at ready)
// Load room command layer (changes often, make AJAX calls)
// Load global command layer (does not change, load at ready)
// Load item layer (changes often, make AJAX calls)


// Define global variables
var deferreds = [];
var current_room;
var current_room_script;
var me = {};

var processText = {

    capitalize: (text) => {
        text = text.trim();
        return text.charAt(0).toUpperCase() + text.slice(1);
    },

    capitalizeEveryWord: (text) => {
        if (text.length === 0) {
            return "";
        }
        text = processText.capitalize(text);
        let space = text.indexOf(" ");
        while (space !== -1) {
            text = text.slice(0, space + 1) + (text.charAt(space + 1).toUpperCase()) + text.slice(space + 2);
            space = text.indexOf(" ", space + 1);
        }
        return text;
    },

    prepareForWriteLine: (text) => {
        let punctuation = ['.', '!', '?', '"', '>']
        text = processText.capitalize(text);
        if (punctuation.indexOf(text.charAt(text.length - 1)) === -1) {
            text = text + '.';
        }
        return text
    }
};

$(document).ready( function() {
        // After page load, focus on input field
        $("#input-text").focus()

        $(document).click( function() {
            // Focus on input field when clicking anywhere in the terminal
            $("#input-text").focus(); 
        });

        current_room_script = login;

        // Event listener for input submission
        // and pass the submission to the command dispatcher
        const form = document.getElementById("input-form");
        form.onsubmit = function(e) {
            e.preventDefault();
            input = document.getElementById("input-text").value;
            readLineAndRespond(input.trim());         
    
        };
        
});

async function readLine(input = null, check = x => {return {'is_valid': true};}) {
    /* 
    Read input, validate input and prompt for retries if necessary
    Argument:
        input (str, optional): command inputed by the user from the web interface
                    null if function is called from a process while awaiting input
        check (function, optional): the function to check validity of the input
            function arguments:
                input (str)
            function return values:
                object with 2 fields:
                    is_valid: true if input is valid , false otherwise
                    retry_msg: a custom message to be written to terminal if 
                            the input is not valid. If this field is falsy,
                            it will print "Invalid. Try again."
                            NEVER SET THIS TO 0 OR EMPTY STRING
    Return values:
        input (str): the valid input, as validated by check(input)
    */

    while (input === null || !result.is_valid) {
        if (input !== null) {
            let msg = result.retry_msg || "Invalid. Try again.";
            writeLine(msg);
        }
        input = new Promise((resolve, reject) => {
            deferreds.push({resolve: resolve, reject: reject});
        });
        result = await check(await input);
    }
    return input;
}

async function readPassword(input = null, check = x => {return {'is_valid': true};}) {
    /*
    Change #input-text into a password field before inputting password
    then change back to a text field afterward
    */
    const input_field = document.getElementById("input-text");
    input_field.type = "password";
    input = await readLine(input, check);
    input_field.type = "text";
    return input;
}


function readLineAndRespond(input) {
    /*
    Called by the window event listener on the input form.
    Get the input and pass it to things that ask for it in order of priority
    Order of priority:
        - Any process with a deferred promise (created by readLine), FILO
        - Top level commands
        - Room level commands
        - Item level commands
        - Global commands
    At each level, the level function returns something falsy if that level
    doesn't handle the input.
    readLineAndRespond stops checking if something returns truthy
    Argument:
        input(str): input as entered by the user from the web interface
    Return value:
        None

    */
    let input_field = document.getElementById("input-text");
    // Record the most recent input in #terminal-output
    if (input_field.type === "password") {
        writeLine("><br />");
    } else {
        writeLine("> " + input + "<br />");
    }
    // Clear input field
    document.getElementById("input-form").reset();
    // Check deferred promises
    if (deferreds.length > 0) {
        deferreds.pop().resolve(input);
    } else {
        // Go through request queue
        let input_request_queue = [top_commands.parseInput, current_room_script.parseInput, parseItemLayer, global_commands.parseInput]; // the ordered queue for command layers
        for (var i = 0; i < input_request_queue.length; i ++) {
            if (input_request_queue[i](input)) {
                // do stuff
                break;
            }
        }
    }
}




function parseItemLayer(input) {
    return null;
}

// Print stuff to terminal

function writeLine(text) {
    /*
    Write a line to the terminal (#terminal-output) by appending
    at the end
    Argument:
        text (str): the text to append
    Return value:
        None
    */
    let output = $("#terminal-output");
    text = processText.prepareForWriteLine(text);
    output.append('<br />' + text + '<br />');
    $("#input-text").focus();
    // Scroll to bottom
    $("html, body, #terminal").animate({ scrollTop: $("#terminal")[0].scrollHeight}, "fast");
}

function delayedWriteLine(text, delay = 1500) {
    return new Promise(resolve => {
        setTimeout(() => {writeLine(text); resolve();}, delay);
    });
}

// Function to support making AJAX calls to get the next room

async function loadRoom(room_codename) {
    /*
    Get a new room from the server.
    Argument:
        room_codename: the codename of the room requested
            rooms are accessed by codename to prevent users sending random requests
    Side effects:
        current_room (obj): get a new object contains the attributes for the request room
        current_room_script (function): namespace of the script for the requested room
    Return value:
        true if successful
    */
    const url = "/" + room_codename + "/";
    const init = {credentials: 'include'}
    let res = await fetch(url, init);

    current_room = await res.json();

    let script = document.createElement('script');
    script.src = "/static/rooms/" + await current_room.js_filename + ".js";
    script.id = await current_room.js_filename + "_script";
    document.body.appendChild(script);
    script.onload = (() => {
        current_room_script = window[current_room.js_filename];
    });

    await delayedWriteLine("<span class = 'room-name'>----- " + current_room.name + " -----</span>");
    writeLine(current_room.description);

    if (current_room.opening_script) {
        writeLine(current_room.opening_script);
    }

    return true;
}
