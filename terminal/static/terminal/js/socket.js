var ws_scheme = window.location.protocol == "https:" ? "wss" : "ws";
var socket = new ReconnectingWebSocket(ws_scheme + '://' + window.location.host + "/chat/");

socket.onmessage = (message) => {
    let line = JSON.parse(message.data);
    if (line.message.indexOf(processText.capitalizeEveryWord(me['first_name'] + " " + me['last_name'])) === 0) {
        return false;
    }
    writeLine(line.message);
    return true;
}

function push(message) {

    let line = {
        message
    }

    socket.send(JSON.stringify(line));
    return true;
}