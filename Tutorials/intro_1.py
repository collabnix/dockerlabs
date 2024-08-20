import pandas as pd 

import matplotlib.pyplot as plt 

from sklearn.datasets import load_iris 

from sklearn.model_selection import train_test_split 

from sklearn.ensemble import RandomForestClassifier 

from sklearn.metrics import accuracy_score 

 

# Load the Iris dataset 

iris = load_iris() 

data = pd.DataFrame(data=iris.data, columns=iris.feature_names) 

target = pd.Series(data=iris.target) 

 

# Data Exploration 

print("Dataset Description:") 

print(data.describe()) 

 

# Data Visualization 

data.plot(kind='box', subplots=True, layout=(2, 2), sharex=False, sharey=False) 

plt.show() 

 

# Train-test split 

X_train, X_test, y_train, y_test = train_test_split(data, target, test_size=0.2, random_state=42) 

 

# Train a Random Forest Classifier 

rf_classifier = RandomForestClassifier(n_estimators=100, random_state=42) 

rf_classifier.fit(X_train, y_train) 

 

# Make predictions 

y_pred = rf_classifier.predict(X_test) 

 

# Calculate accuracy 

accuracy = accuracy_score(y_test, y_pred) 

print("Accuracy:", accuracy) 
