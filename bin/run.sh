#!/bin/sh

if [ -n "${GOROUTER_DIR+1}" ]; then
  echo "Gorouter dir: ${GOROUTER_DIR}"
else
  echo "GOROUTER_DIR env varirable is not defined"
  exit 1;
fi

echo "Installing stuff.."
# go stuff
go get github.com/apcera/gnatsd
go get github.com/rakyll/boom
# ruby stuff
gem install nats

echo "Starting NATS.."
gnatsd &

echo "Building sample app"
go build

echo "Deploying apps.."
bin/apps.sh

echo "Starting registrar.."
bin/registrar.sh &

# echo "Restoring godeps.."
# godep restore ./...

# echo "Change to gorouter dir"
# cd $GOROUTER_DIR

# echo "Building gorouter.."
# go install

# echo "Starting gorouter.."
# ./gorouter -c ./config/gorouter.yml &

# echo "\tsleeping for a few seconds.."
# sleep 25

# echo "Starting load test"
# echo -n "$i ," >> ~/out/loadtest.out
# boom -n 10-c 2 -x http://localhost:8081 http://demo.vcap.me  | grep -E "Requests/sec|responses" | tr -s "\n" "," | cut -f 2 -d ":" >> ~/out/loadtest.out
# echo ""
# echo "complete"

# echo "killing gorouter.."
# kill -9 `pgrep gorouter`

echo "killing apps.."
kill -9 `pgrep treadmill`

echo "killing registrar.."
kill -9 `pgrep registrar.sh`

echo "killing gnatsd.."
kill -9 `pgrep gnatsd`

echo "Bye."
