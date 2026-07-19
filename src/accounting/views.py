from django.shortcuts import render

# Create your views here.
from.models import Category

def category_list(request):
    categories = Category.objects.all()
    return render(request, 'accounting/category_list.html', {'categories': categories})