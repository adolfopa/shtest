#! /bin/sh

shtest_bin=$(dirname $0)
shtest_root=$(dirname ${shtest_bin})
shtest_suite_dir=$1
shtest_results_dir=${shtest_root}/results/$(basename ${shtest_suite_dir})
shtest_bin=$(dirname $0)

mkdir -p ${shtest_results_dir}

for test_case in ${shtest_suite_dir}/test*.sh; do
    shtest_test_name=$(echo $test_case | sed 's/.*test[_]*\(.*\)\.sh/\1/')
    shtest_stdout=${shtest_results_dir}/${shtest_test_name}_stdout.txt
    shtest_stderr=${shtest_results_dir}/${shtest_test_name}_stderr.txt

    ${shtest_bin}/run-test.sh ${test_case} 1> ${shtest_stdout} 2> ${shtest_stderr}

    if [ ! $? = 0 ]; then
        echo "${test_case} executed with errors. See ${shtest_stderr} for more info."
    fi
done
