# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# TRex
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---


# Get miniforge first
curl -L -O https://github.com/conda-forge/miniforge/releases/latest/download/Mambaforge-$(uname)-$(uname -m).sh
bash Mambaforge-$(uname)-$(uname -m).sh

# Get trex
conda create -n tracking -c trexing trex  # macOS (arm64)

trex


# Next steps: Get the additional packages I want and need for the project to make music ! ! #####


# https://trex.run/docs/install.html#the-easy-way








conda create -n tracking -c main -c conda-forge -c local trex   # Linux

conda config --add channels defaults
conda config --add channels bioconda
conda config --add channels conda-forge

cd /Users/diegoellis/projects/Proposals_funding/Yale_internal_grants/Franke_program/Frankee_Program/trex/conda
./build_conda_package.sh  # Linux, macOS

# After compilation was successful, TRex can be installed using:
conda create -n tracking -c trexing trex  # macOS, Windows, Linux (Intel)


conda install cmake -n tracking
conda install ffmpeg -n tracking
conda install cmake -n tensorflow=1.13
conda install cmake -n tensorflow=1.13



conda create -n tracking cmake ffmpeg tensorflow=1.13 keras=2.3 opencv


# John help me run this code: debug it 

https://github.com/JolleJolles/SwarmKit/tree/master/functions

conda activate tracking

trex -i example -s tmp.settings -track_max_individuals 5 -individual_prefix "termite"


trex -i example -s tmp.settings -track_max_individuals 5 -individual_prefix "termite"


conda activate tracking

