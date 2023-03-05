from rest_framework.decorators import api_view
from rest_framework.response import Response
from .cnn import Cnn
from .serializer import GeezNumberSerializer
from .models import NumbersImage
import os

@api_view(["POST"])
def creat_numbers(request):
    data = request.data
    geez_number = NumbersImage.objects.create(
        image_url= data['image_url'],
        creation_date = data["creation_date"]                   
    )
    serializer = GeezNumberSerializer(geez_number,many=False)
    return Response(serializer.data)

@api_view(["GET"])
def predict(request):
    geez_numbers = NumbersImage.objects.order_by('-creation_date')
    image_path = geez_numbers[0].image_url
    
    image_path = os.path.join('numbers/',str(image_path))
    cnn = Cnn()
    image = cnn.read_image(image_path)
    number = cnn.re_shape(image).reshape(784)
    
    predicted = cnn.predict_number(number)

    
    return Response(f'{predicted}')
















         


        
        
        

    


