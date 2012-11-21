redis = require 'redis'
sdc = require('statsd-client').getOneClient
  host: 'localhost'
  port: 8125

redis_cli = redis.createClient process.env.REDIS_PORT, process.env.REDIS_HOST


do_stats = ->
  redis_cli.info (err, reply) ->
    reply = reply.split /\r\n/
    console.log err, reply

do_stats()

setInterval do_stats, 10000
