var ws_scheme = window.location.protocol == "https:" ? "wss" : "ws";
var socket = new ReconnectingWebSocket(ws_scheme + '://' + window.location.host + "/chat" + window.location.pathname);

socket.onmessage = (message) => {
    let line = JSON.parse(message.data);
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