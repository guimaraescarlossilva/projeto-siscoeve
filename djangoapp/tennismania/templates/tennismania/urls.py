from django.urls import path
from tennismania.views import index

app_name = 'tennismania'

urlpatterns = [
    path('', index, name='index'),
]
