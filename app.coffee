redis = require 'redis'
sdc = require 'statsd-client'

redis_cli = redis.createClient process.env.REDIS_PORT, process.env.REDIS_HOST

redis_cli.info (err, reply) ->
  console.log err, reply
