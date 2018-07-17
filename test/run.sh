################################################################################
# Copyright (c) 2018 Advanced Micro Devices, Inc. All rights reserved.
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
# THE SOFTWARE.
################################################################################
#!/bin/sh

test_bin_dflt=./test/ctrl

# paths to ROC profiler and oher libraries
export LD_LIBRARY_PATH=$PWD
# enable error messages logging to '/tmp/rocprofiler_log.txt'
export ROCPROFILER_LOG=1

# ROC profiler library loaded by HSA runtime
export HSA_TOOLS_LIB=librocprofiler64.so
# tool library loaded by ROC profiler
export ROCP_TOOL_LIB=libtool.so
# ROC profiler metrics config file
unset ROCP_PROXY_QUEUE
# ROC profiler metrics config file
export ROCP_METRICS=metrics.xml
# output directory for the tool library, for metrics results file 'results.txt'
export ROCP_OUTPUT_DIR=./RESULTS

if [ ! -e $ROCP_TOOL_LIB ] ; then
  export ROCP_TOOL_LIB=test/libtool.so
fi

if [ -n "$1" ] ; then
  tbin="$*"
else
  tbin=$test_bin_dflt
fi

export ROCP_KITER=100
export ROCP_DITER=100
export ROCP_INPUT=input.xml
eval $tbin

#valgrind --leak-check=full $tbin
#valgrind --tool=massif $tbin
#ms_print massif.out.<N>

exit 0
