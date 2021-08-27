# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
#
# Diego Ellis Soto, Yale University
# Frankee Program of the Humanities, Yale University
#
#
# Look at a subset of baboons, pigeons and 
# 
#
# 
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
require(rayshader)
require(rayrender)
# brew cask install xquartz


# Need to Install command line developer tools in OS X



# Load a map with the raster package.
loadzip = tempfile() 
download.file("https://tylermw.com/data/dem_01.tif.zip", loadzip)
localtif = raster::raster(unzip(loadzip, "dem_01.tif"))
unlink(loadzip)

#And convert it to a matrix:
elmat = raster_to_matrix(localtif)

#We use another one of rayshader's built-in textures:

#detect_water and add_water adds a water layer to the map:
elmat %>%
  sphere_shade(texture = "desert") %>%
  add_water(detect_water(elmat), color = "desert") %>%
  add_shadow(ambient_shade(elmat), 0) %>%
  add_shadow(ray_shade(elmat), 0.5) %>%
  plot_map()

# Rayshader also supports 3D mapping by passing a texture map (either external or one produced by rayshader) into the plot_3d function.

elmat %>%
  sphere_shade(texture = "desert") %>%
  add_water(detect_water(elmat), color = "desert") %>%
  add_shadow(ray_shade(elmat, zscale = 3), 0.5) %>%
  add_shadow(ambient_shade(elmat), 0) %>%
  plot_3d(elmat, zscale = 10, fov = 0, theta = 135, zoom = 0.75, phi = 45, windowsize = c(1000, 800))
Sys.sleep(0.2)
# Move from viewer to plot on whatever is on viewer right now; cool function
render_snapshot()

# Turn it into 3D
render_camera(fov = 0, theta = 60, zoom = 0.75, phi = 45)
render_scalebar(limits=c(0, 5, 10),label_unit = "km",position = "W", y=50,
                scale_length = c(0.33,1))
render_compass(position = "E")
render_snapshot(clear=TRUE)

render_highquality(samples=200, scale_text_size = 24,clear=TRUE)


# You can also easily add a water layer by setting water = TRUE in plot_3d() # by using the function render_water() after 3D map has been rendered. 

montshadow = ray_shade(montereybay, zscale = 50, lambert = FALSE)
montamb = ambient_shade(montereybay, zscale = 50)
montereybay %>%
  sphere_shade(zscale = 10, texture = "imhof1") %>%
  add_shadow(montshadow, 0.5) %>%
  add_shadow(montamb, 0) %>%
  plot_3d(montereybay, zscale = 50, fov = 0, theta = -45, phi = 45, 
          windowsize = c(1000, 800), zoom = 0.75,
          water = TRUE, waterdepth = 0, wateralpha = 0.5, watercolor = "lightblue",
          waterlinecolor = "white", waterlinealpha = 0.5)
Sys.sleep(0.2)
render_snapshot(clear=TRUE)


# Rayshader also has map shapes other than rectangular included c("hex", "circle"), and you can customize the map into any shape you want by setting the areas you do not want to display to NA.
# Do for Art ####

par(mfrow = c(1, 2))
montereybay %>% 
  sphere_shade(zscale = 10, texture = "imhof1") %>% 
  add_shadow(montshadow, 0.5) %>%
  add_shadow(montamb, 0) %>%
  plot_3d(montereybay, zscale = 50, fov = 0, theta = -45, phi = 45, windowsize = c(1000, 800), zoom = 0.6,
          water = TRUE, waterdepth = 0, wateralpha = 0.5, watercolor = "lightblue",
          waterlinecolor = "white", waterlinealpha = 0.5, baseshape = "circle")

render_snapshot(clear = TRUE)

montereybay %>% 
  sphere_shade(zscale = 10, texture = "imhof1") %>% 
  add_shadow(montshadow, 0.5) %>%
  add_shadow(montamb, 0) %>%
  plot_3d(montereybay, zscale = 50, fov = 0, theta = -45, phi = 45, windowsize = c(1000, 800), zoom = 0.6,
          water = TRUE, waterdepth = 0, wateralpha = 0.5, watercolor = "lightblue",
          waterlinecolor = "white", waterlinealpha = 0.5, baseshape = "hex")

render_snapshot(clear = TRUE)
# Adding text labels is done with the render_label() function, which also allows you to customize the line type, color, and size along with the font:


# Add labels would be great to do for diferent land cover classes and a circle of an animals AKDE?! 

montereybay %>% 
  sphere_shade(zscale = 10, texture = "imhof1") %>% 
  add_shadow(montshadow, 0.5) %>%
  add_shadow(montamb,0) %>%
  plot_3d(montereybay, zscale = 50, fov = 0, theta = -100, phi = 30, windowsize = c(1000, 800), zoom = 0.6,
          water = TRUE, waterdepth = 0, waterlinecolor = "white", waterlinealpha = 0.5,
          wateralpha = 0.5, watercolor = "lightblue")
render_label(montereybay, x = 350, y = 160, z = 1000, zscale = 50,
             text = "Moss Landing", textsize = 2, linewidth = 5)
render_label(montereybay, x = 220, y = 70, z = 7000, zscale = 50,
             text = "Santa Cruz", textcolor = "darkred", linecolor = "darkred",
             textsize = 2, linewidth = 5)
render_label(montereybay, x = 300, y = 270, z = 4000, zscale = 50,
             text = "Monterey", dashed = TRUE, textsize = 2, linewidth = 5)
render_label(montereybay, x = 50, y = 270, z = 1000, zscale = 50,  textcolor = "white", linecolor = "white",
             text = "Monterey Canyon", relativez = FALSE, textsize = 2, linewidth = 5) 
Sys.sleep(0.2)
render_snapshot(clear=TRUE)

# Really high quality output figure: ####
# Labels are also supported in render_highquality():
render_highquality(samples=200, line_radius = 1, text_size = 18, text_offset = c(0,12,0),
                   clamp_value=10, clear = TRUE)


# 3D paths, points and polygons ####
# Do ####
# Explore AKDE's, rangemaps, movement tracks with sf objects
# 3D paths, points, and polygons can be added directly from spatial objects from the sf library:

montereybay %>%
  sphere_shade(texture = "desert") %>%
  add_shadow(ray_shade(montereybay,zscale=50)) %>%
  plot_3d(montereybay,water=TRUE, windowsize=c(1000,800), watercolor="dodgerblue")
render_camera(theta=-60,  phi=60, zoom = 0.85, fov=30)

#We will apply a negative buffer to create space between adjacent polygons:
mont_county_buff = sf::st_simplify(sf::st_buffer(monterey_counties_sf,-0.003), dTolerance=0.001)

render_polygons(mont_county_buff, 
                extent = attr(montereybay,"extent"), data_column_top = "ALAND",
                scale_data = 300/(2.6E9), color="chartreuse4",
                parallel=TRUE)
render_highquality(clamp_value=10,sample_method="stratified")



# For redlining or PhD Chapter 1 ####
# https://github.com/darwinanddavis/worldmaps/tree/gh-pages/docs/30daymap2020


# https://darwinanddavis.github.io/DataPortfolio/30daymapchallenge/#day23
# Use some of that code for art and redlining and frankee ####

# COVID plot time series and PHD chapter 1  #### 
# https://darwinanddavis.github.io/DataPortfolio/time_series/


#  Raysgader cool
# https://wcmbishop.github.io/rayshader-demo/

# PhD chapter and animal movement
# http://www.pieceofk.fr/a-3d-tour-over-lake-geneva-with-rayshader/

# Spatial autocorrelation explore for redlining?
# https://andrewmaclachlan.github.io/CASA0005repo_20192020/gwr-and-spatially-lagged-regression.html


# For biologging and for redlining holc colours 
# https://arthurwelle.github.io/RayshaderWalkthrough/index.html

# Animaltion of animal
# https://statnmap.com/2019-10-06-follow-moving-particle-trajectory-on-raster-with-rayshader/

# Corelation across temperature data cool visualization
# https://statnmap.com/2018-01-27-spatial-correlation-between-rasters/

# For animal movement
# https://github.com/tylermorganwall/rayshader
# For animal movement?  ####

# https://www.biorxiv.org/content/biorxiv/early/2020/10/26/2020.10.14.338996.full.pdf

# For COVID project and PhD number of weather station and redlining: 
# https://github.com/sporella/30daymap/blob/master/30_amap.R
# https://github.com/tylermorganwall/MusaMasterclass

# https://vinayudyawer.github.io/ATT/docs/ATT_Vignette.html

# --- ---- --- ---- --- ---- --- ---- --- ----
# Animal movement:
# Do for Art ####
# --- ---- --- ---- --- ---- --- ---- --- ----



# Part of R script exploring animal movement, from local to global, from individuals to gloal collective migrations

# Animal movement data visualization


require(rayshader)
data('montereybay')
moss_landing_coord = c(36.806807, -121.793332)
x_vel_out = -0.001 + rnorm(1000)[1:500]/1000
y_vel_out = rnorm(1000)[1:500]/200
z_out = c(seq(0,2000,length.out = 180), seq(2000,0,length.out=10),
          seq(0,2000,length.out = 100), seq(2000,0,length.out=10))

bird_track_lat = list()
bird_track_long = list()
bird_track_lat[[1]] = moss_landing_coord[1]
bird_track_long[[1]] = moss_landing_coord[2]

for(i in 2:500) {
  bird_track_lat[[i]] = bird_track_lat[[i-1]] + y_vel_out[i]
  bird_track_long[[i]] = bird_track_long[[i-1]] + x_vel_out[i]
}

render_points(extent = attr(montereybay,"extent"), 
              lat = unlist(bird_track_lat), long = unlist(bird_track_long), 
              altitude = z_out, zscale=50, color="red")
render_highquality(point_radius = 1,sample_method="stratified")