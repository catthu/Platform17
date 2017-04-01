
from channels.handler import AsgiHandler
from channels import Group
from channels.sessions import channel_session

def ws_connect(message):
    # Accept connection
    message.reply_channel.send({"accept": True})
    # Get room name from the path
    room = message['path'].strip('/')
    # Add user to the right room
    Group(room).add(message.reply_channel)
    # Add user to the all-game room
    Group('all-game').add(message.reply_channel)

def ws_receive(message):
    # ASGI WebSocket packet-received and send-packet message types
    # both have a "text" key for their textual data.
    room = message['path'].strip('/')
    Group(room).send({'text': message.content['text'],})


    '''
    message.reply_channel.send({
        "text": message.content['text'],
    })'''

def ws_disconnect(message):
    #room = message.content['location']
    #Group(room).discard(message.reply_channel)
    Group('all-game').discard(message.reply_channel)
