redis = require 'redis'
conf = require './conf.defaults'
node_client = require 'node-statsd-client'

try
  conf = require './conf'
catch error


# Only connects to one statsd server for now
sdc = new node_client.Client(conf.statsd.host, conf.statsd.port)
#  host: conf.statsd.host
#  port: conf.statsd.port

rootLabel = 'redis.all.'


# One redis-statsd client may operate for many redis servers
for redis_server in conf.redis_servers

  do (redis_server) ->

    host = redis_server.host
    port = redis_server.port

    redis_cli = redis.createClient port, host
    localLabel = 'redis.'
    localLabel += host.replace /\./g, ''
    localLabel += '.' + port + '.'

    if redis_server.password
      redis_cli.auth(redis_server.password)

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
                sdc.gauge localLabel + label, number

                # And also gauge for all?
                sdc.gauge rootLabel + label, number

              # And that it's in the configured gauge list
              if conf.set.indexOf(label) isnt -1

                # Then we gauge it.
                sdc.set localLabel + label, number

                # And also gauge for all?
                sdc.set rootLabel + label, number

    do_stats()

    setInterval do_stats, conf.interval
