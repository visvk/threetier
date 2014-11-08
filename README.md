#Three tier application architecture

## UI Tier
(Not implemented yet)

## Business Tier
/server/api
REST API (Express.js with node cluster)

## Data Tier
/server/worker - data tier
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

* coffee run.coffee (APis will be running on port 3000)

##Run Worker (dev)
/server/worker/

* coffee run.coffee

You can test it with http://localhost:3000/test in browser.