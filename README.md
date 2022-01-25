# Flocking_pigeons_orchestrate_music_for_a_machine

# Code book:

This code collection is part of the Animal Opera revisited project. For more information contact the principal investigator Diego Ellis Soto (diego.ellissoto@yale.edu).

The aim of these scripts is to create music out of animal behavior, both for individuals and group level property.

Specifically we are interested in the group level parameters of: Polarization, rotation, group speed, group centroid in xy position, and the dynamic collective state at which animals are in at a given time period (swarming, polarized, milling, transition).

At the individual level we are interested in:

Individual fish location, speed, distance from centroid

Two different script perform music out of group level and individual fish data respectively.

[1] termite_collective_parameters_music.ipynd

This first script loads individual lvl animal data (using termites as a example), and creates music out of termite locations and adjust the music speed to the termite velocity. Up to three keys can be played at once by animals (identified through 3 positions of k-mean clustering of the group of animals)

[2] termite_individual_lvl_data_music.ipynd

This second script creates a single note out of the values of polarization and rotation of an animal group at a given time.

# Future avenues:

Combine group level and individual lvl data better (i.e. group lvl data is the left hand and the right hand is individual lvl data).
Make a more dynamic domain?
Relate note changes in different ways?
Add chord progressions throughout the song
Get more species


