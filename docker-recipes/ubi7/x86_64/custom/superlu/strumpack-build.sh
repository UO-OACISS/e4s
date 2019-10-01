cmake ../ \
  -DCMAKE_BUILD_TYPE=Release \
  -DCMAKE_CXX_COMPILER=mpicxx \
  -DCMAKE_C_COMPILER=mpicc \
  -DCMAKE_Fortran_COMPILER=mpif90 \
  \
  -DCMAKE_INSTALL_PREFIX=../install \
  \
  -DSTRUMPACK_USE_MPI=ON \
  -DSTRUMPACK_USE_OPENMP=ON \
  \
  -DSTRUMPACK_BUILD_TESTS=OFF \
  -DSTRUMPACK_C_INTERFACE=OFF \
  \
  -DTPL_METIS_INCLUDE_DIRS="${METIS_ROOT}/include" \
  -DTPL_METIS_LIBRARIES="${METIS_ROOT}/lib/libmetis.so" \
  \
  -DTPL_ENABLE_PARMETIS=ON \
  -DTPL_PARMETIS_INCLUDE_DIRS="${PARMETIS_ROOT}/include" \
  -DTPL_PARMETIS_LIBRARIES="${PARMETIS_ROOT}/lib/libparmetis.so" \
  \
  -DTPL_BLAS_LIBRARIES=${OPENBLAS_ROOT}/lib/libopenblas.so \
  \
  -DTPL_ENABLE_BPACK=ON \
  -DTPL_BPACK_INCLUDE_DIRS="/ButterflyPACK/SRC_DOUBLE;/ButterflyPACK/SRC_DOUBLECOMPLEX" \
  -DTPL_BPACK_LIBRARIES="/ButterflyPACK/build/SRC_DOUBLE/libdbutterflypack.a;/ButterflyPACK/build/SRC_DOUBLECOMPLEX/libzbutterflypack.a;${ARPACK_NG_ROOT}/lib64/libarpack.so;${ARPACK_NG_ROOT}/lib64/libparpack.so" \
  \
  -DTPL_ENABLE_SCOTCH=OFF \
  -DTPL_ENABLE_COMBBLAS=OFF \
  -DTPL_ENABLE_CUBLAS=OFF

VERBOSE=1 make
