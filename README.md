# Treadmill
![Treadmill](http://rack.0.mshcdn.com/media/ZgkyMDEzLzA5LzA5L2E5L2J1cm4uZWRjMjcuZ2lmCnAJdGh1bWIJODUweDg1MD4KZQlqcGc/cd80cbe2/1f8/burn.jpg)

## About
Treadmill is a load test against a locally deployed [gorouter](https://github.com/cloudfoundry/gorouter) using [boom](https://github.com/rakyll/boom).

The purpose is to run a short stress test and capture how many requests / second gorouter can handle.

This small load test uses:

- gorouter (duh)
- gnatsd
- nats (ruby)
- a sample golang app
- boom
- a little love
