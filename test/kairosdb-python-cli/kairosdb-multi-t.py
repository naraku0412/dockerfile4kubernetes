#!/usr/bin/env python3
''' Insert data in KairosDB using REST API through requests module.

    Please, check out the documentation on the KairosDB website:
        http://kairosdb.github.io/docs/build/html/restapi/AddDataPoints.html
    @author Fernando Paladini <fnpaladini@gmail.com>
'''


import requests
import json
import gzip
import time
import random
import math
from multiprocessing import Pool
from multiprocessing.dummy import Pool as ThreadPool

kairosdb_server = "http://127.0.0.1:8080"

ItemNum=1000

def get_value(num):
    return random.randint(0,10000000)
# Simple test [without compression]

def func(j):
  a = int(time.time()) - ItemNum
  for i in range(1,ItemNum):
      data = [
              {
               "name": "test",
               "timestamp": a,
               "value": get_value(i),
                  "tags": {
                  "project": "rola"
                  }
               }
             ]
      a += 1
      response = requests.post(kairosdb_server + "/api/v1/datapoints", json.dumps(data))
def main():
    num=[1,2,3,4,5,6,7,8,9,10]
    pool = ThreadPool(6)
    results=pool.map(func,num)
    pool.close()
    pool.join()

if __name__ == "__main__":
    start = time.time()
    main()
    Item=ItemNum
    Time=(time.time()-start)
    Average=Item/Time
    print("The total item is: %f" % Item)
    print("The elapse time is: %f s" % Time)
    print("The average rate is: %f Item/s" % Average)

