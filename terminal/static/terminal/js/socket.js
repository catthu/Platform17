// Websocket configurations
// Using the right protocol (wss or ws)
var ws_scheme = window.location.protocol == "https:" ? "wss" : "ws";
var socket;

function openWebSocket(codename) {
    // Open a socket connection with a channel to the current room
    socket = new ReconnectingWebSocket(ws_scheme + '://' + window.location.host + "/" + codename +"/");
    socket.onmessage = (message) => {
        // When receiving a message, write it to the terminal
        // Unless message was pushed by this user
        // Currently filtered by weather it starts with the sender's character's name since Django Channels
        // Doesn't allow exclusion
        // Need a better way to exclude
        let line = JSON.parse(message.data);
        if (line.message.indexOf(processText.capitalizeEveryWord(ME['first_name'] + " " + ME['last_name'])) === 0) {
            return false;
        }
        writeLine(line.message);
        return true;
    }
}

function push(message, location) {
    // Push the message to all the users in the 'location' room
    let line = {
        message,
        location
    }

    socket.send(JSON.stringify(line));
    return true;
}