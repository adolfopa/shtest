#! /bin/sh

__shtest_bin=$(dirname $0)
__shtest_test=$1
unset __shtest_test_name

define_test() {
    if [ -n "${__shtest_test_name}" ]; then
        fail "define_test already called. Only one test per file is supported."
    fi

    __shtest_test_name=$1
}

fail() {
    echo "FAIL: $1" >&2
    exit 1
}

assert() {
    if ! $*; then
        fail "$*"
    fi
}

run() {
    if ! $*; then
        fail "$*"
    fi
}

. ${__shtest_test}

if [ -z "${__shtest_test_name}" ]; then
    fail "No tests defined in ${__shtest_test} (did you forget to use 'define_test'?)"
fi

trap ${__shtest_test_name}_teardown 0 1 2 3

${__shtest_test_name}_setup
${__shtest_test_name}_body

exit $?
