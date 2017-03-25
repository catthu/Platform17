// Write shared event listener function (so it can print the command back to the terminal)
// TODO: show past inputs
// TODO: support printToTerminal()
// TODO: support 


// Need to also:
// Load top command layer (does not change, load at ready)
// Load room command layer (changes often, make AJAX calls)
// Load global command layer (does not change, load at ready)
// Load item layer (changes often, make AJAX calls)

// Keep focus on the input field

// Define global variables
var current_room_id = 3;
var room_awaiting_input = false;
var item_awaiting_input = false;
var deferreds = [];
//import login from '/rooms/login.js';
//var room_js = login;


$(document).ready( function() {
        // After page load, focus on input field
        $("#input-text").focus()

        $(document).click( function() {
            // Focus on input field when clicking anywhere in the terminal
            $("#input-text").focus(); 
        });

        // Event listener for input submission
        // and pass the submission to the command dispatcher
        var form = document.getElementById("input-form");
        form.onsubmit = function(e) {
            e.preventDefault();
            input = document.getElementById("input-text").value;
            input = input.toLowerCase();
            printToTerminal("> " + input + "<br />");
            form.reset();
            if (deferreds.length > 0) {
                deferreds.pop().resolve(input);
            } else {
                dispatchCommand(input); 
            }         
    
        };
        
});

// make promise
// resolve promise
// await promise
// .then the async function

async function stdin(input, check = x => {return true;}, retry_msg = "Invalid. Try again.") {
    while (!check(await input)) {
        if (input !== null) {
            printToTerminal(retry_msg);
        }
        input = new Promise((resolve, reject) => {
            deferreds.push({resolve: resolve, reject: reject});
        });
    }
    return input;
}

function dispatchCommand(input) {
    var input_request_queue = [parseTopLayer, login.parseRoomLayer, parseItemLayer, parseGlobalLayer]; // the ordered queue for command layers
    for (var i = 0; i < input_request_queue.length; i ++) {
        if (input_request_queue[i](input)) {
            // do stuff
            break;
        }
    }
}

function parseTopLayer(input) {
    // do stuff
    return false;
}

function parseGlobalLayer(input) {
    // do stuff
    return true;
}

function parseItemLayer(input) {
    return false;
}

// Print stuff to console

function ScrollToBottom() {
            $("html, body, #terminal").animate({ scrollTop: $(document).height()}, "slow");
            return false;
};

function printToTerminal(text) {
    var output = $("#terminal-output");
    output.append('<br />' + text + '<br />');
    $("#input-text").focus();
    ScrollToBottom();

}

// Function to support making AJAX calls to get the next room
/*
function getRoom(room_id) {
    var xhttp = new XMLHttpRequest();
    
    xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            res = JSON.parse(xhttp.response);
            printToTerminal(res.response_text);
        }
    };
    url = "/" + query;
    xhttp.open("GET", url, true);
    xhttp.send();

    // AJAX to get the room with the js_filename
    // get new_room with AJAX
    room = the_name_space;
    room.parseRoomLayer();

    // Not have a bunch of scripts attached to the file
}

// Get the JS file of the next room

function getJS(room_id) {
    return null;
}*/

