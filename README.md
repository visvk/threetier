#Three tier application architecture
GIT: https://github.com/visvk/threetier.git

FrontEnd: Angular.js
BackEnd: Node.js
Server-server communication: Redis Job Queue (google: npm Kue)

Tested on: 
	- Heroku
	- Modulus
	- Cloud Foundry - Pivotal WS
	- Exoscale

Referred to: 
Christoph Fehling , Frank Leymann: Cloud Computing Patterns

online: ```http://www.cloudcomputingpatterns.org/Three-Tier_Cloud_Application```

## UI (Presentation) Tier
Angular.js + Express.js REST API and Web Sockets - UI Component

## Business Logic Tier
Node.js Process component

## Data Tier
Node.js Job worker

##Installation
* Dependencies
	- node.js
	- coffeeScript
	- redis

* Install modules with npm install

* Compile coffee script to js/ folder
```
grunt compile
```
	
##Run UI Tier

* coffee tier_ui/run.coffee
or 
* node js/tier_ui/run.js

##Run Business Tier (dev)

* coffee tier_business/run.coffee
or 
* node js/tier_business/run.js

##Run Data Tier (dev)

* coffee tier_data/run.coffee
or 
* node js/tier_data/run.js

## Test
You can test it with http://localhost:8080/api/test  in browser.

Functional test: 
```grunt test```
Non Functional test (Linux Apache HTTP server benchmarking tool): 
```ab -n 100 -c 50 http://localhost:8080/api/test  ```

###Heroku
Dependencies: RedisToGo Addon, Heroku CLI, Heroku free plan
set NPM_CONFIG to false for install npm dev dependencies (bower)

Set env-variables (REDISTOGO_URL or DOREDIS_URL)

```
git checkout heroku
heroku push heroku heroku:master
heroku config:set NODE_ENV=production
heroku config:set NPM_CONFIG_PRODUCTION=false
heroku ps:scale bandd=1 
```

###Modulus (Not supporting web-worker model)
Dependencies: Redis instance(not available on modulus), Modulus CLI, Modulus basic plan

Start Guide 
```
http://help.modulus.io/customer/portal/articles/1640060-getting-started-guide
```
Set env-variables (REDISTOGO_URL or DOREDIS_URL)
```
git checkout modulus
modulus env set REDISTOGO_URL redistogourlvalue
modulus project restart
```

##Apfog (Not working yet)

Install Appfog CLI

```
af push
```

## Cloud Foundry - Pivotal web services

```
git checkout cloudfoundry-pivotal
```
Download CF CLI and type:
```
cf login -a https://api.run.pivotal.io
```
set env-variables (REDISTOGO, TODO: add PWS Redis addon)
```
cf set-env web REDISTOGO_URL VALUE
cf set-env worker REDISTOGO_URL VALUE
```
Deploy application (web and worker)

```
cf push
```
OR
```
cf push web
cf push worker
```

## Exoscale (Swiss cloud)

Install exoapp cli and create app (threetier, exoscale branch)

```
https://github.com/exoscale/apps-documentation/blob/master/Platform%20Documentation.md
```
set env-variables (DOREDIS_URL redis instance URL, default port is 6379, or REDISTOGO_URL)
```
exoapp threetier/exoscale config.add DOREDIS_URL=value
```

Deploy app

```
exoapp threetier/exoscale push
exoapp threetier/exoscale deploy
exoapp threetier/exoscale worker.add business
exoapp threetier/exoscale worker.add data
```
