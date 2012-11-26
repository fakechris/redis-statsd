redis = require 'redis'
conf = require './conf.defaults'

try
  conf = require './conf'
catch error
  

# Only connects to one statsd server for now
sdc = require('statsd-client').getOneClient
  host: conf.statsd.host
  port: conf.statsd.port


# One redis-statsd client may operate for many redis servers
for redis_server in conf.redis_servers

  host = redis_server.host
  port = redis_server.port

  redis_cli = redis.createClient port, host
  preLabel = 'redis.'
  preLabel += host + port + '.'

  # Our periodic function
  do_stats = ->
    redis_cli.info (err, reply) ->

      # We get a giant text object as "reply"

      # First we split that on line breaks
      reply_items = reply.split /\r\n/
      for item in reply_items

        # Then we split those on their : delimeter
        item_split = item.split ':'
        if item_split.length > 1
          number = parseFloat item_split[1]
          label = item_split[0]

          # We make sure it's a number for the value
          if number + '' isnt 'NaN'

            # And that it's in the configured gauge list
            if conf.gauge.indexOf(label) isnt -1

              # Then we gauge it.
              sdc.gauge preLabel + label, number

  do_stats()

  setInterval do_stats, conf.interval
