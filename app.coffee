redis = require 'redis'
sdc = require('statsd-client').getOneClient
  host: 'localhost'
  port: 8125

host = process.env.REDIS_HOST or 'localhost'
port = process.env.REDIS_PORT or 6379

redis_cli = redis.createClient port, host
preLabel = 'redis.'
preLabel += host + port + '.'

do_stats = ->
  redis_cli.info (err, reply) ->
    reply_items = reply.split /\r\n/
    for item in reply_items
      item_split = item.split ':'
      if item_split.length > 1
        number = parseFloat item_split[1]
        label = item_split[0]
        if number + '' isnt 'NaN'
          sdc.gauge preLabel + label, number

do_stats()

setInterval do_stats, 10000
