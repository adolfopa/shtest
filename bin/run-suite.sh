#! /bin/sh

# shtest - A minimalistic POSIX sh testing framework
#
# Copyright (c) 2012, Adolfo Perez Alvarez
# All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
#  1. Redistributions of source code must retain the above copyright
#  notice, this list of conditions and the following disclaimer.
#
#  2. Redistributions in binary form must reproduce the above
#  copyright notice, this list of conditions and the following
#  disclaimer in the documentation and/or other materials provided
#  with the distribution.
#
#  3. Neither the name of the author nor the names of its
#  contributors may be used to endorse or promote products derived
#  from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
# FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
# COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
# INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
# (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)
# HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
# STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED
# OF THE POSSIBILITY OF SUCH DAMAGE.

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
