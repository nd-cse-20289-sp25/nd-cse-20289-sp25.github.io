#!/bin/bash

export PATH=/escnfs/home/pbui/pub/pkgsrc/bin:$PATH

# Configuration

SCRIPT=weather.sh
WORKSPACE=/tmp/$SCRIPT.$(id -u)
FAILURES=0
POINTS=4

# Functions

error() {
    echo "$@"
    [ -r $WORKSPACE/test ] && cat $WORKSPACE/test
    FAILURES=$((FAILURES + 1))
}

cleanup() {
    STATUS=${1:-$FAILURES}
    rm -fr $WORKSPACE
    exit $STATUS
}

weather() {
    python3 <<EOF
import requests

url         = "https://forecast.weather.gov/zipcity.php?inputstring=$1"
response    = requests.get(url)
temperature = None
forecast    = None

for line in response.text.splitlines():
    line = line.strip()
    if 'celsius' in "$2" and 'myforecast-current-sm' in line:
        temperature = line.split('>')[1].split('&')[0]
    
    if not 'celsius' in "$2" and 'myforecast-current-lrg' in line:
        temperature = line.split('>')[1].split('&')[0]
    
    if 'forecast' in "$2" and '"myforecast-current"' in line:
        forecast = line.split('>')[1].split('<')[0].strip()

print(f'Temperature: {temperature} degrees')
if forecast:
    print(f'Forecast:    {forecast}')
EOF
}

# Setup

mkdir $WORKSPACE

trap "cleanup" EXIT
trap "cleanup 1" INT TERM

# Tests

echo "Testing $SCRIPT ..."

printf "   %-40s ... " Usage
./$SCRIPT -h 2>&1 | grep -i usage 2>&1 > /dev/null
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf "   %-40s ... " Default
diff -u <(./$SCRIPT) <(weather 46556) > $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf "   %-40s ... " 46556
diff -u <(./$SCRIPT) <(weather 46556) > $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf "   %-40s ... " "46556 Celsius"
diff -u <(./$SCRIPT -c) <(weather 46556 celsius) > $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf "   %-40s ... " "46556 Forecast"
diff -u <(./$SCRIPT -f) <(weather 46556 forecast) > $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf "   %-40s ... " "46556 Celsius Forecast"
diff -u <(./$SCRIPT -c -f) <(weather 46556 "celsius forecast") > $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf "   %-40s ... " 54701
diff -u <(./$SCRIPT 54701) <(weather 54701) > $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf "   %-40s ... " "54701 Celsius"
diff -u <(./$SCRIPT -c 54701) <(weather 54701 celsius) > $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf "   %-40s ... " "54701 Forecast"
diff -u <(./$SCRIPT -f 54701) <(weather 54701 forecast) > $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf "   %-40s ... " "54701 Celsius Forecast"
diff -u <(./$SCRIPT -c -f 54701) <(weather 54701 "celsius forecast") > $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf "   %-40s ... " 92869
diff -u <(./$SCRIPT 92869) <(weather 92869) > $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf "   %-40s ... " "92869 Celsius"
diff -u <(./$SCRIPT -c 92869) <(weather 92869 celsius) > $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf "   %-40s ... " "92869 Forecast"
diff -u <(./$SCRIPT -f 92869) <(weather 92869 forecast) > $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

printf "   %-40s ... " "92869 Celsius Forecast"
diff -u <(./$SCRIPT -f -c 92869) <(weather 92869 "celsius forecast") > $WORKSPACE/test
if [ $? -ne 0 ]; then
    error "Failure"
else
    echo "Success"
fi

TESTS=$(($(grep -c Success $0) - 2))

echo
echo "   Score $(echo "scale=4; ($TESTS - $FAILURES) / $TESTS.0 * $POINTS.0" | bc | awk '{printf "%0.2f\n", $1}') / $POINTS.00"
printf "  Status "
if [ $FAILURES -eq 0 ]; then
    echo "Success"
else
    echo "Failure"
fi
echo
