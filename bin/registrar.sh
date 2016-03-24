#!/bin/sh
while true; do
   nats-pub 'router.register' '{"host":"127.0.0.1","port":4567,"uris":["demo.vcap.me"]}'
   nats-pub 'router.register' '{"host":"127.0.0.1","port":4568,"uris":["demo.vcap.me"]}'
   nats-pub 'router.register' '{"host":"127.0.0.1","port":4569,"uris":["demo.vcap.me"]}'
   sleep 20
done
