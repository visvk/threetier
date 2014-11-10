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
	- redis

* Install modules with npm
In server/api and in server/worker run command
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
Time taken for tests:   1.404 seconds
Complete requests:      100
Failed requests:        0
Total transferred:      20900 bytes
HTML transferred:       2100 bytes
Requests per second:    71.22 [#/sec] (mean)
Time per request:       702.070 [ms] (mean)
Time per request:       14.041 [ms] (mean, across all concurrent requests)
Transfer rate:          14.54 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    1   0.7      1       2
Processing:   513  651  88.6    619     801
Waiting:      513  650  88.7    618     800
Total:        513  651  89.1    619     801

Percentage of the requests served within a certain time (ms)
  50%    619
  66%    716
  75%    750
  80%    763
  90%    784
  95%    792
  98%    801
  99%    801
 100%    801 (longest request)

```

### API (1 server) with Kue MQ (12 servers)
```
Concurrency Level:      50
Time taken for tests:   1.468 seconds
Complete requests:      100
Failed requests:        0
Total transferred:      20900 bytes
HTML transferred:       2100 bytes
Requests per second:    68.12 [#/sec] (mean)
Time per request:       733.972 [ms] (mean)
Time per request:       14.679 [ms] (mean, across all concurrent requests)
Transfer rate:          13.90 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    1   0.7      1       2
Processing:   573  697  57.7    689     784
Waiting:      572  697  57.8    689     783
Total:        573  698  58.1    690     784

Percentage of the requests served within a certain time (ms)
  50%    690
  66%    741
  75%    752
  80%    761
  90%    776
  95%    783
  98%    784
  99%    784
 100%    784 (longest request)

```

### simple API (1 server) without Kue MQ and Cluster
```
Concurrency Level:      50
Time taken for tests:   1.116 seconds
Complete requests:      100
Failed requests:        0
Total transferred:      20400 bytes
HTML transferred:       1600 bytes
Requests per second:    89.61 [#/sec] (mean)
Time per request:       557.960 [ms] (mean)
Time per request:       11.159 [ms] (mean, across all concurrent requests)
Transfer rate:          17.85 [Kbytes/sec] received

Connection Times (ms)
              min  mean[+/-sd] median   max
Connect:        0    2   1.6      2       5
Processing:   524  546  10.1    547     568
Waiting:      523  546  10.1    547     568
Total:        530  548   9.0    547     570

Percentage of the requests served within a certain time (ms)
  50%    547
  66%    553
  75%    555
  80%    556
  90%    558
  95%    561
  98%    569
  99%    570
 100%    570 (longest request)
 ```