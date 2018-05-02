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
kairosdb_server = "http://172.30.132.244:8080"

ItemNum=10000

def get_value(num):
    return random.randint(0,10000000)
# Simple test [without compression]

def main():
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
if __name__ == "__main__":
    start = time.time()
    main()
    Item=ItemNum
    Time=(time.time()-start)
    Average=Item/Time
    print("The total item is: %f" % Item)
    print("The elapse time is: %f s" % Time)
    print("The average rate is: %f Item/s" % Average)

