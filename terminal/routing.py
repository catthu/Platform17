from channels.routing import route
from terminal.consumers import *

channel_routing = [
    route("websocket.receive", ws_receive),
]