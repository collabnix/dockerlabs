import requests
import time
r = requests.get("http://127.0.0.1").text
while True:
    num = r.count("n")
    print("There are " + str(num) + " occurrences of 'n'")
