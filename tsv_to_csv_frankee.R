virtual_pigeon = read.table(file = '/Users/diegoellis/Desktop/virtual_pigeon_boids.tsv', sep = '\t', header = FALSE)
names(virtual_pigeon) <- c('Frame_time', 'Pigeon_ID', 'X_long', 'Y_lat')
write.csv(virtual_pigeon, file = '/Users/diegoellis/Desktop/dougs_virtual_pigeons.csv')
# Doug I forgot to ask: How to make dynamic domain -> Email him -> Dynamic background.


virtual_stickleback =  read.table(file = '/Users/diegoellis/Desktop/stickleback_boids.tsv', sep = '\t', header = FALSE)
names(virtual_stickleback) <- c('Frame_time', 'Stickleback_ID', 'X_long', 'Y_lat', 'vx', 'vy', 'spd', 'ang', 'angvel', 'stopgo', 'state')
write.csv(virtual_stickleback, file = '/Users/diegoellis/Desktop/jolle_virtual_stickleback.csv')


zebrafish = read.csv('/Users/diegoellis/projects/Proposals_funding/Yale_internal_grants/Franke_program/CCAM_Music_migration/Data/Real/Zebrafish/zebrafish_video_tracked.csv')[,-1]

write.table(zebrafish, file='/Users/diegoellis/projects/Proposals_funding/Yale_internal_grants/Franke_program/CCAM_Music_migration/Data/Real/Zebrafish/zebrafish.tsv', quote=FALSE, sep='\t', col.names = NA)
names(zebrafish)

shiners <- read.csv('/Users/diegoellis/projects/Proposals_funding/Yale_internal_grants/Franke_program/CCAM_Music_migration/Data/schooling_golden_shiners.csv')
tail(shiners)
require(tidyverse)
shiners = shiners[shiners$frame <= 100,] %>% dplyr::select(px, py, vx, vy, onfish, frame)
write.csv(shiners, file = '/Users/diegoellis/projects/Proposals_funding/Yale_internal_grants/Franke_program/CCAM_Music_migration/Data/schooling_golden_shiners_subset_first_100_frames.csv')
