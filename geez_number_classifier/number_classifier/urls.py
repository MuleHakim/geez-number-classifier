from django.urls import path,include
from .views import creat_numbers,predict
urlpatterns = [
    path('create/',creat_numbers,name='createnumbers'),
    path('predict/',predict,name='predict'),
] 



