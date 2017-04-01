// DONE: better structure and separate between the Player model and Character model
// TODO: implement isMe() function to check if terminal push output or part of it refers to self (to prevent printing it)
// TODO: ask username, emails, twice (verification) when signing up new users
// TODO: weird bug! On heroku, if SECURE_SSL is required, then static files are not loading =[
// but we can still https to it, just can't require...
// DONE: pre-load normalroom, check if a room uses it, put in dispatcher queue
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
// TODO: catch IntegrityError on database when creating user and verifying username
// uniqueness, per http://stackoverflow.com/questions/22618605/avoiding-race-condition-between-validation-for-uniqueness-and-insertion
// TODO: implement optimistic locking where needed for race condition:
// http://stackoverflow.com/questions/3653592/how-do-you-avoid-this-race-condition-in-python-django-mysql
// and for database entries use get_for_updates(): http://stackoverflow.com/questions/320096/django-how-can-i-protect-against-concurrent-modification-of-database-entries



// Need to also:
// Load top command layer (does not change, load at ready)
// Load room command layer (changes often, make AJAX calls)
// Load global command layer (does not change, load at ready)
// Load item layer (changes often, make AJAX calls)


// Define global variables
var deferreds = [];
var CURRENT_ROOM; // Object containing properties of the current room
var CURRENT_ROOM_SCRIPT; // Object containing the JS for the room
var ME = {}; // Object containing properties of the current character

var processText = {

    // Functions to process text nicely before printing them 
    // to the terminal

    capitalize: (text) => {
        // Capitalize the first letter
        text = text.trim();
        return text.charAt(0).toUpperCase() + text.slice(1);
    },

    capitalizeEveryWord: (text) => {
        // Capitalize the first letter of every word
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
        // Capitalize sentence and add punctuation at the end
        // Called as final step before write to terminal
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

        CURRENT_ROOM_SCRIPT = login;

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
        let input_request_queue = [top_commands.parseInput, CURRENT_ROOM_SCRIPT.parseInput, normalroom.parseInput, parseItemLayer, global_commands.parseInput]; // the ordered queue for command layers
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
    // Like writeLine, but after a delay
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
        Close old websocket connection and start a new one.
        CURRENT_ROOM (obj): get a new object contains the attributes for the request room
        CURRENT_ROOM_SCRIPT (function): namespace of the script for the requested room
        Print information about the new room to the screen
    Return value:
        true if successful
    */
    
    if (socket) {
        socket.close()
    }

    // Open a new websocket with the URL with the codename of the new room

    openWebSocket(room_codename);

    const url = "/" + room_codename + "/";
    const init = {credentials: 'include'}
    let res = await fetch(url, init);

    // Load the new room information into the environment

    CURRENT_ROOM = await res.json();

    // Fetch the new room's JS file and assign it to the 
    // CURRENT_ROOM_SCRIPT environment variable

    let script = document.createElement('script');
    script.src = "/static/rooms/" + await CURRENT_ROOM.js_filename + ".js";
    if (CURRENT_ROOM.js_filename === 'normalroom') {
        CURRENT_ROOM_SCRIPT = {
            // If the room is using the 'normalroom' script, then
            // set CURRENT_ROOM_SCRIPT.parseInput function to null
            // so the queue just skips it
            parseInput: (input) => {
                return null
            }
        }
    } else {
        script.id = await CURRENT_ROOM.js_filename + "_script";
        document.body.appendChild(script);
        script.onload = (() => {
            CURRENT_ROOM_SCRIPT = window[CURRENT_ROOM.js_filename];
        });
    }

    // Print information about the room

    await writeRoomInfo(CURRENT_ROOM);

    playOpeningScript(CURRENT_ROOM.opening_script);

    writeCharactersList(CURRENT_ROOM.characters_here);    

    return true;
}

async function writeRoomInfo(room) {
    // Print the room name and description to the screen
    await delayedWriteLine("<span class = 'room-name'>----- " + room.name + " -----</span>");
    writeLine(room.description);

}

function playOpeningScript(text) {
    // Print / play the opening script for the room, if there is one
    if (text) {
        writeLine(CURRENT_ROOM.opening_script);
    }
}

function writeCharactersList(list) {
    // Print a list of characters to the screen as
    // "You see firstname lastname, firstname lastname and firstname lastname here."
    if (list.length !== 0) {
        let str = "You see "
        for (let i = 0; i < CURRENT_ROOM.characters_here.length; i ++) {            
            str += processText.capitalizeEveryWord(CURRENT_ROOM.characters_here[i]);
            if (i < CURRENT_ROOM.characters_here.length - 2) {
                str += ", "
            }
            if (i === CURRENT_ROOM.characters_here.length - 2) {
                str += " and "
            }
        }
        str += " here."
        writeLine(str);
    }
}
