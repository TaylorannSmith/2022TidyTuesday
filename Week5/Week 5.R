# Get the Data
library(tidyverse)
library(here)
# Read in with tidytuesdayR package 
# Install from CRAN via: install.packages("tidytuesdayR")
# This loads the readme and all the datasets for the week of interest



nyt_titles <- readr::read_tsv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-05-10/nyt_titles.tsv')
nyt_full <- readr::read_tsv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-05-10/nyt_full.tsv')



tt_full <- filter(.data = nyt_full, year == "2020")
tt_titles <- filter(.data = nyt_titles, year == "2020", total_weeks >"10")

#------------------------------------------------------------------------------------------


# 2022-05-10
# TidyTuesday week 19, NYTimes best sellers
# Data from Post45 Data

# Libraries
library(tidyverse)
library(MetBrewer)
library(ggbump)
library(gt)
library(gtExtras)
library(gTests)
library(showtext)
# Data
nyt_titles <- readr::read_tsv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-05-10/nyt_titles.tsv')
nyt_full <- readr::read_tsv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2022/2022-05-10/nyt_full.tsv')

# Prepare table data
df1 = nyt_titles %>% slice_max(total_weeks, n=10) %>%
  mutate(title=str_to_title(title)) 

df2 = nyt_full %>% filter(title_id %in% df1$id) %>%
  mutate(rank=-1*rank) %>%
  group_by(id=title_id) %>%
  arrange(week) %>%
  summarise(timeline=list(rank),.groups="drop")

df3 = df1 %>% left_join(df2, by="id")

# {gt} table
df3 %>%
  select(-id) %>%
  mutate(wk = total_weeks) %>%
  relocate(wk,.after=total_weeks) %>%
  gt() %>%
  gt_theme_nytimes() %>%
  gt_sparkline(timeline, label=F, range_colors = c("lightgreen", "lightblue")) %>%
  gt_plt_bar_pct(wk, fill="green") %>%
  cols_width(wk~px(100),
             first_week~px(100)) %>%
  cols_align(align="right", columns=first_week) %>%
  cols_label(total_weeks="total weeks",
             first_week="first week",
             debut_rank="debut rank",
             best_rank="best rank",
             wk="") %>%
  tab_header(title="NY Times bestsellers",
             subtitle=md("List of titles with more than 80 total weeks on the fiction bestseller list of ***The New York Times*** between the years of 1931 and 2020, arranged in descending order of total weeks.")) %>%
  tab_source_note("#TidyTuesday week 19 | Data from Post45 Data by way of Sara Stoudt") %>%
  tab_style(style = list(cell_text(style = "italic", color="black")),
            locations = cells_body(columns = title))

# Bump chart
library(showtext)
showtext_opts(dpi = 300)
showtext_auto(enable = TRUE)
font_add_google("Source Sans Pro")
f1 = "Source Sans Pro"

df4 = nyt_full
  
nyt_full %>% 
  mutate(yr = (week)) %>%
  filter(year == "2020") %>%
  group_by(title_id) %>%
  mutate(n=n())

selected = df4 %>% filter(rank==1) %>% count(title_id, sort=T) %>% filter(n>1) %>% pull(title_id)

lab = df4 %>% filter(title_id %in% selected) %>% group_by(title_id) %>% filter(week==min(week))

nytplot<-df4 %>%
  ggplot(aes(x=week, y=rank)) +
  geom_point(color="grey", alpha=.8, size=.5) +
  ggbump::geom_bump(aes(group=title_id), alpha=.7, size=.6, color="black") +
  ggbump::geom_bump(data= df4 %>% filter(title_id %in% selected), 
                    aes(group=title_id, color=title), 
                    alpha=.8, size=1, show.legend = F) +
  geom_point(data= df4 %>% filter(title_id %in% selected),
             size=.7, shape=21, fill="white", color="black", stroke=.3) +
  geom_text(data=lab %>% filter(title_id!=414 & title_id!=6601 & title_id!=6126), 
            aes(y=0.6,label=str_to_title(title), color=title), 
            size=4, show.legend=F, family=f1, hjust=0, fontface="bold") +
  geom_text(data=lab %>% filter(title_id %in% c(414,6601,6126)), 
            aes(y=0.1,label=str_to_title(title),color=title), 
            size=4, show.legend=F, family=f1, hjust=0, fontface="bold") +
  scale_x_date(expand=c(0.02,0.02), date_breaks = "1 month", date_labels = "%b") +
  scale_y_reverse(breaks=seq(1,15,1), expand=c(0.02,0.02),
                  labels=c("Rank 1","","","4","","","7","","","10","","","13","","")) +
  MetBrewer::scale_color_met_d("Lakota") +
  coord_cartesian(clip="off") +
  theme_minimal(14) +
  theme(text=element_text(family=f1),
        legend.position = "top",
        plot.subtitle = element_text(size=12.5, margin=margin(b=10)),
        plot.title.position = "plot",
        plot.title=element_text(family=f1, face="bold", size=15.5),
        panel.grid=element_blank(),
        axis.title=element_blank(),
        axis.ticks=element_line(color="black", size=.4),
        axis.ticks.length=unit(.25, "cm"),
        axis.text=element_text(color="black"),
        plot.caption=element_text(hjust=0, color="black", size=11),
        plot.margin=margin(.5,.9,.3,.35, unit="cm"),
        plot.caption.position = "plot") +
  labs(title="NY Times Bestsellers 2020")

ggsave(here("2022TidyTuesday","Week5", "plot.png"))
