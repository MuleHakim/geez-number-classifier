from rest_framework.serializers import ModelSerializer
from .models import NumbersImage
class GeezNumberSerializer(ModelSerializer):
    class Meta:
        model = NumbersImage
        fields ="__all__"

