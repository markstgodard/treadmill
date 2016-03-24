#!/bin/sh

echo "Starting NATS.."
go get github.com/apcera/gnatsd
gnatsd &

echo "Building sample app"
go build

echo "Deploying apps.."
bin/apps.sh

echo "Starting registrar.."
bin/registrar.sh &

echo "Restoring godeps.."
godep restore ./...

echo "Building.."
go build

echo "Starting gorouter.."
./gorouter -c ./config/gorouter.yml &

echo "\tsleeping for a few seconds.."
sleep 25

echo "Starting load test"
echo -n "$i ," >> ~/out/loadtest.out
boom -n 10-c 2 -x http://localhost:8081 http://demo.vcap.me  | grep -E "Requests/sec|responses" | tr -s "\n" "," | cut -f 2 -d ":" >> ~/out/loadtest.out
echo ""
echo "complete"

echo "killing gorouter.."
kill -9 `pgrep gorouter`

echo "killing gnatsd.."
kill -9 `pgrep gnatsd`

echo "Bye."
