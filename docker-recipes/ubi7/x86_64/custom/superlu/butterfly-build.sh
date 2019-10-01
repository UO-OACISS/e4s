export BLAS_LIB=${OPENBLAS_ROOT}/lib/libopenblas.so
export LAPACK_LIB=${NETLIB_LAPACK_ROOT}/lib64/liblapack.so
export SCALAPACK_LIB=${NETLIB_SCALAPACK_ROOT}/lib/libscalapack.so
export ARPACK_LIB="${ARPACK_NG_ROOT}/lib64/libarpack.so;${ARPACK_NG_ROOT}/lib64/libparpack.so"

cd ..
sh PrecisionPreprocessing.sh
cd build

cmake .. \
  -DCMAKE_Fortran_FLAGS="" \
  -DCMAKE_CXX_FLAGS="" \
  -DTPL_BLAS_LIBRARIES=${BLAS_LIB} \
  -DTPL_LAPACK_LIBRARIES=${LAPACK_LIB} \
  -DTPL_SCALAPACK_LIBRARIES=${SCALAPACK_LIB} \
  -DTPL_ARPACK_LIBRARIES=${ARPACK_LIB} \
  -DBUILD_SHARED_LIBS=ON \
  -DCMAKE_Fortran_COMPILER=mpif90 \
  -DCMAKE_CXX_COMPILER=mpicxx \
  -DCMAKE_C_COMPILER=mpicc \
  -DCMAKE_INSTALL_PREFIX=. \
  -DCMAKE_BUILD_TYPE=Release

VERBOSE=1 make
