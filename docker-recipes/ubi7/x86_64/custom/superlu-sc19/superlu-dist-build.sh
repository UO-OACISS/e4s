#!/bin/bash

printf "METIS = ${METIS_ROOT}\n"
printf "PARMETIS = ${PARMETIS_ROOT}\n"

cmake . \
  -DTPL_PARMETIS_INCLUDE_DIRS="${PARMETIS_ROOT}/include;${METIS_ROOT}/include" \
  -DTPL_PARMETIS_LIBRARIES="${PARMETIS_ROOT}/lib/libparmetis.so;${METIS_ROOT}/lib/libmetis.so" \
  \
  -DTPL_ENABLE_BLASLIB=OFF \
  -DTPL_ENABLE_COMBBLASLIB=OFF \
  -DTPL_ENABLE_LAPACKLIB=OFF \
  -Denable_tests=ON \
  \
  -DBUILD_SHARED_LIBS=OFF \
  -DCMAKE_INSTALL_PREFIX=. \
  -DCMAKE_C_FLAGS="-std=c99 -g -O3 -DPRNTlevel=1 -DDEBUGlevel=0" \
  -DCMAKE_C_COMPILER=mpicc \
  -DCMAKE_CXX_COMPILER=mpicxx

make

sed -i 's/"pdtest/"\.\/pdtest/g' TEST/CTestTestfile.cmake
sed -i 's/"pddrive/"\.\/pddrive/g' EXAMPLE/CTestTestfile.cmake
sed -i 's/"pzdrive/"\.\/pzdrive/g' EXAMPLE/CTestTestfile.cmake
