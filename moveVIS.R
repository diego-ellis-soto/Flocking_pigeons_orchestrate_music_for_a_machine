require('moveVis')
library(moveVis)
library(move)
library(raster)
data("whitestork_data", package = "moveVis")

colnames(df)
unique(df[["individual-local-identifier"]])

# To keep the animation legend readable and its used space small, a new names column is created from extracting the names from the identifier strings and cleaning them from special characters:
df$name <- sapply(df$`individual-local-identifier`, function(x)
  strsplit(x, " /")[[1]][1], USE.NAMES = F)
df$name <- gsub("-", " ", gsub("[+]", "", gsub(" ", "", df$name)))
unique(df$name)

# Convert and align trajectories: 
m <- move(x = df[["location-long"]], y = df[["location-lat"]],
          time = df[["timestamp"]], animal = df[["name"]],
          proj = "+proj=longlat +datum=WGS84 +no_defs",
          removeDuplicatedTimestamps = TRUE)

lag <- unlist(timeLag(m, unit = "mins"))
median(lag)

#  Multiple, independently recorded trajectories covering different individuals over similar time ranges usually do not share the exact same sampling times. In reality, both sampling times and sampling rates differ across individual trajectories and over time. However, animations use a discrete speed for switching frames. Since moveVis needs to assign each location of a trajectory to a specific frame, the sampling times of all locations across all trajectories need to be aligned to share a uniform temporal resolution and uniform time stamps that can be assigned to frames. moveVis includes a dedicated function to align trajectories using linear interpolation, named align_move():
  m <- align_move(m, res = 180, digit = 0, unit = "mins")
  length(unique(timestamps(m)))
  get_maptypes()

  frames <- frames_spatial(m, trace_show = TRUE, equidistant = FALSE,
                           map_service = "osm", map_type = "terrain_bg")

  frames[[200]]  

  # The spatial extent of the frames has been calculated automatically from the trajectories’ overall extent. It is possible to draw frames based on a custom extent, which is useful to alter the map format.
  
  ext <- extent(m) * 1.15
  ext@xmin <- ext@xmin * 1.3
  ext@xmax <- ext@xmax * 1.3
  # The custom extent can be passed to frames_spatial() via the ext argument.
  f
  rames <- frames_spatial(m, trace_show = TRUE, equidistant = FALSE,
                           ext = ext, map_service = "osm",
                           map_type = "terrain_bg")
# Frames can be edited before animating them. moveVis provides a set of functions to customize the appearance of frames after they have been created. For example, the user can add title, caption and axis texts using add_labels(), time stamps using add_timestamps(), a progress bar using add_progress() or basic map elements such as a north arrow using add_northarrow() and a scale bar using add_scalebar().

  
  # , renderer = av_renderer(audio = "/Users/diegoellis/Downloads/flock.mp3")  
  
  frames <- frames %>% add_labels(title = "White Storks (Ciconia
                                  ciconia) Migration 2018", caption = "Trajectory data: Cheng et al.
                                  (2019); Fiedler et al. (2013-2019),doi:10.5441/001/1.ck04mn78 Map:
                                  OpenStreetMap/Stamen; Projection: Geographic, WGS84", 
                                  x = "Longitude", y = "Latitude") %>%
    add_timestamps(type = "label") %>% 
    add_progress(colour = "white") %>%
    add_northarrow(colour = "white", position = "bottomleft") %>% 
    add_scalebar(colour = "black", position = "bottomright",
                 distance = 600)
  
  frames[[200]]
suggest_formats()  


animate_frames(frames, width = 800, height = 800,
               out_file = "S2_white_storks_osm.mov", end_pause = 1)

# Animating trajectories on a static satellite base map

# While OpenStreetMap and Carto map imagery can be used as is, the use of Mapbox imagery requires the user to register online at Mapbox to get a mapbox token. Such can then be defined as an argument of frames_spatial() to get access to Mapbox imagery, e.g. satellite imagery.

# 
frames <- frames_spatial(m, trace_show = TRUE, equidistant = FALSE,
                         ext = ext, map_service = "mapbox",
                         map_type = "satellite",
                         map_token = "pk.eyJ1IjoiZGllZ283OTEiLCJhIjoiY2pzcTcyOW16MGNlMzN5bXM1eDRvajViNCJ9.zGlyhPV15pmtvs4DKgTNxQ") %>% 
  add_labels(title ="White Storks (Ciconia ciconia) Migration 2018",
             caption = "Trajectory data: Cheng et al. (2019);
             Fiedler et al. (2013-2019), doi:10.5441/001/1.ck04mn78 Map:
             OpenStreetMap/Stamen; Projection: Geographic, WGS84",
             x = "Longitude", y = "Latitude") %>% 
  add_timestamps(type = "label") %>% 
  add_progress(colour = "white") %>% 
  add_northarrow(colour = "white", position = "bottomleft") %>% 
  add_scalebar(colour = "black", position = "bottomright", 
               distance = 600)

frames[[200]]
animate_frames (frames, width = 800, height = 800,
               out_file = "S3_white_storks_mapbox_sound.mov", end_pause = 1
               # , renderer = av_renderer(audio = "/Users/diegoellis/Downloads/flock.mp3"))
)
# Animating trajectories on a dynamic NDVI base map
# Instead of using a default base map, the user can pass other imagery as raster objects to frames_spatial(). Such can be multi-band RGB data (e.g. aerial footage) or single-band data, either continuous (e.g. environmental indices or parameters) or discrete (e.g. a land cover classification). Moreover, the user can choose to pass a single raster image, which will then be used as a static base map, or a list of raster images which will result in a base map changing dynamically over time.
# For this example, four raster datasets, representing the Normalized Vegetation Index (NDVI) at four different dates within the time range of the 2018 White Stork migration, have been acquired for a spatial extent covering the migration trajectories. The datasets have been derived from the MOD13Q1 raster product, a vegetation indices product derived from reflectance data acquired by the Moderate-resolution Imaging Spectroradiometer (MODIS) satellite sensor operated by NASA. NDVI is an indicator for chlorophyll activity, ranging from -1 to 1, and can be used to derive vegetation presence and health. Low values (< 0.2) indicate no vegetation, moderate values (0.2-0.3) sparse and high values (> 0.3) dense vegetation.
# Since the NDVI rasters are stored in a single file, the raster data can be loaded as a stack and then unstacked into a list. The according acquisition times per raster are defined in a separate vector.

ndvi <- unstack(stack("MOD13Q1_NDVI_latlon.tif"))
ndvi_times <- as.POSIXct(c("2018-07-28", "2018-08-13", "2018-08-29",
                           "2018-09-14"))


# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# Galapagos tortoises:
#
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
  
load('/Users/diegoellis/projects/development/Tortoise_data/Marius_Galapagos/Inputs/Cleaned_tortoise_tracks/all_tortuga_clean.RData')

# Convert and align trajectories: 
require(move)
require(lubridate)
all_tortuga_clean$longitude <- all_tortuga_clean@coords[,1]
all_tortuga_clean$latitude <- all_tortuga_clean@coords[,2]
all_tortuga_clean$name <- all_tortuga_clean@trackId

m <- align_move(all_tortuga_clean, res = 1, digit = 0, unit = "days")
length(unique(timestamps(m)))
get_maptypes()

frames <- frames_spatial(m, trace_show = TRUE, equidistant = FALSE,
                         map_service = "osm", map_type = "terrain_bg")

frames[[200]]  
