library(tidyverse)
library(here)
library(tidytext)
library(caret)
library(lubridate)
library(ggstatsplot)
library(dplyr)
library(hrbrthemes)
library(png)
library(patchwork)



billboard <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-09-14/billboard.csv')
glimpse(billboard)


Ye<-filter(.data = billboard, performer== "Kanye West", weeks_on_chart>= 24)


Plot<-Ye %>% 
ggplot(aes(x=song,
           y = weeks_on_chart,
           fill= song))+
  geom_boxplot() + 
  scale_fill_manual(values = beyonce_palette(55))+
  labs(x = "Song Title", 
       y = "Number of weeks on chart",
       title = "Most Popular Kanye West Songs",
       subtitle="Includes all records from the years 2004 - 2021",
       caption = "Source: Billboard Top 100")+
  facet_wrap(~performer, scale = "free")+
  theme_ipsum()+
  theme(legend.position = "none", axis.title = element_text(color = "#583C0B", size=13),plot.title = element_text(hjust = 0.5), panel.background = element_rect(fill = "linen"))
  
  
PicYe<- readPNG("/Users/taylorannsmith/Desktop/YeMeme.png", native = TRUE)
 
KanYe<- Plot+
  inset_element(p = PicYe,
                left = 0.5,
                bottom = 0.55,
                right = 0.95,
                top = 0.95)
KanYe
ggsave(here("Week2","Output", "TidyTwosYe.png"))#Save the plot as a png in the correct folder

