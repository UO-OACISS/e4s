#!/bin/bash

function pause() {
  read -p "$*"
}

printf "[SUPERLU_DIST] changing into /superlu_dist\n"
cd /superlu_dist

printf "[SUPERLU_DIST] press [enter] to run: OMP_NUM_THREADS=2 ctest\n"
pause ""
OMP_NUM_THREADS=2 ctest

printf "\n\n[SUPERLU_DIST] changing into /suerplu_dist/EXAMPLE\n"
cd /superlu_dist/EXAMPLE
printf "[SUPERLU_DIST] press [enter] to run: OMP_NUM_THREADS=2 mpiexec -n 4 ./pddrive -r 2 -c 2 g20.rua\n"
pause ""
OMP_NUM_THREADS=2 mpiexec -n 4 ./pddrive -r 2 -c 2 g20.rua


printf "\n\n[BUTTERFLYPACK] changing into /ButterflyPACK\n"
cd /ButterflyPACK

printf "[BUTTERFLYPACK] press [enter] to run: mpiexec -n 4 ./EXAMPLE/ie2d\n"
pause ""
mpiexec -n 4 ./EXAMPLE/ie2d

printf "\n\n[STRUMPACK] changing into /STRUMPACK/examples\n"
cd /STRUMPACK/examples

printf "[STRUMPACK] press [enter] to build: make testMMdouble\n"
pause ""
make testMMdouble

printf "\n\n[STRUMPACK] press [enter] to run: OMP_NUM_THREADS=4 ./testMMdouble pde900.mtx\n"
pause ""
OMP_NUM_THREADS=4 ./testMMdouble pde900.mtx

printf "\n\n[STRUMPACK] press [enter] to build: make testMMdoubleMPIDist64\n"
pause ""
make testMMdoubleMPIDist64

printf "\n\n[STRUMPACK] press [enter] to run: OMP_NUM_THREADS=1 mpirun -n 4 ./testMMdoubleMPIDist64 pde900.mtx\n"
pause ""
OMP_NUM_THREADS=1 mpirun -n 4 ./testMMdoubleMPIDist64 pde900.mtx
