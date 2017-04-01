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

# Reference to Chargen room
CHARGEN = Room.objects.get(code_name__iexact = "chargen")

def username_exists(request, username):
    '''
    username-exists
    Check if username already exists in the database; return True if it does.
    Arguments:
        request
        username(str): a string containing only alphanumerics or _
    Return value:
        JSON object with one key 'username_exists'
            True if username exists, False otherwise
    '''
    try:
        existing_user = User.objects.get(username__iexact = username)
    except User.DoesNotExist:
        return JsonResponse({'username_exists': False})
    return JsonResponse({'username_exists': True})

@csrf_exempt
def create_user(request):
    '''
    create_user
    Create a new user and save it to the User table.
    Argument: request with the body containing 'username' and 'email' and 'password'
    Return value: HttpResponse
    '''
    if request.method == 'POST':
        # Get JSON data containing username and password from the request body
        data = json.loads(request.body)
        # Create new user object
        # Need to put in check and error catching here for if user already exists
        new_user = User.objects.create_user(data['username'], email = data['email'], password = data['password'])
        # Log the user in
        login(request, new_user)
        # Create a new Player for the new user, too
        player = Player(user = new_user)
        player.save()
        # Keep track of the player id in session
        request.session['player_id'] = player.id
    return HttpResponse()

@csrf_exempt
def sign_in(request):
    '''
    sign_in
    Sign the user in and return user data to the front end.
    Arguments: request, body contains 'username', 'password'
    Return value:
        JSON string
            'hasCharacter': True if the user has a character, False otherwise
            'first_name': first name of the character
            'last_name': last name of the character
            'location': the current location of the character, not sure if necessary

    '''
    if request.method == 'POST':
        data = json.loads(request.body)
        # Authenticate user
        user = authenticate(username = data['username'], password = data['password'])
        if user == None:
            # Return 401 if authentication fail
            return HttpResponse("Unauthorized", status = 401)
        # If successful, log the user in
        login(request, user)
        # Get the associated player profile, or create one 
        try:
            player = Player.objects.get(user = user)
        except Player.DoesNotExist:
            player = Player(user = user)
            player.save()
        # Save player ID info in session
        request.session['player_id'] = player.id
        # Get associated character
        try:
            character_list = PlayerToCharacters.objects.get(player = player)
        except PlayerToCharacters.DoesNotExist:
            return JsonResponse({'hasCharacter': False})
        # This is currently unnecessary, but in here for when an account could
        # have multiple characters
        character = character_list.character
        # Mark user as logged in
        character.is_logged_in = True
        character.save()
        # Save character in session
        request.session['character_id'] = character.id
        res = {
            'hasCharacter': True,
            'first_name': character.first_name,
            'last_name': character.last_name,
            'location': character.location.code_name #Is this needed anywhere on the front end? Or just save it to session
        }
        return JsonResponse(res)

@csrf_exempt
@login_required
def sign_out(request):
    '''
    sign_out
    Sign the user out
    Argument: request
    Return value: HttpResponse
    '''
    # Mark user as logged out in the database
    Character.objects.filter(pk = request.session['character_id']).update(is_logged_in = False)
    logout(request)
    return HttpResponse()

@csrf_exempt
@login_required
def create_character(request):
    if request.method == 'POST':
        '''
        create_character
        Create and save a character into the database.
        Argument: request, body contains 'first_name', 'last_name'
        Side effect: Mark character as in CHARGEN
        Return value: HttpResponse
        '''
        data = json.loads(request.body)
        player_id = request.session['player_id']
        player = Player.objects.get(pk = player_id)
        # Create the character
        character = Character(first_name = data['first_name'], last_name = data['last_name'], location = CHARGEN, is_logged_in = True)
        character.save()
        playerToCharacter = PlayerToCharacters(player = player, character = character)
        playerToCharacter.save()
        # Save character id in session
        request.session['character_id'] = character.id
    return HttpResponse()
