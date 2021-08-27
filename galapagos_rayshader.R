# https://medium.com/@benoit.pimpaud/rayshader-experiment-e58f09eb91d
# Also do African Birds:
library(rayshader)
require(raster)
LST = raster('/Users/diegoellis/Desktop/MYD11A2.A2016241_res_compiled_msk_translated_WGS84.tif')
SRTM = raster('/Users/diegoellis/Dropbox/Marius_Galapagos/Inputs/RS_Data_Santa_Cruz/SRTM/SRTM_Santa_Cruz.tif')
SRTM = raster('/Users/diegoellis/Documents/LVM_share/Biosensor/Biosensor/Biosensor/SRTM_30m_Gal_res.tif')
SRTM = resample(SRTM, LST)
b_box = bbox(matrix(c(-92, -90, -1.2 , 0.3), ncol =2))
SRTM = crop(SRTM, b_box)
elmat = matrix(raster::extract(SRTM,raster::extent(SRTM),buffer=1000),
               nrow=ncol(SRTM),ncol=nrow(SRTM)) # -> localtif
elmat %>%
  sphere_shade() %>%
  plot_map()

elmat %>%
  sphere_shade() %>%
  plot_3d(elmat,zscale=60) # baseshape="circle" # zscale = 5
save_3dprint("/Users/diegoellis/Desktop/gal_3d.stl", maxwidth = 40, unit = "mm")
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
  sphere_shade(sunangle = 45, texture = "desert") %>% # Add sungangle
  add_water(detect_water(elmat), color="desert") %>% # desert
  # add_shadow(raymat,0.7) %>% # ray_shade() generates an raytraced shadow layer:
  #  add_shadow(ambmat,0.7) %>% 
  plot_3d(elmat,water = TRUE, zscale=65)
# ambient_shade() generates an ambient occlusion shadow layer:
# You can also apply a post-processing effect to the 3D maps to render maps with depth of field with the render_depth() function:

elmat %>%
  sphere_shade(texture = "desert") %>%
  add_water(detect_water(elmat), color="desert") %>%
  add_shadow(raymat,0.5) %>%
  add_shadow(ambmat,0.5) %>%
  plot_3d(elmat,zscale=65,fov=30,theta=-225,phi=25,windowsize=c(1000,800),zoom=0.3)
# https://github.com/tylermorganwall/rayshader
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# Hummingbird biodiversity:
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
EM_ELEV <- raster('/Users/diegoellis/Desktop/INVENTORY_RICHNESS/Hummingbird_richness_EM_ELEV.tif')
central_america <- extent(-2.5e+06, 0.5e+06, -1e+06, 1e+06)
EM_ELEV_ca <- crop(EM_ELEV, central_america)
EM_ELEV_2 <- aggregate(EM_ELEV_ca, fact=10)
EM_ELEV_3 <- aggregate(EM_ELEV_2, fact=7)
plot(EM_ELEV_3)
elmat = matrix(raster::extract(EM_ELEV_3,raster::extent(EM_ELEV_3),buffer=1000),
               nrow=ncol(EM_ELEV_3),ncol=nrow(EM_ELEV_3)) # -> localtif
elmat %>%
  sphere_shade() %>%
  plot_3d(elmat,zscale=2) # baseshape="circle" # zscale = 5
save_3dprint("/Users/diegoellis/Desktop/hum_SDM_3d.stl", maxwidth = 80, unit = "mm")
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
# Just need African birds now
# --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- --- ---
