#Three tier application architecture
FrontEnd: Angular.js
BackEnd: Node.js

Tested on: 
	- Heroku

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
	
##Run UI Tier

* coffee tier_ui/run.coffee

##Run Business Tier (dev)

* coffee tier_business/run.coffee

##Run Data Tier (dev)

* coffee tier_data/run.coffee

## Test
You can test it with http://localhost:8080/api/test  in browser.

Functional test: 
```grunt test```
Non Functional test (Linux Apache HTTP server benchmarking tool): 
```ab -n 100 -c 50 http://localhost:8080/api/test  ```

###Heroku
Dependencies: RedisToGo Addon, Heroku CLI, Heroku free plan
set NPM_CONFIG to false for install npm dev dependencies (bower)
You must have RedisToGo addon and REDISTOGO_URL in heroku config

```
git checkout heroku
heroku push heroku heroku:master
heroku config:set NODE_ENV=production
heroku config:set NPM_CONFIG_PRODUCTION=false
heroku ps:scale bandd=1 
```

###Modulus
Dependencies: Redis instance(not available on modulus), Modulus CLI, Modulus basic plan with $15 free

Start Guide 
```
http://help.modulus.io/customer/portal/articles/1640060-getting-started-guide
```

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
Download CF CLI

```
cf push
```



