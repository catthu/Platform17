from django.shortcuts import render
from django.http import HttpResponse, JsonResponse, Http404
from django.core import serializers
from django.contrib.auth.decorators import login_required


from generics.models import *

def index(request):
    '''
    index
    The original "intro" view.
    Pre-load the login room.
    Renders an HTTP template.
    '''
    page = Room.objects.get(code_name__iexact = "login")
    context = {'page': page}
    return render(request, 'terminal/index.html', context)

@login_required
def room(request, room_codename):
    '''
    room
    Load a room, move the requesting user into it.
    Argument: request, room_codename
    Return value:
        JSON string containing every key and value pair of the room object
        Except 'exit' contains codename of the exit room
        and 'characters_here' contains a list of characters in this room
    '''
    try:
        room = Room.objects.get(code_name__iexact = room_codename)
    except Room.DoesNotExist:
        raise Http404('Room does not exist.')
    res = {}
    for field in room._meta.get_fields():
        if getattr(room, field.name, False):
            if field.name == 'exit':
                res['exit'] =  room.exit.code_name
                continue
            res[field.name] = getattr(room, field.name)
    res['characters_here'] = map(lambda c: c.getFullName(), Character.objects.filter(location = room).filter(is_logged_in = True).exclude(pk = request.session['character_id']))
    Character.objects.filter(id = request.session['character_id']).update(location = room)
    return JsonResponse(res)
