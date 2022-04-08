#Created by: Taylorann Smith
#2022-04-07
#Tidy Tuesday week4


#Load Libraries
library(plotly)
library(reprex)

#------------------------------------------------------------------------------------
#Load data

DuBois<-tibble::tribble(
  ~Year, ~Property.Valuation,
  1870L,             300000,
  1871L,             800000,
  1872L,            1100000,
  1873L,            1200000,
  1874L,            1150000,
  1875L,            1200000,
  1876L,            1180000,
  1877L,            1100000,
  1878L,            1050000,
  1879L,            1050000,
  1880L,            1200000,
  1881L,            1400000,
  1882L,            1600000,
  1883L,            1800000,
  1884L,            1900000,
  1885L,            2000000,
  1886L,            2200000,
  1887L,            2500000,
  1888L,            2700000,
  1889L,            3200000,
  1890L,            3400000,
  1891L,            4000000,
  1892L,            4700000,
  1893L,            4850000,
  1894L,            4600000,
  1895L,            4300000,
  1896L,            4300000,
  1897L,            4200000,
  1898L,            4300000,
  1899L,            4300000,
  1900L,            4350000
  )




fig <- plot_ly(DuBois, x= ~Year, y= ~Property.Valuation, type= 'scatter', mode= 'lines+markers')%>% #Type of plot is a scatter plot but added a line with individual marks for easy viewing
  layout(title = list(text='Property Value of Black Americans from 1870-1900', y = 0.95, x = 0.5, xanchor = 'center', yanchor =  'top'), plot_bgcolor = "#e5ecf6")# in order to change title, it has to be as a list of text laytout(title=list(text='Whatever you want it to say'))
fig




























