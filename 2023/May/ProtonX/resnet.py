
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Dense
from tensorflow.keras.layers.experimental.preprocessing import Resizing
resnet_url = "https://tfhub.dev/google/imagenet/resnet_v2_50/feature_vector/4" 

resnet = Sequential()
resnet.add(Resizing(224, 224, input_shape=INP_SHAPE))
resnet.add(hub.KerasLayer(resnet_url, trainable=False))
resnet.add(Dense(1, activation="sigmoid"))
resnet.summary()
resnet.compile(optimizer="rmsprop", loss="binary_crossentropy", metrics=["acc"])
resnet_history = resnet.fit(ds_train, epochs=15, validation_data=ds_val)