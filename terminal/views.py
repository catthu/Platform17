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
        page = Room.objects.get(code_name__iexact = room_codename)
    except Room.DoesNotExist:
        raise Http404('Room does not exist.')
    res = {}
    for field in page._meta.get_fields():
        if getattr(page, field.name, False):
            res[field.name] = getattr(page, field.name)
    return JsonResponse(res)
