from django.urls import path,include
from rest_framework import routers
from .views import ImageViewset
from .views import PredictViewset
router = routers.DefaultRouter()
router.register(r'numbers',ImageViewset)
urlpatterns = [
    path('',include(router.urls)),
    path('api-auth/',include('rest_framework.urls',namespace='rest_framework')),
    path('predict/',PredictViewset,name='predict'),
]
