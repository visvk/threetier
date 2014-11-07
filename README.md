#Three tier application architecture

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

* coffee api/dataTier/run.coffee (APis will be running on port 3000)

##Run Worker (dev)

* coffee dataTier/run.coffee

You can test it with http://localhost:3000/test in browser.