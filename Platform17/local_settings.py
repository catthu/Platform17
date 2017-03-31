DEBUG = False

CHANNEL_LAYERS = {
    "default": {
        "BACKEND": "asgiref.inmemory.ChannelLayer",
        "ROUTING": "terminal.routing.channel_routing",
    },
}