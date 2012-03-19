define_test normal_execution

##
## Test the normal flow of execution when no error occurs:
## 1. _setup() is called.
## 2. then _body() succeeds with no errors.
## 3. finally _teardown() is called.
##

normal_execution_setup() {
    cat >> __test_normal_execution.sh <<EOF
         define_test __normal_execution 
         __normal_execution_setup() {
             echo -n 1
         }
         __normal_execution_body() {
             echo -n 2
         }
         __normal_execution_teardown() {
             echo -n 3
         }
EOF
}

normal_execution_body() {
    ${__shtest_bin}/run-test.sh $(pwd)/__test_normal_execution.sh 1> __stdout 2> __stderr

    assert test $(cat __stdout) = "123"
    assert test -z "$(cat __stderr)"
}

normal_execution_teardown() {
    run rm __test_normal_execution.sh
    run rm __stdout
    run rm __stderr
}
