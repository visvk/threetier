kue = require "kue"

logger = require '../lib/logger'
if process.env.DOREDIS_URL
  redisOptions =
    port: 6379
    host: process.env.DOREDIS_URL

else if process.env.REDISTOGO_URL
  rtg   = require("url").parse(process.env.REDISTOGO_URL);
  redisOptions =
    port: rtg.port
    host: rtg.hostname
    auth: rtg.auth.split(":")[1]
else
  redisOptions =
    port: 6379
    host: '127.0.0.1'


module.exports =
  businessToData: kue.createQueue({
    prefix: 'b2d',
    redis: redisOptions
  })
  uiToBusiness: kue.createQueue({
    prefix: 'u2b',
    redis: redisOptions
  })

