########################################################
# By Bervelin Lumesa                                   #
#                                                      #
# Mail     : lumesabervelin@gmail.com                  #
# Github   : https://github.com/bervelin-lumesa        #
# Twitter  : https://twitter.com/bervelinL             #
# Linkedin : https://linkedin/in/bervelin-lumesa       #
########################################################

# loading libraries
library(sf)      # for the map
library(dplyr)   # for data manipulation (and the pile : %>%)
library(ggplot2) # for plottingNot run)


# Loading the shapefile 
# these shapefiles can be found here : https://geonode.wfp.org/layers/geonode%3Acod_admbnda_adm2_rgc_20170711
drc_shape <- st_read("cod_admbnda_adm2_rgc_20170711.shp")

# the class of the object
class(drc_shape)

# the structure of the object
str(drc_shape)

# print unique values of an object
unique(drc_shape$ADM1_FR)

# filtering the dataset
kwango_shape <- drc_shape %>%
  filter(ADM1_FR == "Kwango")

# generate a map
ggplot(data = kwango_shape) + 
  geom_sf(color = "blue", fill = "white") + 
  ggtitle(label = "Kwango province map") + 
  coord_sf() + 
  theme_void()

# creating a random dataset
set.seed(14) # to make the dataset reproducible
survey_df <- data.frame(longitude = rnorm(20, mean = 18, sd = 0.7),
                        latitude  = rnorm(20, mean = -7, sd = 0.5),
                        status    = sample(c("O", "N"), 20, replace = T),
                        region    = sample(kwango_shape$ADM2_FR, 20, replace = T),
                        num       = rnorm(20, mean = 200, sd = 20)
)

# generate a map with points
ggplot(data = kwango_shape) + 
  geom_sf(color = "blue", fill = "white") + 
  geom_point(data= survey_df, aes(x = longitude, y = latitude, color = status), size = 3) + 
  ggtitle(label = "Kwango province map with points") + 
  coord_sf() + 
  theme_void()


# create summary table
survey_sum <- survey_df %>%
  group_by(region) %>%
  summarise(num = mean(num))

# joining
all_df <- kwango_shape %>%
  left_join(survey_sum, by = c("ADM2_FR" = "region"))

# Thematic map
ggplot() + 
  geom_sf(data =all_df, aes(fill = num), color = "white") + 
  ggtitle(label = "Kwango province Thematic map") + 
  #  scale_fill_gradient2("Variable to illustrate", low = "white", high = "blue") + 
  scale_fill_viridis_c("Variable to illustrate") + 
  coord_sf() + 
  theme_void()

# Thematic map 2
ggplot() + 
  geom_sf(data = drc_shape %>% filter(ADM1_FR %in% c("Kwango", "Kwilu", "Maï-Ndombe")), fill = "white") + 
  geom_sf(data =all_df, aes(fill = num), color = "white") + 
  ggtitle(label = "Old Bandundu province") + 
#  scale_fill_gradient2("Variable to illustrate", low = "white", high = "blue") + 
  scale_fill_viridis_c("Variable to illustrate") + 
  coord_sf() + 
  theme_void()


