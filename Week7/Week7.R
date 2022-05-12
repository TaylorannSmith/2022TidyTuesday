






ufo_sightings <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-06-25/ufo_sightings.csv")
ufo <- ufo_sightings
rm(ufo_sightings)
str(ufo)

library(lubridate)
library(tidyverse)
library(here)






ufo$date_time <- mdy_hm(ufo$date_time) 
ufo$city_area <- factor(ufo$city_area)
ufo$state <- factor(ufo$state)
ufo$country <- factor(ufo$country)
ufo$shape <- factor(ufo$ufo_shape)
str(ufo)



ufoUS <- filter(ufo, ufo$country=="us")
ufoUS <- filter(ufoUS, ufoUS$latitude< 50)
ufoUS <- filter(ufoUS, ufoUS$latitude> 25)


library(png)
library(grid)

space_background <- png::readPNG("/Users/taylorannsmith/Desktop/2022TidyTuesday/Week7/sky.png")


states <- map_data("state")
#Plot states
p <- ggplot(data = states) + 
  annotation_custom(rasterGrob(space_background, 
                               width = unit(2,"npc"), 
                               height = unit(2,"npc")), -Inf, Inf, -Inf, Inf) + 
  geom_polygon(fill = 'black',aes(x = long, y = lat,  group = group), 
               color = "midnightblue") + coord_fixed(1.3) 
p <- p  + geom_point(data=ufoUS, alpha = .1, shape = 20, color="green", size=0.1, 
                     mapping=aes(x=longitude, y=latitude))+
  theme(plot.title = element_text(size=9.5)) +
  ggtitle("REPORTED UFO OBSERVATIONS IN THE U.S") +
  xlab("Longitude") +
  ylab("Latitude")

p

ggsave(here("Desktop", "week7.png"))



