from django.shortcuts import render
from django.contrib.auth.models import User
from django.contrib.auth import authenticate, login
from django.http import JsonResponse, HttpResponse
from django.views.decorators.csrf import csrf_exempt
import json
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
        new_user.save()
    return HttpResponse()

@csrf_exempt
def sign_in(request):
    if request.method == 'POST':
        data = json.loads(request.body)
        user = authenticate(username = data['username'], password = data['password'])
        if user == None:
            return HttpResponse("Unauthorized", status = 401)
        login(request, user)
        return JsonResponse({'id': user.id})