#!/bin/sh

echo "TREADMILL - gorouter stress test"
echo ""
echo "GOPATH: ${GOPATH}"

if [ -n "${GOROUTER_DIR+1}" ]; then
  echo "GOROUTER_DIR: ${GOROUTER_DIR}"
else
  echo "GOROUTER_DIR env varirable is not defined"
  exit 1;
fi

APPDIR=$PWD

echo "Installing stuff.."
# go stuff
go get -v github.com/tools/godep
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

echo "Change to gorouter dir"
cd $GOROUTER_DIR

echo "Restoring godeps.."
godep restore ./...

echo "Building gorouter.."
go build

echo "Starting gorouter.."
./gorouter -c $APPDIR/config/gorouter.yml &

echo "  sleeping for a few seconds to ensure app routes are registered.."
sleep 25

echo "Starting load test"
boom -n 5000 -c 50 -x http://localhost:8081 http://demo.vcap.me
echo ""
echo "complete"

echo "killing gorouter.."
kill -9 `pgrep gorouter`

echo "killing apps.."
kill -9 `pgrep treadmill`

echo "killing registrar.."
kill -9 `ps ux | awk '/bin\/registrar.sh/ {print $2}'`

echo "killing gnatsd.."
kill -9 `pgrep gnatsd`

echo "Bye."
