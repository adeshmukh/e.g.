#!/bin/bash

tests_filepath=${0}
tests_filename=$(basename ${tests_filepath})
tests_dir=$(cd $(dirname $(pwd)/${tests_filepath}) && pwd)
src_dir=${tests_dir}/../src
eg_script=${src_dir}/e.g.

export E_G_DIR=$(mktemp -d -t ${tests_filename}.XXXXX)
if [ $? -ne 0 ]; then echo "$?: Cannot create temporary dir for tests, exiting."; exit 1; fi

e.g._setup() {
  ${eg_script} $@ 2>&1 > /dev/null
}


e.g._generic_test() {
  subcommand=${1}
  expected_outcome=${2}
  ${eg_script} ${subcommand} 2>&1 | grep ${expected_outcome} > /dev/null
}

# Actual tests
e.g._test_add_help() {
  e.g._generic_test 'add -h' 'Usage'
}

e.g._test_add_default_help() {
  e.g._generic_test add 'Usage'
}

e.g._test_show_help() {
  e.g._generic_test show 'Usage'
}

e.g._test_show_default_help() {
  e.g._generic_test 'show -h' 'Usage'
}

e.g._test_list() {
  e.g._setup add somecmd1 --someopt -a some args
  e.g._setup add somecmd2 --someopt -a some args

  e.g._generic_test 'list' '^somecmd1alskdjf$'
  e.g._generic_test 'list' '^somecmd2$'
}


# Test runner
for test in $(egrep -o '^e.g._test_[a-z_]+' ${tests_filepath}); do
  echo " $($test && echo ' OK ' || echo 'FAIL') : ${test} "
done

# Cleanup
if [ "$(cd ${E_G_DIR} && pwd)" == "$HOME/.e.g." ]; then
  echo "Not deleting E_G_DIR pointing at ${E_G_DIR}."; 
else
  rm ${E_G_DIR}/* ; rmdir ${E_G_DIR}
fi
