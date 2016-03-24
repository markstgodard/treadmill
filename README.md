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

For example: 1000 requests / 50 concurrent

    $ bin/run.sh ~/workspace/cf-release/src/github.com/cloudfoundry/gorouter 1000 50


