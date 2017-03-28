from django.shortcuts import render
from django.contrib.auth.models import User
from django.http import JsonResponse
from .models import *
# Create your views here.

def username_exists(request, username):
    try:
        existing_user = User.objects.get(username__iexact = username)
        print existing_user
    except User.DoesNotExist:
        return JsonResponse({'username_exists': False})
    return JsonResponse({'username_exists': True})
