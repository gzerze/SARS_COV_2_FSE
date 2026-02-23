#!/bin/sh
#SBATCH -J sars_3
#SBATCH -t 168:00:00
#SBATCH -N 2
#SBATCH --ntasks-per-node=12
#SBATCH --cpus-per-task=4
#SBATCH -A zerze
##SBATCH --gpus=4

module purge
module add GCC cmake/3.17.3
module add cudatoolkit/11.0
module add intel-oneapi/2022.2.0


source /home/kmalekza/PROGRAMS/plumed2-v2.8/sourceme.sh

# Define number of replicas
ng=24
# Which set?
s=1
# Full path to application + application name
application="/home/kmalekza/PROGRAMS/gromacs-2021.4/exec/bin/gmx_gpu mdrun"
# Define variables related to protein and ff
proot="rna"
ff="deshaw"
fileroot="${proot}_${ff}"
this="mcmu"

mkdir cpts

nm=$(echo "$ng - 1" | bc)
dirs=0
cp ${dirs}/${fileroot}_${this}_nd.cpt cpts/${dirs}_${SLURM_JOB_ID}.cpt

for i in $(seq 1 $nm); do

cp ${i}/${fileroot}_${this}_nd.cpt cpts/${i}_${SLURM_JOB_ID}.cpt

dirs=${dirs}" "${i}
done

options="-maxh 337 -multidir $dirs \
-v -s ${fileroot}_${this}_nd.tpr \
-x ${fileroot}_${this}_nd.xtc \
-o ${fileroot}_${this}_nd.trr \
-c ${fileroot}_${this}_nd.gro \
-e ${fileroot}_${this}_nd.edr \
-g ${fileroot}_${this}_nd.log \
-plumed plumed.dat \
-cpo ${fileroot}_${this}_nd.cpt \
-cpi ${fileroot}_${this}_nd.cpt -noappend"

echo Running on host `hostname`
echo Time is `date`
echo Directory is `pwd`

# Launch the MPI executable

mpirun $application $options > outfile_${proot} 2>&1

echo Time is `date`
