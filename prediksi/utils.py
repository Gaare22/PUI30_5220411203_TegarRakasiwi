import joblib
import os
from django.conf import settings

def load_model():
    model_path = os.path.join(settings.BASE_DIR, 'tmp', 'model_nb.pkl')
    return joblib.load(model_path)

def predict_from_input(input_data):
    model = load_model()
    prediction = model.predict([input_data])
    return prediction[0]
