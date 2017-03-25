// TODO: new channel for terminal output (stop using console.log())
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
var current_room = 3;
var pending_input_request_from_room = false;
var pending_input_request_from_item = false;

$(document).ready( function() {
        // After page load, focus on input field
        $("#input-text").focus()

        $(document).click( function() {
            // Focus on input field when clicking anywhere in the terminal
            $("#input-text").focus(); 
        });

        // Event listener for input submission
        // and pass the submission to the command dispatcher
        form = document.getElementById("input-form");
        form.onsubmit = function(e) {
            e.preventDefault();
            input = document.getElementById("input-text").value;
            dispatchCommand(input);            
    
        };
});

function dispatchCommand(input) {
    var input_request_queue = [parseTopLayer, current_room.parseRoomLayer, parseGlobalLayer, parseItemLayer]; // the ordered queue for command layers
    for (var i = 0; i < input_request_queue.length; i ++) {
        if (input_request_queue[i](input)) {
            // do stuff
            break;
        }
    }
}

// function get input
// found command
// do stuff
// return

function parseTopLayer(input) {
    // do stuff
    return true;
}

function parseGlobalLayer(input) {
    // do stuff
    return true;
}

// Print stuff to console

function printToTerminal(string) {

}

// Function to support making AJAX calls to get the next room

function getRoom(room_id) {
    var xhttp = new XMLHttpRequest();
    
    xhttp.onreadystatechange = function() {
        if (this.readyState == 4 && this.status == 200) {
            res = JSON.parse(xhttp.response);
            console.log(res.response_text);
        }
    };
    url = "/search/?room=" + query;
    xhttp.open("GET", url, true);
    xhttp.send();

    // AJAX to get the room with the js_filename
    // get new_room with AJAX
    room = the_name_space;
    room.parseRoomLayer();

    // Not have a bunch of scripts attached to the file
}



/*
if (typeof console  != "undefined") 
    if (typeof console.log != 'undefined')
        console.olog = console.log;
    else
        console.olog = function() {};

var result = $('#terminal');

console.log = function(message) {
    console.olog(message);
    $('#terminal-output').append('<br />' + message + '<br />');
      result.focus();
    placeCaretAtEnd( document.getElementById("terminal") );
};
console.error = console.debug = console.info =  console.log

function ScrollToBottom() {
            $("html, body, #terminal").animate({ scrollTop: $(document).height()}, "slow");
            return false;
};

function placeCaretAtEnd(el) {
    var cursor = $('#input-text');
    cursor.val('');
    cursor.focus();
    ScrollToBottom();
}
*/
