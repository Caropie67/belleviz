# Author - Caroline Pierce
# Creation Date - 11/3/2018
# What Do You Want to Graph Today T-Shirt Graphic

#install.packages("ggplot2")
#install.packages("ggmap")
#install.packages("maps")
#install.packages("mapdata")
#install.packages("grid")
#install.packages("gridExtra")
#install.packages("extrafont")
#install.packages("RColorBrewer")

library(ggplot2)
library(grid)
library(gridExtra)
library(extrafont)
library(RColorBrewer)

#font_import() # import all your fonts
# requires input - "y" or "n"

# colors:
pink <- "#e03293"
brown <- "#633504"
yellow <- "#e0a919"
orange <- "#ea7d28"
white <- "#ffffff"

data = data.frame(x=c(1, 2, 3, 1, 2, 3, 1, 2, 3),
                  y=c(1, 1, 1, 2, 2, 2, 3, 3, 3),
                  z=c(1, 2, 3, 2, 3, 4, 3, 4, 5))

plot.red = ggplot(data, aes(x = x, y = y, fill = z)) + 
    geom_tile(color = "black", size = 1) +
    scale_fill_gradientn(colors=brewer.pal(5, "Reds")) +
    theme(legend.position="none",
      axis.line = element_blank(),
      axis.text.x = element_blank(),
      axis.text.y = element_blank(),
      axis.ticks = element_blank(),
      axis.title.x = element_blank(),
      axis.title.y = element_blank(),
      panel.grid.major=element_blank(),
      panel.grid.minor=element_blank(),
      panel.background=element_rect(fill = "black", colour = "black"),
      plot.margin=margin(t = 0, r = 0, b = -3, l = -3, unit = "pt"))
plot.red


plot.green = ggplot(data, aes(x = x, y = y, fill = z)) + 
    geom_tile(color = "black", size = 1) +
    scale_fill_gradientn(colors=brewer.pal(5, "Greens")) +
    theme(legend.position="none",
          axis.line = element_blank(),
          axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          axis.ticks = element_blank(),
          axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          panel.grid.major=element_blank(),
          panel.grid.minor=element_blank(),
          panel.background=element_rect(fill = "black", colour = "black"),
          plot.margin=margin(t = 0, r = 0, b = -3, l = -3, unit = "pt"))
plot.green

plot.blue = ggplot(data, aes(x = x, y = y, fill = z)) + 
    geom_tile(color = "black", size = 1) +
    scale_fill_gradientn(colors=brewer.pal(5, "Blues")) +
    theme(legend.position="none",
          axis.line = element_blank(),
          axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          axis.ticks = element_blank(),
          axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          panel.grid.major=element_blank(),
          panel.grid.minor=element_blank(),
          panel.background=element_rect(fill = "black", colour = "black"),
          plot.margin=margin(t = 0, r = 0, b = -3, l = -3, unit = "pt"))
plot.blue

plot.yellow = ggplot(data, aes(x = x, y = y, fill = z)) + 
    geom_tile(color = "black", size = 1) +
    scale_fill_gradientn(colors=c("#ffffcc", "#ffff99", "#ffff66", "#ffff33", "#ffff00")) +
    theme(legend.position="none",
          axis.line = element_blank(),
          axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          axis.ticks = element_blank(),
          axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          panel.grid.major=element_blank(),
          panel.grid.minor=element_blank(),
          panel.background=element_rect(fill = "black", colour = "black"),
          plot.margin=margin(t = 0, r = 0, b = -3, l = -3, unit = "pt"))
plot.yellow

# t-shirt layout

png("C:\\Users\\Caroline\\Documents\\cfpTShirts\\DataTees\\WhatToGraphToday_Tee.png", 
    width = 4500, height = 5400, units = "px", res=300, bg="transparent")

text.top <- textGrob('What do you want', 
                     gp=gpar(fontsize = 84, col = "white"))

text.top2 <- textGrob('to graph today?', 
                      gp=gpar(fontsize = 84, col = "white"))

grobs <- list(text.top, text.top2, plot.red, plot.green, plot.blue, plot.yellow)

layout <- rbind(c(NA, 1, 1, NA),
                c(NA, 2, 2, NA),
                c(NA, 3, 4, NA),
                c(NA, 5, 6, NA),
                c(NA, NA, NA, NA))

heights <- c(500, 500, 1050, 1050, 2300)

widths <- c(1200, 1050, 1050, 1200)

grid.arrange(grobs=grobs,
             layout_matrix=layout,
             nrow <- 5,
             ncol <- 4,
             heights = heights,
             widths = widths)

dev.off()
