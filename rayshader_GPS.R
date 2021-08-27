library(rayshader)
library(geoviz)

igc_file <- download.file("http://www.xcleague.com/xc/download.php?pilot=1&output=IGC&year=2018&xcFlightId=20182909", "example.igc")

tracklog <- read_igc("example.igc")
#Get elevation data from Mapzen
#Increase this to ~60 for a higher resolution (but slower) image
max_tiles <- 10
dem <- mapzen_dem(tracklog$lat, tracklog$long, max_tiles = max_tiles)
# create an overlay image
overlay_image <-
  slippy_overlay(
    dem,
    image_source = "stamen",
    image_type = "watercolor",
    png_opacity = 0.3,
    max_tiles = max_tiles
  )
#Turn mountainous parts of the overlay transparent (optional but pretty)
overlay_image <-
  elevation_transparency(overlay_image,
                         dem,
                         pct_alt_high = 0.5,
                         alpha_max = 0.9)

# Render the scene...


#Draw the rayshader scene
elmat = matrix(
  raster::extract(dem, raster::extent(dem), method = 'bilinear'),
  nrow = ncol(dem),
  ncol = nrow(dem)
)

sunangle <- 270

scene <- elmat %>%
  sphere_shade(sunangle = sunangle, texture = "desert") %>%
  add_overlay(overlay_image) #%>%
#Uncomment these lines and the %>% above for better shadows but a much slower render
#  add_shadow(
#    ray_shade(
#      elmat,
#      anglebreaks = seq(30, 60),
#      sunangle = sunangle,
#      multicore = TRUE,
#      lambert = FALSE,
#      remove_edges = FALSE
#    )
#  ) %>%
#  add_shadow(ambient_shade(elmat, multicore = TRUE, remove_edges = FALSE))

rayshader::plot_3d(
  scene,
  elmat,
  zscale = raster_zscale(dem),
  solid = FALSE,
  shadow = TRUE,
  shadowdepth = -150
)


add_gps_to_rayshader(
  dem,
  tracklog$lat,
  tracklog$long,
  tracklog$altitude,
  line_width = 1,
  lightsaber = TRUE,
  zscale = raster_zscale(dem),
  ground_shadow = TRUE,
  colour = "red"
)
