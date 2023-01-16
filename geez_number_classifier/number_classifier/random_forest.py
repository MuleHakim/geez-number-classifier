import joblib
import cv2 as cv
import os
from pathlib import Path
BASE_DIR = Path(__file__).resolve().parent.parent.parent
class RandomForest:
    def __init__(self) -> None:
        self.classifier = joblib.load("model_training/forest_clf.joblib",'r')
    def read_image(sel,image_url):
        image = cv.imread(os.path.join(BASE_DIR,image_url),0)
        return image
    def re_shape(self,image):
        image = cv.resize(image,(28,28))
        return image
    def predict_number(self,number):
        predicted = self.classifier.predict([number])
        return predicted
        