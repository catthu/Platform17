from django.shortcuts import render
from django.http import HttpResponse, JsonResponse, Http404
from django.core import serializers
from django.contrib.auth.decorators import login_required


from generics.models import *

# Create your views here.

def index(request):
    page = Room.objects.get(code_name__iexact = "login")
    context = {'page': page}
    return render(request, 'terminal/index.html', context)

@login_required
def room(request, room_codename):
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
    res['characters_here'] = map(lambda c: c.getFullName(), Character.objects.filter(location = room).filter(is_logged_in = True))
    Character.objects.filter(id = request.session['character_id']).update(location = room)
    return JsonResponse(res)
