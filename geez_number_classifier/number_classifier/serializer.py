from .models import NumbersImage
from rest_framework import serializers

class ImageSerializer(serializers.HyperlinkedModelSerializer):
    class Meta:
        model = NumbersImage
        fields = ["id","title","image_url","creation_date"]
        