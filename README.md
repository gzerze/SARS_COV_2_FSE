# MM-OPES_for_SARS_COV_2_FSE
"Asymmetric transition pathways govern the conformational landscape of the SARS-CoV-2 frameshifting stimulatory element"



# Repository Overview
This repository contains all the input files and simulation scripts needed to reproduce the simulations of the paper.

# Folder Structure
1. start_3-3/


Contains input files for simulations that start from motif 3-3.

2. start_3-6/


Contains input files for simulations that start from motif 3-6.

Structure:

mdp/: Contains the GROMACS .mdp files.
0/, 1/, 2/, ..., 23/: These folders include the PLUMED input files (plumed files) and GROMACS .tpr files.






3. plumed/


Contains all PLUMED input files used simulations and analysis.
File naming convention: plumed-CVs.dat.


Coordinate and Topology Files

rna_deshaw_390_pr.gro: Coordinate file of the system.
topol.top: GROMACS-compatible topology file of the system.


# Additional Information
For a detailed explanation of the methods, results, and analysis, please refer to the manuscript.



