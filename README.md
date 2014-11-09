#Three tier application architecture

## UI Tier
(Not implemented yet)

## Business Tier
/server/api
REST API (Express.js)

## Data Tier
/server/worker
Queue worker (Node.js with cluster)

##Installation
* Dependencies
	- node.js
	- coffeeScript
	- npm
	- redis

* Install modules with npm
In server/api and in server/dataTier run command
	- npm install

##Run REST API (dev)
/server/api/
cluster, without cluster and simple api without kue MQ
run only one api at the time

* coffee run_cluster.coffee (APis will be running on port 3000)
* coffee run_nocluster.coffee (APis will be running on port 3000)
* coffee run_simple.coffee (APis will be running on port 3000)

##Run Worker (dev)
/server/worker/

* coffee run.coffee

## Test
You can test it with http://localhost:3000/test in browser.
Simple test with mocha in test/ directory.

ab -n 100 -c 50 http://localhost:3000/test  
This is ApacheBench, Version 2.3 <$Revision: 1528965 $>

### API Cluster (4 servers) with Kue MQ (12 servers)

```
Concurrency Level:      50
Time taken for tests:   4.656 seconds
Complete requests:      100
Failed requests:        0
Total transferred:      20900 bytes
HTML transferred:       2100 bytes
Requests per second:    21.48 [#/sec] (mean)
Time per request:       2328.042 [ms] (mean)
Time per request:       46.561 [ms] (mean, across all concurrent requests)
Transfer rate:          4.38 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    1   0.9      1       3
Processing:   597 1763 557.0   2028    2609
Waiting:      592 1763 557.2   2028    2609
Total:        600 1764 556.3   2029    2610

Percentage of the requests served within a certain time (ms)
  50%   2029
  66%   2040
  75%   2054
  80%   2107
  90%   2447
  95%   2471
  98%   2598
  99%   2610
 100%   2610 (longest request)
```

### API (1 server) with Kue MQ (12 servers)
```
Concurrency Level:      50
Time taken for tests:   4.697 seconds
Complete requests:      100
Failed requests:        0
Total transferred:      20900 bytes
HTML transferred:       2100 bytes
Requests per second:    21.29 [#/sec] (mean)
Time per request:       2348.259 [ms] (mean)
Time per request:       46.965 [ms] (mean, across all concurrent requests)
Transfer rate:          4.35 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    0   0.4      0       1
Processing:   620 1784 553.1   2035    2649
Waiting:      620 1784 553.1   2034    2649
Total:        621 1785 552.8   2035    2649

Percentage of the requests served within a certain time (ms)
  50%   2035
  66%   2046
  75%   2053
  80%   2162
  90%   2459
  95%   2488
  98%   2638
  99%   2649
 100%   2649 (longest request)
```

### simple API (1 server) without Kue MQ and Cluster
```
Concurrency Level:      50
Time taken for tests:   1.080 seconds
Complete requests:      100
Failed requests:        0
Total transferred:      20400 bytes
HTML transferred:       1600 bytes
Requests per second:    92.59 [#/sec] (mean)
Time per request:       540.038 [ms] (mean)
Time per request:       10.801 [ms] (mean, across all concurrent requests)
Transfer rate:          18.44 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    1   1.2      1       4
Processing:   505  531  13.3    526     554
Waiting:      505  531  13.3    526     554
Total:        506  532  12.9    526     555

Percentage of the requests served within a certain time (ms)
  50%    526
  66%    541
  75%    542
  80%    543
  90%    548
  95%    554
  98%    555
  99%    555
 100%    555 (longest request)
 ```