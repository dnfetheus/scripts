import requests
import json
import time
from multiprocessing.pool import ThreadPool as Pool
import os

with open("file.json") as file:
    links = json.load(file)['links']

i = 0

while True:
    pool = Pool(processes=os.cpu_count())
    pool.map(requests.get, links)

    i = i + 1

    print("Requisição {}".format(i))

