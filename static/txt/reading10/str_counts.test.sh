#!/bin/bash

WORKSPACE=/tmp/str_counts.$(id -u)
PROGRAM=str_counts
FAILURES=0
POINTS=1

pipeline() {
    echo "$@" | grep -Eio '[a-z]' | sort | uniq -c
}

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

echo "Checking reading10 $PROGRAM ..."

ARGUMENTS=""
printf " %-40s ... " "$PROGRAM $ARGUMENTS"
echo $ARGUMENTS | valgrind --leak-check=full ./$PROGRAM $ARGUMENTS > $WORKSPACE/test.stdout 2> $WORKSPACE/test.stderr
if [ $? -ne 0 ]; then
    error "Failure (Status)"
elif ! diff -W 80 -y $WORKSPACE/test.stdout <(pipeline $ARGUMENTS) > $WORKSPACE/test.diff; then
    error "Failure (Output)"
elif [ $(awk '/ERROR SUMMARY:/ {print $4}' $WORKSPACE/test.stderr) -ne 0 ]; then
    error "Failure (Valgrind)"
else
    echo "Success"
fi
rm -f $WORKSPACE/test.diff

ARGUMENTS="hello world"
printf " %-40s ... " "$PROGRAM $ARGUMENTS"
echo $ARGUMENTS | valgrind --leak-check=full ./$PROGRAM $ARGUMENTS > $WORKSPACE/test.stdout 2> $WORKSPACE/test.stderr
if [ $? -ne 0 ]; then
    error "Failure (Status)"
elif ! diff -W 80 -y $WORKSPACE/test.stdout <(pipeline $ARGUMENTS) > $WORKSPACE/test.diff; then
    error "Failure (Output)"
elif [ $(awk '/ERROR SUMMARY:/ {print $4}' $WORKSPACE/test.stderr) -ne 0 ]; then
    error "Failure (Valgrind)"
else
    echo "Success"
fi
rm -f $WORKSPACE/test.diff

ARGUMENTS="obscure"
printf " %-40s ... " "$PROGRAM $ARGUMENTS"
echo $ARGUMENTS | valgrind --leak-check=full ./$PROGRAM $ARGUMENTS > $WORKSPACE/test.stdout 2> $WORKSPACE/test.stderr
if [ $? -ne 0 ]; then
    error "Failure (Status)"
elif ! diff -W 80 -y $WORKSPACE/test.stdout <(pipeline $ARGUMENTS) > $WORKSPACE/test.diff; then
    error "Failure (Output)"
elif [ $(awk '/ERROR SUMMARY:/ {print $4}' $WORKSPACE/test.stderr) -ne 0 ]; then
    error "Failure (Valgrind)"
else
    echo "Success"
fi
rm -f $WORKSPACE/test.diff

ARGUMENTS="reasonable exam"
printf " %-40s ... " "$PROGRAM $ARGUMENTS"
echo $ARGUMENTS | valgrind --leak-check=full ./$PROGRAM $ARGUMENTS > $WORKSPACE/test.stdout 2> $WORKSPACE/test.stderr
if [ $? -ne 0 ]; then
    error "Failure (Status)"
elif ! diff -W 80 -y $WORKSPACE/test.stdout <(pipeline $ARGUMENTS) > $WORKSPACE/test.diff; then
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
