all: ex17

CFLAGS =
FFLAGS =
CPPFLAGS =
FPPFLAGS =

run:
	OMP_NUM_THREADS=1 mpirun -n 4 ./ex17 -n 6 -p 5 -norandom -pc_type lu -pc_factor_mat_solver_type superlu_dist -mat_superlu_dist_colperm MMD_ATA -ksp_monitor
	OMP_NUM_THREADS=1 mpirun -n 4 ./ex17 -n 6 -p 5 -norandom -pc_type lu -pc_factor_mat_solver_type strumpack -mat_strumpack_verbose -mat_strumpack_colperm FALSE -ksp_monitor
	# use strumpack as an (ILU) preconditioner
	OMP_NUM_THREADS=1 mpirun -n 4 ./ex17 -n 200 -p 5 -norandom -pc_type ilu -pc_factor_mat_solver_type strumpack -mat_strumpack_colperm FALSE  -mat_strumpack_verbose -help -mat_strumpack_hss_min_sep_size 10 -ksp_monitor -ksp_rtol 1e-12
	./ex17 -n 6 -p 5 -norandom -pc_type lu -pc_factor_mat_solver_type superlu_dist -mat_superlu_dist_colperm MMD_ATA

include ${PETSC_DIR}/lib/petsc/conf/variables
include ${PETSC_DIR}/lib/petsc/conf/rules
include ${PETSC_DIR}/lib/petsc/conf/test
