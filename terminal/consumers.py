
from channels.handler import AsgiHandler
from channels import Group
from channels.sessions import channel_session

def ws_connect(message):
    message.reply_channel.send({"accept": True})
    Group('all-game').add(message.reply_channel)

def ws_receive(message):
    # ASGI WebSocket packet-received and send-packet message types
    # both have a "text" key for their textual data.
    
    Group('all-game').send({'text': message.content['text'],})


    '''
    message.reply_channel.send({
        "text": message.content['text'],
    })'''

