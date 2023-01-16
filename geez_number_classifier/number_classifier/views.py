from django.shortcuts import render
from .random_forest import RandomForest
from rest_framework import viewsets
from .serializer import ImageSerializer
from rest_framework import permissions
from .models import NumbersImage
from rest_framework.parsers import MultiPartParser,FormParser
from django.http import JsonResponse
import os


class ImageViewset(viewsets.ModelViewSet):
    queryset = NumbersImage.objects.order_by('-creation_date')
    serializer_class = ImageSerializer
    parser_class = (MultiPartParser,FormParser)
    permission_classes = [
        permissions.IsAuthenticatedOrReadOnly]
    
def PredictViewset(request):
    image_view = ImageViewset()
    queryset = image_view.queryset
    if queryset:
        data = queryset.values()
        image_info = data[0]
        image_url = os.path.join('numbers/',image_info["image_url"])
        
        random_forest = RandomForest()
        image = random_forest.read_image(image_url)
        number = random_forest.re_shape(image).reshape(784)
        predicted = random_forest.predict_number(number)


        return JsonResponse({'predicted': str(predicted[0])})
    return JsonResponse()


         


        
        
        

    


