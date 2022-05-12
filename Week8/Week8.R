
library(tidyverse)
library(rmdformats)
library(here)
library(hrbrthemes)
library(viridis)
library(htmlwidgets)
library(plotly)
library(beyonce)

samples<-read.csv("/Users/taylorannsmith/Desktop/2022TidyTuesday/Week8/All Nautilus Samples.csv")


samples$Total<-as.numeric(samples$Total)

NMS<- read.csv("/Users/taylorannsmith/Desktop/Thesis R/Final Niskin Data.csv")

data3<- read.csv("/Users/taylorannsmith/Desktop/Thesis R/Final Niskin Data.csv")


#Sample types----------------------------------------------------------------------------------
Water_Samples <-filter(.data= samples, Sample_type== "Niskin")
Urchins<-filter(.data= samples, Sample_type== "Urchin")
Sea_pens<-filter(.data= samples, Sample_type== "Sea Pen")
Drift_algae<-filter(.data= samples, Sample_type== "Drift Algae")
Sediment<-filter(.data= samples, Sample_type== "Push Core")
Sea_pigs<-filter(.data= samples, Sample_type== "Sea Pig")

# Site -------------------------------------------------------------------------------
Pioneer_Canyon_North<-filter(.data = samples, Site== "Pioneer Canyon North")
Octocone_Whalle_Fall<-filter(.data = samples, Site== "Octocone/Whalle-Fall")
South_Ancapa_Slope<-filter(.data = samples, Site== "South Ancapa Slope")
Poti_Penninsula<-filter(.data = samples, Site== "Poti Penninsula")
Santa_Lucia_Palm<-filter(.data = samples, Site== "Santa Lucia Palm")
Southwest_Davidson_Seamount<-filter(.data = samples, Site== "Southwest Davidson Seamount")
Offshore_San_Miguel<-filter(.data = samples, Site== "Offshore San Miguel")
West_San_Miguel_Shelf<-filter(.data = samples, Site== "West San Miguel Shelf")
Rock_Bridge<-filter(.data = samples, Site== "Rock Bridge")
North_Santa_Cruz<-filter(.data = samples, Site== "North Santa Cruz Island")
Santa_Lucia_Escarpment<-filter(.data = samples, Site== "Santa Lucia Escarpment ")# Go back and delete space after the title in excel


# Begin playing with code!-----------------------------------------------------

library(ggplot2)
library(dplyr)
library(plotly)
library(viridis)
library(hrbrthemes)
#-------------------------------------------------------------------------------


Water_sample_plot<- plot_ly(Water_Samples, x = ~Depth..m., y = ~Total, type = 'scatter', mode = 'markers', size = ~Total, color = ~Sample_type, colors = 'Paired',
                            sizes = c(15, 50),
                            marker = list(opacity = 0.5, sizemode = 'diameter'),
                            hoverinfo = 'text',
                            text = ~paste('Depth(m):', Depth..m., 'Total MP:', Total, 'Type:', Sample_type))
Water_sample_plot<- Water_sample_plot %>% layout(title = 'Total Number of Microplastics by Depth (m)',
                                                 xaxis = list(showgrid = FALSE),
                                                 yaxis = list(showgrid = FALSE),
                                                 showlegend = FALSE)
Water_sample_plot
