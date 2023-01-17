from datetime import datetime
from django.db import models
from .upload_image import upload_to

class NumbersImage(models.Model):
    title = models.CharField(max_length=80,blank=False,null=False)
    image_url = models.ImageField(upload_to=upload_to,blank = True,null=True)
    creation_date = models.DateTimeField(default=datetime.now())
    def __str__(self) -> str:
        return self.title