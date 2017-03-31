from channels.routing import route
from terminal.consumers import *

channel_routing = [
    route("websocket.connect", ws_connect),
    route("websocket.receive", ws_receive),
]