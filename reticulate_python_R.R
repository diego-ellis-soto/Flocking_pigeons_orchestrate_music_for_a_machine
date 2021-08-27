# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# Reticulate:
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

require(reticulate)
# Set the path to the Python executable file
use_python("/usr/local/bin/python")
py_config()
# Install packages
# py_install("pandas")
# use_virtualenv("myenv")
# os <- import("os")
# os$listdir(".")

# Import/Load the neccesary python packages
import("numpy")
import("pandas")
import("time")


# Load scripts in python: A function and a script that does stuff:

# source_python("/Users/diegoellis/projects/Proposals_funding/Yale_internal_grants/Franke_program/CCAM_Music_migration/Code/helper_function_virtual_fish.py")

# Evaluate the chosen script: Load a python function into R:
source_python("/Users/diegoellis/projects/Proposals_funding/Yale_internal_grants/Franke_program/CCAM_Music_migration/Code/test_func.py")

source_python("/Users/diegoellis/projects/Proposals_funding/Yale_internal_grants/Franke_program/CCAM_Music_migration/Code/test_scipt.py")

# source_python('/Users/diegoellis/flocking/JolleJolle_Coletive_fish.ipynb')

# Create parameter to pass to Python function
x = 10

# Call my_function()
y = my_function(x)
print(y)

# Pring objects from the Python script
print(py$my_var)
print(py$my_df)
print(py$my_df$x1)

# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# Moify the flock and the virtual fish function and load the numpy array in here:

# --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---

# data reading
np <- import("numpy")
virtual_fish <- np$load("/Users/diegoellis/Desktop/fish_jolle.npy")
dim(virtual_fish) # We have 10 fish 2000 observations but 9 dimensions.

virtual_pigeons <- np$load("/Users/diegoellis/flocking/flock-simulation.npy")
dim(virtual_pigeons)


df = as.matrix(virtual_fish)
head(df)


virtual_fish[1:2][1:2] 

virtual_fish[, 1:2]  # two rows, three columns


# John ask him for help to translat emy baboon csv into a numpy array with number of individuals -> need this function to make data gframe numpy array and back and forth !!! 


# COlumn names 9: 10 fish
# ind_x, ind_y, ind_vx, ind_vy, ind_spd, ind_ang, ind_angvel, ind_stopgo, ind_state = np.arange(9)