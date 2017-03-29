// TODO: pre-load normalroom, check if a room uses it
// TODO: read about user authentication
// TODO: checkLogin() to check username and password at same time
// TODO: Finish server call functions for authentication stuff (check existing usernames, send pairs of username and password to authenticate...)
// TODO: Enforce HTTPS redirect
// TODO: Maybe debug staticfiles serving
// TODO: Implement Django authentication
// TODO: Look up server pushing to client and race conditions
// TODO: Write Bertrand Russell Markov generator


// Need to also:
// Load top command layer (does not change, load at ready)
// Load room command layer (changes often, make AJAX calls)
// Load global command layer (does not change, load at ready)
// Load item layer (changes often, make AJAX calls)


// Define global variables
var deferreds = [];
var current_room;
var current_room_script;

$(document).ready( function() {
        // After page load, focus on input field
        $("#input-text").focus()

        $(document).click( function() {
            // Focus on input field when clicking anywhere in the terminal
            $("#input-text").focus(); 
        });

        loadRoom("login");

        // Event listener for input submission
        // and pass the submission to the command dispatcher
        const form = document.getElementById("input-form");
        form.onsubmit = function(e) {
            e.preventDefault();
            input = document.getElementById("input-text").value;
            readLineAndRespond(input);         
    
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
    input = input.toLowerCase();
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
        let input_request_queue = [parseTopLayer, current_room_script.parseRoomLayer, parseItemLayer, parseGlobalLayer]; // the ordered queue for command layers
        for (var i = 0; i < input_request_queue.length; i ++) {
            if (input_request_queue[i](input)) {
                // do stuff
                break;
            }
        }
    }
}

function parseTopLayer(input) {
    // do stuff
    return null;
}

function parseGlobalLayer(input) {
    // do stuff
    return true;
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
    let res = await fetch(url);
    current_room = await res.json();

    let script = document.createElement('script');
    script.src = "/static/rooms/" + await current_room.js_filename + ".js";
    script.id = await current_room.js_filename + "_script";
    document.body.appendChild(script);
    script.onload = (() => {
        current_room_script = window[current_room.js_filename];
    });

    return true;
}