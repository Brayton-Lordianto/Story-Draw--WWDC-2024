import tensorflow as tf
import coremltools as ct

# Load the TensorFlow .h5 model
# https://www.kaggle.com/datasets/olgabelitskaya/quick-draw-images-from-key-points/data
tf_model = tf.keras.models.load_model('your_model.h5')

# Convert the TensorFlow model to CoreML format
mlmodel = ct.convert(tf_model)

# Save the CoreML model to a file
mlmodel.save('sketchbot.mlmodel')
