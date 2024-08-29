#!/bin/bash

# load the library
source "${BSFPE_LIBRARY_DIR}/loader.sh"

# retrieve the current script running directory
SCRIPT_DIR=$(dirname "$0")

# read the values from the file and append them to the array
while read -r __line; do
  maths::append "${__line}"
done < "${SCRIPT_DIR}/values"

# print all the available statistics
echo "Min      : $(maths::minimum)"
echo "Max      : $(maths::maximum)"
echo "Sum      : $(maths::sum)"
echo "Length   : $(maths::length)"
echo "Average  : $(maths::average)"
echo "Median   : $(maths::median)"
echo "Stddev   : $(maths::stddev)"
echo "Variance : $(maths::variance)"
echo "10th     : $(maths::percentile 10)"
echo "20th     : $(maths::percentile 20)"
echo "50th     : $(maths::percentile 50)"
echo "70th     : $(maths::percentile 70)"
echo "80th     : $(maths::percentile 80)"
echo "90th     : $(maths::percentile 90)"
echo "95th     : $(maths::percentile 95)"
echo "99th     : $(maths::percentile 99)"
echo "100th    : $(maths::percentile 100)"