#!/bin/bash
OMP_NUM_THREADS=1 python3 KernelRegression.py data/susy_10Kn 8 1.3 3.11 1 Gauss test --hss_rel_tol 1e-2
