#!/bin/bash

PROGRAM=seqit
WORKSPACE=/tmp/$PROGRAM.$(id -u)
FAILURES=0
POINTS=2

error() {
    echo "$@"
    echo
    case "$@" in
        *Output*)
        printf "%-40s%-40s\n" "PROGRAM OUTPUT" "EXPECTED OUTPUT"
        cat $WORKSPACE/test.diff
        ;;
        *Valgrind*)
        echo
        cat $WORKSPACE/test.stderr
        ;;
    esac
    FAILURES=$((FAILURES + 1))
}

cleanup() {
    STATUS=${1:-$FAILURES}
    rm -fr $WORKSPACE
    exit $STATUS
}

mkdir $WORKSPACE

trap "cleanup" EXIT
trap "cleanup 1" INT TERM

echo "Testing $PROGRAM ..."

ARGUMENTS="1"
printf " %-40s ... " "$PROGRAM $ARGUMENTS"
valgrind --leak-check=full ./$PROGRAM $ARGUMENTS > $WORKSPACE/test.stdout 2> $WORKSPACE/test.stderr
if [ $? -ne 0 ]; then
    error "Failure (Status)"
elif ! seq $ARGUMENTS | diff -W 80 -y $WORKSPACE/test.stdout - > $WORKSPACE/test.diff; then
    error "Failure (Output)"
elif [ $(awk '/ERROR SUMMARY:/ {print $4}' $WORKSPACE/test.stderr) -ne 0 ]; then
    error "Failure (Valgrind)"
else
    echo "Success"
fi
rm -f $WORKSPACE/test.diff

ARGUMENTS="10"
printf " %-40s ... " "$PROGRAM $ARGUMENTS"
valgrind --leak-check=full ./$PROGRAM $ARGUMENTS > $WORKSPACE/test.stdout 2> $WORKSPACE/test.stderr
if [ $? -ne 0 ]; then
    error "Failure (Status)"
elif ! seq $ARGUMENTS | diff -W 80 -y $WORKSPACE/test.stdout - > $WORKSPACE/test.diff; then
    error "Failure (Output)"
elif [ $(awk '/ERROR SUMMARY:/ {print $4}' $WORKSPACE/test.stderr) -ne 0 ]; then
    error "Failure (Valgrind)"
else
    echo "Success"
fi
rm -f $WORKSPACE/test.diff

ARGUMENTS="100"
printf " %-40s ... " "$PROGRAM $ARGUMENTS"
valgrind --leak-check=full ./$PROGRAM $ARGUMENTS > $WORKSPACE/test.stdout 2> $WORKSPACE/test.stderr
if [ $? -ne 0 ]; then
    error "Failure (Status)"
elif ! seq $ARGUMENTS | diff -W 80 -y $WORKSPACE/test.stdout - > $WORKSPACE/test.diff; then
    error "Failure (Output)"
elif [ $(awk '/ERROR SUMMARY:/ {print $4}' $WORKSPACE/test.stderr) -ne 0 ]; then
    error "Failure (Valgrind)"
else
    echo "Success"
fi
rm -f $WORKSPACE/test.diff

ARGUMENTS="1 100"
printf " %-40s ... " "$PROGRAM $ARGUMENTS"
valgrind --leak-check=full ./$PROGRAM $ARGUMENTS > $WORKSPACE/test.stdout 2> $WORKSPACE/test.stderr
if [ $? -ne 0 ]; then
    error "Failure (Status)"
elif ! seq $ARGUMENTS | diff -W 80 -y $WORKSPACE/test.stdout - > $WORKSPACE/test.diff; then
    error "Failure (Output)"
elif [ $(awk '/ERROR SUMMARY:/ {print $4}' $WORKSPACE/test.stderr) -ne 0 ]; then
    error "Failure (Valgrind)"
else
    echo "Success"
fi
rm -f $WORKSPACE/test.diff

ARGUMENTS="1 2 100"
printf " %-40s ... " "$PROGRAM $ARGUMENTS"
valgrind --leak-check=full ./$PROGRAM $ARGUMENTS > $WORKSPACE/test.stdout 2> $WORKSPACE/test.stderr
if [ $? -ne 0 ]; then
    error "Failure (Status)"
elif ! seq $ARGUMENTS | diff -W 80 -y $WORKSPACE/test.stdout - > $WORKSPACE/test.diff; then
    error "Failure (Output)"
elif [ $(awk '/ERROR SUMMARY:/ {print $4}' $WORKSPACE/test.stderr) -ne 0 ]; then
    error "Failure (Valgrind)"
else
    echo "Success"
fi
rm -f $WORKSPACE/test.diff

ARGUMENTS="100 -3 1"
printf " %-40s ... " "$PROGRAM $ARGUMENTS"
valgrind --leak-check=full ./$PROGRAM $ARGUMENTS > $WORKSPACE/test.stdout 2> $WORKSPACE/test.stderr
if [ $? -ne 0 ]; then
    error "Failure (Status)"
elif ! seq $ARGUMENTS | diff -W 80 -y $WORKSPACE/test.stdout - > $WORKSPACE/test.diff; then
    error "Failure (Output)"
elif [ $(awk '/ERROR SUMMARY:/ {print $4}' $WORKSPACE/test.stderr) -ne 0 ]; then
    error "Failure (Valgrind)"
else
    echo "Success"
fi
rm -f $WORKSPACE/test.diff


ARGUMENTS="1 2 3 4"
printf " %-40s ... " "$PROGRAM $ARGUMENTS"
valgrind --leak-check=full ./$PROGRAM $ARGUMENTS > $WORKSPACE/test.stdout 2> $WORKSPACE/test.stderr
if [ $? -eq 0 ]; then
    error "Failure (Status)"
elif ! grep -q -i "usage: $PROGRAM" $WORKSPACE/test.stderr; then
    error "Failure (Output)"
elif [ $(awk '/ERROR SUMMARY:/ {print $4}' $WORKSPACE/test.stderr) -ne 0 ]; then
    error "Failure (Valgrind)"
else
    echo "Success"
fi
rm -f $WORKSPACE/test.diff

TESTS=$(($(grep -c Success $0) - 2))

echo
echo "   Score $(echo "scale=4; ($TESTS - $FAILURES) / $TESTS.0 * $POINTS.0" | bc | awk '{printf "%0.2f\n", $1}') / $POINTS.00"
printf "  Status "
if [ $FAILURES -gt 0 ]; then
    echo "Failure"
else
    echo "Success"
fi
echo
