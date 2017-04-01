from django.shortcuts import render
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login, logout
from django.http import JsonResponse, HttpResponse
from django.views.decorators.csrf import csrf_exempt
from django.contrib.auth.decorators import login_required

import json

from generics.models import *
from players.models import *
from terminal.views import *
from .models import *
# Create your views here.

CHARGEN = Room.objects.get(code_name__iexact = "chargen")

def username_exists(request, username):
    try:
        existing_user = User.objects.get(username__iexact = username)
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
        try:
            character_list = PlayerToCharacters.objects.get(player = player)
        except PlayerToCharacters.DoesNotExist:
            return JsonResponse({'hasCharacter': False})
        character = character_list.character
        character.is_logged_in = True
        character.save()
        request.session['character_id'] = character.id
        res = {
            'hasCharacter': True,
            'first_name': character.first_name,
            'last_name': character.last_name,
            'location': character.location.code_name
        }
        return JsonResponse(res)

@csrf_exempt
@login_required
def sign_out(request):
    Character.objects.filter(pk = request.session['character_id']).update(is_logged_in = False)
    logout(request)
    return HttpResponse()

@csrf_exempt
@login_required
def create_character(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        player_id = request.session['player_id']
        player = Player.objects.get(pk = player_id)
        character = Character(first_name = data['first_name'], last_name = data['last_name'], location = CHARGEN, is_logged_in = True)
        character.save()
        playerToCharacter = PlayerToCharacters(player = player, character = character)
        playerToCharacter.save()
        request.session['character_id'] = character.id
    return HttpResponse()
