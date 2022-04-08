library(palmerpenguins)
library(tidyverse)
library(here)
library(beyonce)
library(devtools)
library(dadjoke)
library("praise")
library(palmerpenguins)
library(tidyverse)
library(ggplot2)
library(viridis)
library(devtools)
library(beyonce)




games <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-03-16/games.csv')



LifeisStrange<-filter(.data = games, gamename == "Life is Strange" | gamename == "Life is Strange 2" | gamename== "Life is Strange: Before the Storm")


LifeisStrange %>% 
  ggplot(aes(x = year, y = avg,
             color = gamename)) +
  geom_jitter()+
  labs(title = "Performance of 3 editions of Life is Strange the video game",
       x="Year", 
       y="Average number of game plays")+
  scale_color_manual(values = beyonce_palette(5))+
  theme_light()+
  theme(legend.position = "none", axis.title.y = element_text(color = "purple", size=15), #remove legend etc.
        axis.title.y.right = element_text(size=13),
        plot.title = element_text(hjust = 0.5), panel.background = element_rect(fill = "linen"))+
  theme(legend.position = "none")+
  facet_grid(~gamename)


ggsave(here("Week3","plot3.png"))

