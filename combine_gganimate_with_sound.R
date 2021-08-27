library(tidyverse)
library(e1071)
library(gganimate)

ntimes <- 20  # how many time points to run the bridge?
nseries <- 10 # how many time series to generate?

# function to generate the brownian bridges
make_bridges <- function(ntimes, nseries) {
  replicate(nseries, c(0,rbridge(frequency = ntimes-1))) %>% as.vector()
}

# construct tibble
tbl <- tibble(
  Time = rep(1:ntimes, nseries),
  Horizontal = make_bridges(ntimes, nseries),
  Vertical = make_bridges(ntimes, nseries),
  Series = gl(nseries, ntimes)
)

base_pic <- tbl %>%
  ggplot(aes(
    x = Horizontal, 
    y = Vertical, 
    colour = Series)) + 
  geom_point(
    show.legend = FALSE,
    size = 5) + 
  coord_equal() + 
  xlim(-2, 2) + 
  ylim(-2, 2) +
  transition_time(time = Time) +  # Timestamp:
  shadow_wake(wake_length = 0.2)

gganimate::animate(base_pic, nframes = 100, fps = 10)

# Do the baboons of Meg Crofoot with my gganimate one:

# 

#render with cairo device
gganimate::animate(base_pic, nframes = 100, fps = 10, type = "cairo")
# making smoother animations)
#increase frames and fps
gganimate::animate(base_pic, nframes = 300, fps = 30, type = "cairo")

#increase detail
gganimate::animate(base_pic, nframes = 100, fps = 10, type = "cairo", detail = 3)

# We now know that gganimate creates a series of static images, and then stitches them together to form the animation. There are several options related to both of these steps that we can set to affect the final product. First, we can set the device argument in animate to change the format of the static images. We can choose 'png', 'jpeg', 'tiff', 'bmp', 'svg', and 'svglite'.



# av_renderer: Returns a [video_file] object
# gganimate::av_renderer(audio = audio) will associate an audio track with your animation
# Ok: So we could do the midi to space mapping in python and the data visualization in R?

#render as video with audio
require('av')

# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# Couple sounds with movement:
gganimate::animate(base_pic, nframes = 300, fps = 10, detail = 3, type = "cairo", renderer = av_renderer(audio = "/Users/diegoellis/Downloads/flock.mp3"))
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# open with vcl 
anim_save('gganimate_sound.mp4', animation = last_animation())
# Mapping notes ! -> 


# Next add the baboons: 




# 
require('av')
require(gganimate)
animate(base_pic, nframes = 100, fps = 10, detail = 3, type = "cairo", renderer = av_renderer(audio = "/Users/diegoellis/Downloads/flock.mp3"))


anim_save("gganimate_sound.mp4")

# Transform mp3 to WMA

# animate(base_pic, nframes = 100, fps = 10, detail = 3, type = "cairo", renderer = av_renderer(audio = "animate_files/500_miles.WMA"))
animate(base_pic, nframes = 100, fps = 10, detail = 3, type = "cairo", renderer = av_renderer(audio = "animate_files/500_miles.WMA"))





