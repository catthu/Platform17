from django.shortcuts import render

from generics.models import *

# Create your views here.

def index(request):
    page = Room.objects.get(pk = 3)
    context = {'page': page}
    return render(request, 'terminal/index.html', context)

    
