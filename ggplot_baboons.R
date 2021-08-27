# Baboon dataset Meg Crofoot Movebank:

require(move)
require(lubridate)
require(tidyverse)
# Downloaded from: https://www.datarepository.movebank.org/handle/10255/move.406

baboons <- read.csv('/Users/diegoellis/Downloads/Collective movement in wild baboons (data from Strandburg-Peshkin et al. 2015).csv') %>% drop_na()
# Thin to one point per hour first of all: 
# Then need a timerange wheer all where tagged: 
# Make a table for data aviaalbleility by day 
baboons$timestamp <- ymd_hms(baboons$timestamp)
baboons$yday <- yday(baboons$timestamp)
baboons$year <- year(baboons$timestamp)
baboons$hour <- hour(baboons$timestamp)
baboons$minute <- minute(baboons$timestamp)

  data_thin = ddply(baboons, 'individual.local.identifier', function(x){
    ddply(x, 'year', function(y){
      ddply(y, 'yday', function(z){
        ddply(z, 'hour', function(a){
          ddply(a, 'minute', function(b){
            df = b[1,]
            
          })
        })
      })
    })
  })
  head(data_thin)
  
  
  one_per_hour_data_thin = ddply(baboons, 'individual.local.identifier', function(x){
    ddply(x, 'year', function(y){
      ddply(y, 'yday', function(z){
        ddply(z, 'hour', function(a){
            df = a[1,]
        })
      })
    })
  })
  
  ddply(baboons, 'individual.local.identifier',function(x){
  range(x$timestamp)
})



library(sf)
library(ggplot2)
library(gganimate)

# Data from personal correspondance

# Collapse all dates to the same year
# d$year <- format(d$date, '%Y')
# d$stand_time <- as.POSIXct(paste0('2000-', format(d$date, '%m-%d %T')))

# Get the first 100 observations of each animal:
require(dplyr)
require(plyr)
tmp = ddply(baboons,'individual.local.identifier', function(x){
  df = x[1:100,]
})
require(lubridate)
tmp$timestamp <- ymd_hms(tmp$timestamp)

tmp = one_per_hour_data_thin

# Create topo background
earth <- st_as_sf(rnaturalearth::countries110)

lon_range <- range(tmp$location.long, na.rm=T)#  + c(-0.1, 0.1)
lat_range <- range(tmp$location.lat, na.rm=T) # + c(-0.1, 0.1)
bbox <- st_polygon(list(cbind(lon_range[c(1,1,2,2,1)], lat_range[c(1,2,2,1,1)])))
bbox <- st_sfc(bbox)
st_crs(bbox) <- st_crs(earth)
area_sf <- st_intersection(earth, bbox)
require(viridis)
# Plot and animate
# Add geom_polygon:
# https://cran.r-project.org/web/packages/viridis/vignettes/intro-to-viridis.html
p <- ggplot2::ggplot(tmp) + 
  ggplot2::geom_sf(data = area_sf, fill = 'white') + 
  ggplot2::geom_point(aes(location.long, location.lat, group = factor(individual.local.identifier),
                 colour = factor(individual.local.identifier)), size = 0.5) +
  #  coord_sf(xlim = range(tmp$location.long, na.rm = T), ylim = range(tmp$location.lat, na.rm = T)) +
  viridis::scale_color_viridis(discrete = TRUE) +labs(title = 'Tracking of baboons', 
                                                      subtitle = 'Timestamp: {format(frame_time)}',
                                                      x = NULL, y = NULL) + 
  transition_components(timestamp) + 
  shadow_wake(wake_length = 0.2) +
  shadow_trail(distance = 0.001, size = 0.3) 
  # theme(panel.background = element_rect(fill = 'lightblue'),
  #       legend.position = 'bottom') +  
  
gganimate::animate(p, 200, 1)

gganimate::animate(p, nframes = 200, fps = 10, detail = 3, type = "cairo", renderer = av_renderer(audio = "/Users/diegoellis/Downloads/flock.mp3"))

anim_save("collective_baboons.mp4")


head(baboons)

m <- move(x = df[["location-long"]], y = df[["location-lat"]],
          time = df[["timestamp"]], animal = df[["name"]],
          proj = "+proj=longlat +datum=WGS84 +no_defs",
          removeDuplicatedTimestamps = TRUE)

lag <- unlist(timeLag(m, unit = "mins"))
median(lag)

# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# Next try to do this using moveVIS: ####
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
head(baboons)
m <- move(x = baboons[["location.long"]], y = baboons[["location.lat"]],
          time = baboons[["timestamp"]],
          animal = baboons[["individual.local.identifier"]],
          proj = "+proj=longlat +datum=WGS84 +no_defs",
          removeDuplicatedTimestamps = TRUE)
names(m)
crs(m)

one_per_hour_data_thin

m <- move(x = one_per_hour_data_thin[["location.long"]],
          y = one_per_hour_data_thin[["location.lat"]],
          time = one_per_hour_data_thin[["timestamp"]],
          animal = one_per_hour_data_thin[["individual.local.identifier"]],
          proj = "+proj=longlat +datum=WGS84 +no_defs",
          removeDuplicatedTimestamps = TRUE)


lag <- unlist(timeLag(m, unit = "mins"))
median(lag)

lag <- unlist(timeLag(m, res = 180, digit = 0, unit = "mins"))
median(lag)

m <- align_move(m, res = 180, digit = 0, unit = "mins")

m <- align_move(m, res = 3, digit = 0, unit = "hours")

length(unique(timestamps(m)))
get_maptypes()

frames <- frames_spatial(m, trace_show = TRUE, equidistant = FALSE,
                         map_service = "osm", map_type = "terrain_bg")

frames[[200]]  


