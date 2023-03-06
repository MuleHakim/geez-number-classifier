import joblib
import cv2 as cv
import os
from pathlib import Path
import keras

import numpy as np
BASE_DIR = Path(__file__).resolve().parent.parent.parent
class Cnn:
    def __init__(self) -> None:
        self.classifier = joblib.load("model_training/cnn.joblib",'r')
    
    def read_image(sel,image_url):
        image = cv.imread(os.path.join(BASE_DIR,image_url), 0)
        return image
    def re_shape(self,image):
        image = cv.resize(image,(28,28))
        return image
    def predict_number(self,number):
        
        word_dict = {0:'0',1:'1',2:'2',3:'3',4:'4',5:'5',6:'6',7:'7',8:'8',9:'9',10:"10",11:'11',12:'12',13:'13',14:'14',15:'15',16:'16',17:'17',18:'18',19:'19'}        
        img_final =np.reshape(number, (-1,28,28,1))
        predicted = word_dict[np.argmax(self.classifier.predict(img_final))]
         
        return predicted
        