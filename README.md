# Treadmill
![Treadmill](http://rack.0.mshcdn.com/media/ZgkyMDEzLzA5LzA5L2E5L2J1cm4uZWRjMjcuZ2lmCnAJdGh1bWIJODUweDg1MD4KZQlqcGc/cd80cbe2/1f8/burn.jpg)

## About
Treadmill is a small isolated load test against a locally (non-Cloud Foundry) deployed [gorouter](https://github.com/cloudfoundry/gorouter) using [boom](https://github.com/rakyll/boom).

The purpose is to run a short stress test and capture how many requests / second gorouter can handle.

This small load test uses:

- [gorouter](https://github.com/cloudfoundry/gorouter) (duh)
- [gnatsd](https://github.com/nats-io/gnatsd) (nats server)
- [nats](https://rubygems.org/gems/nats) (nats client for registering routes)
- a sample golang app
- [boom](https://github.com/rakyll/boom)
- [a little love](http://giphy.com/gifs/ping-pong-cat-table-tennis-sz3pnTuOYyupa/fullscreen)

## Usage:

    $ bin/run.sh <path to gorouter source> [total # requests] [# concurrent]

For example: 20000 requests / 100 concurrent

    $ bin/run.sh ~/workspace/cf-release/src/github.com/cloudfoundry/gorouter 20000 100

Example output:
```
TREADMILL - gorouter stress test

GOROUTER_DIR: /tmp/build/1f674be5/src/github.com/cloudfoundry/gorouter
TOTAL_REQUESTS: 20000
TOTAL_CONCURRENT: 100
Installing stuff..
github.com/tools/godep (download)
github.com/tools/godep/Godeps/_workspace/src/github.com/kr/text
github.com/tools/godep/Godeps/_workspace/src/github.com/pmezard/go-difflib/difflib
github.com/tools/godep/Godeps/_workspace/src/github.com/kr/fs
github.com/tools/godep/Godeps/_workspace/src/golang.org/x/tools/go/vcs
github.com/tools/godep/Godeps/_workspace/src/github.com/kr/pretty
github.com/tools/godep
Successfully installed daemons-1.2.3
Building native extensions.  This could take a while...
Successfully installed eventmachine-1.0.7
Successfully installed rack-1.6.4
Building native extensions.  This could take a while...
Successfully installed thin-1.6.4
Successfully installed nats-0.6.0
Parsing documentation for daemons-1.2.3
Installing ri documentation for daemons-1.2.3
Parsing documentation for eventmachine-1.0.7
Installing ri documentation for eventmachine-1.0.7
Parsing documentation for rack-1.6.4
Installing ri documentation for rack-1.6.4
Parsing documentation for thin-1.6.4
Installing ri documentation for thin-1.6.4
Parsing documentation for nats-0.6.0
Installing ri documentation for nats-0.6.0
Done installing documentation for daemons, eventmachine, rack, thin, nats after 7 seconds
5 gems installed
Starting NATS..
Building sample app
[478] 2016/03/24 15:31:55.816419 [INF] Starting gnatsd version 0.7.9
[478] 2016/03/24 15:31:55.816837 [INF] Listening for client connections on 0.0.0.0:4222
[478] 2016/03/24 15:31:55.817523 [INF] server is ready
Deploying apps..
Starting registrar..
Change to gorouter dir
Restoring godeps..
Published [router.register] : '{"host":"127.0.0.1","port":4567,"uris":["demo.vcap.me"]}'
Published [router.register] : '{"host":"127.0.0.1","port":4568,"uris":["demo.vcap.me"]}'
Published [router.register] : '{"host":"127.0.0.1","port":4569,"uris":["demo.vcap.me"]}'
Building gorouter..
Starting gorouter..
  sleeping for a few seconds to ensure app routes are registered..
{"timestamp":"1458833553.032208920","source":"gorouter.stdout","message":"gorouter.stdout.setting-up-nats-connection","log_level":1,"data":{}}
{"timestamp":"1458833553.034670115","source":"gorouter.stdout","message":"gorouter.stdout.router.Component Router registered successfully","log_level":1,"data":{"session":"5"}}
{"timestamp":"1458833553.035420656","source":"gorouter.stdout","message":"gorouter.stdout.router.Waiting 5s before listening...","log_level":1,"data":{"session":"5"}}
{"timestamp":"1458833558.035887003","source":"gorouter.stdout","message":"gorouter.stdout.router.Listening on [::]:8081","log_level":1,"data":{"session":"5"}}
{"timestamp":"1458833558.036063910","source":"gorouter.stdout","message":"gorouter.stdout.router.gorouter.started","log_level":1,"data":{"session":"5"}}
Starting load test
Summary:
  Total:	11.8816 secs
  Slowest:	0.2471 secs
  Fastest:	0.0013 secs
  Average:	0.0581 secs
  Requests/sec:	1683.2705
  Total data:	280000 bytes
  Size/request:	14 bytes

Status code distribution:
  [200]	20000 responses

Response time histogram:
  0.001 [1]	|
  0.026 [1960]	|∎∎∎∎∎∎∎∎∎∎
  0.050 [7292]	|∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  0.075 [6141]	|∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  0.100 [2869]	|∎∎∎∎∎∎∎∎∎∎∎∎∎∎∎
  0.124 [1101]	|∎∎∎∎∎∎
  0.149 [369]	|∎∎
  0.173 [175]	|
  0.198 [64]	|
  0.223 [20]	|
  0.247 [8]	|

Latency distribution:
  10% in 0.0261 secs
  25% in 0.0382 secs
  50% in 0.0528 secs
  75% in 0.0728 secs
  90% in 0.0964 secs
  95% in 0.1141 secs
  99% in 0.1575 secs

complete
killing gorouter..
killing apps..
killing registrar..
killing gnatsd..
Bye.
```

