library(rayshader)
require(raster)
SRTM = raster('/Users/diegoellis/Dropbox/Marius_Galapagos/Inputs/RS_Data_Santa_Cruz/SRTM/SRTM_Santa_Cruz.tif')
# raster::raster("hobart.tif") -> localtif
SRTM -> localtif
elmat = matrix(raster::extract(localtif,raster::extent(localtif),buffer=1000),
               nrow=ncol(localtif),ncol=nrow(localtif))

elmat %>%
  sphere_shade() %>%
  plot_map()

elmat %>%
  sphere_shade() %>%
  plot_3d(elmat,zscale=50)

library(rayshader) 
#Printing the included `montereybay` dataset:

#Printing `volcano`:
elmat %>%
  sphere_shade() %>%
  plot_3d(elmat,zscale=3)
save_3dprint("volcano_3d.stl", maxwidth = 4, unit = "in")
# ## Dimensions of model are: 4.00 inches x 2.79 inches x 1.88 inches

raymat = ray_shade(elmat,lambert = TRUE)
ambmat = ambient_shade(elmat)

elmat %>%
  sphere_shade(sunangle = 45, texture = "imhof1") %>% # Add sungangle
  add_water(detect_water(elmat), color="imhof1") %>% # desert
  add_shadow(raymat,0.7) %>% # ray_shade() generates an raytraced shadow layer:
  add_shadow(ambmat,0.7) %>% # ambient_shade() generates an ambient occlusion shadow layer:
  plot_map()


# rayshader also supports 3D mapping by passing a texture map (either external or one produced by rayshader) into the plot_3d function.
elmat %>%
  sphere_shade(sunangle = 45, texture = "imhof1") %>% # Add sungangle
  add_water(detect_water(elmat), color="imhof1") %>% # desert
  add_shadow(raymat,0.7) %>% # ray_shade() generates an raytraced shadow layer:
  add_shadow(ambmat,0.7) %>% 
  plot_3d(elmat,water = TRUE, zscale=10)# ,fov=0,theta=135,zoom=0.75,phi=45, windowsize = c(1000,800))

elmat %>%
  sphere_shade(sunangle = 45, texture = "desert") %>% # Add sungangle
  add_water(detect_water(elmat), color="desert") %>% # desert
 # add_shadow(raymat,0.7) %>% # ray_shade() generates an raytraced shadow layer:
#  add_shadow(ambmat,0.7) %>% 
  plot_3d(elmat,water = TRUE, zscale=10)
render_depth(focus=0.6,focallength = 200)
# ambient_shade() generates an ambient occlusion shadow layer:

# You can also apply a post-processing effect to the 3D maps to render maps with depth of field with the render_depth() function:
  
  elmat %>%
  sphere_shade(texture = "desert") %>%
  add_water(detect_water(elmat), color="desert") %>%
  add_shadow(raymat,0.5) %>%
  add_shadow(ambmat,0.5) %>%
  plot_3d(elmat,zscale=10,fov=30,theta=-225,phi=25,windowsize=c(1000,800),zoom=0.3)
# https://github.com/tylermorganwall/rayshader