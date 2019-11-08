#!/bin/bash

function pause() {
  read -p "$*"
}

function p() {
  printf "${GR}[ ${1} ]${NC} ${2}\n"
}

function slu() {
  p "SUPERLU_DIST" "${1}"
}

function bfly() {
  p "BUTTERFLYPACK" "${1}"
}

function strum() {
  p "STRUMPACK" "${1}"
}

GR='\033[0;32m'
NC='\033[0m'

slu "changing into /superlu_dist/EXAMPLE"
cd /superlu_dist/EXAMPLE

slu "press [enter] to run: OMP_NUM_THREADS=2 mpiexec -n 10 ./pzdrive4 cg20.cua"
pause ""
OMP_NUM_THREADS=2 mpiexec -n 10 ./pzdrive4 cg20.cua

printf "\n\n"

slu "press [enter] to run: OMP_NUM_THREADS=2 mpiexec -n 4 ./pddrive -r 2 -c 2 g20.rua"
pause ""
OMP_NUM_THREADS=2 mpiexec -n 4 ./pddrive -r 2 -c 2 g20.rua


printf "\n\n"
bfly "changing into /ButterflyPACK"
cd /ButterflyPACK

bfly "press [enter] to run: mpiexec -n 4 ./EXAMPLE/ie2d"
pause ""
mpiexec -n 4 ./EXAMPLE/ie2d


printf "\n\n"
strum "changing into /STRUMPACK/examples"
cd /STRUMPACK/examples

#strum "press [enter] to build: make testMMdouble"
#pause ""
#make testMMdouble

#printf "\n\n"
strum "press [enter] to run: OMP_NUM_THREADS=4 ./testMMdouble ./data/pde900.mtx"
pause ""
OMP_NUM_THREADS=4 ./testMMdouble ./data/pde900.mtx

#printf "\n\n"
#strum "press [enter] to build: make testMMdoubleMPIDist64"
#pause ""
#make testMMdoubleMPIDist64

printf "\n\n"
strum "press [enter] to run: OMP_NUM_THREADS=1 mpirun -n 4 ./testMMdoubleMPIDist64 ./data/pde900.mtx"
pause ""
OMP_NUM_THREADS=1 mpirun -n 4 ./testMMdoubleMPIDist64 ./data/pde900.mtx

printf "\n\n${GR}WALKTHROUGH COMPLETE${NC}\n\n"
