#First TidyTuesday: Plastic Pollution






#Libraries
library(tidyverse)
library(here)
library(beyonce)
library(devtools)
library(viridis)
# Get the Data

# Read data

tuesdata <- tidytuesdayR::tt_load('2021-01-26')
tuesdata <- tidytuesdayR::tt_load(2021, week = 5)

plastics <- tuesdata$plastics

# Or read in the data manually

plastics <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2021/2021-01-26/plastics.csv')

longdata<-plastics %>% #pivot the data longer so that I can make a plot of the different types of plastics
  filter(complete.cases(.)) %>%
pivot_longer(cols = pet:pvc , # the cols you want to pivot. This says select the temp to percent SGD cols
               names_to = "Plastic_Type", # the names of the new columns with all the previously used column names
               values_to = "Plastic_Count")
#want to make a sep column for each country,



# names of the new column with all the values of the original columns
view(longdata)
US<-
Argentina

data_2019<-filter(.data = longdata, year == 2019)
data_2020<-filter(.data = longdata, year == 2020)
data_2021<-filter(.data = longdata, year == 2021)
#Plot----------------------------------------------------------
p1<-data_2019 %>% 
  ggplot( aes(x = Plastic_Type,y=Plastic_Count, fill=Plastic_Type)) + 
  geom_col() +
  labs(title = "Types of plastic produced in 2019",
       x="Plastic Type", 
       y="Plastic Count",
       caption = "Source: Break Free From Plastic")+ 
  scale_fill_manual(values = beyonce_palette(6))+
  theme(legend.position = "none") +
  facet_wrap(~country)

p1
ggsave(here("Week1","first_tidytuesday.png"))  

