#!/usr/bin/python

import time
import math
import requests
import json
import random
from multiprocessing import Process,Pool
import os,time

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
    p = Pool(6)
    for i in range(8):
        p.apply_async(func,args=('Process'+str(i),))
    p.close()
    p.join()

if __name__ == "__main__":
    start = time.time()
    main()
    Item=ItemNum
    Time=(time.time()-start)
    Average=Item/Time
    print("The total item is: %f" % Item)
    print("The elapse time is: %f s" % Time)
    print("The average rate is: %f Item/s" % Average)
