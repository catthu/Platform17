from django.shortcuts import render
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login, logout
from django.http import JsonResponse, HttpResponse
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.decorators import login_required
import json

from generics.models import *
from players.models import *
from .models import *
# Create your views here.

def username_exists(request, username):
    try:
        existing_user = User.objects.get(username__iexact = username)
        print existing_user
    except User.DoesNotExist:
        return JsonResponse({'username_exists': False})
    return JsonResponse({'username_exists': True})

@csrf_exempt
def create_user(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        new_user = User.objects.create_user(data['username'], email = data['email'], password = data['password'])
        login(request, new_user)
        player = Player(user = new_user)
        player.save()
        request.session['player_id'] = player.id
    return HttpResponse()

@csrf_exempt
def sign_in(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        user = authenticate(username = data['username'], password = data['password'])
        if user == None:
            return HttpResponse("Unauthorized", status = 401)
        login(request, user)
        try:
            player = Player.objects.get(user = user)
        except Player.DoesNotExist:
            player = Player(user = user)
            player.save()
        request.session['player_id'] = player.id
        res = {
            'first_name': player.first_name,
            'last_name': player.last_name
        }
        return JsonResponse(res)

@csrf_exempt
def sign_out(request):
    logout(request)
    return HttpResponse()

@csrf_exempt
@login_required
def create_player(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        print data
        player_id = request.session['player_id']
        player = Player.objects.get(pk = player_id)
        player.first_name = data['first_name']
        player.last_name = data['last_name']
        player.save()
    return HttpResponse()
