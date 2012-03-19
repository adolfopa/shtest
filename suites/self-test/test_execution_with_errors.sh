define_test with_errors

##
## The execution flow for a suite with errors should be:
## 1. _setup() is called.
## 2. _body() is called; it will generate a failure.
## 3. _teardown() is called.
##

with_errors_setup() {
    cat >> __test_execution_with_errors.sh <<EOF
         define_test __normal_execution
         __normal_execution_setup() {
             echo -n 1
         }
         __normal_execution_body() {
             fail "expected"
         }
         __normal_execution_teardown() {
             echo -n 3
         }
EOF
}

with_errors_body() {
    ${__shtest_bin}/run-test.sh $(pwd)/__test_execution_with_errors.sh 1> __stdout 2> __stderr

    # "1" for _setup(), "3" for _teardown()
    assert test "13" = "$(cat __stdout)"

    # Failure messages are dumped to stderr
    assert test "expected" = "$(cat __stderr | cut -d' ' -f2)"
}

with_errors_teardown() {
    rm -f __test_execution_with_errors.sh
    rm -f __stdout
    rm -f __stderr
}
