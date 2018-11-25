# Author - Caroline Pierce
# Creation Date - 11/15/2018
# Plot on Earth T-Shirt Graphic

library(grid)
library(gridExtra)
library(extrafont)

# World map

#code example from http://egallic.fr/en/maps-with-r/
library(rworldmap)
library(dplyr)
library(ggplot2)
library(geosphere)

worldMap <- getMap()
world.points <- fortify(worldMap)
world.points$region <- world.points$id

world.df <- world.points[,c("long","lat","group", "region")]
#head(world.df)

worldmap <- ggplot() + 
    geom_polygon(data = world.df, aes(x = long, y = lat, group = group, fill=region)) +
    scale_y_continuous(breaks = (-2:2) * 30) +
    scale_x_continuous(breaks = (-4:4) * 45) +
    coord_map("ortho", orientation =  c(20, -30, 23.5)) +
    theme(legend.position="none",
          axis.text.x = element_blank(),
          axis.text.y = element_blank(),
          axis.ticks = element_blank(),
          axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          plot.background = element_rect(fill = "transparent", colour="transparent"),
          panel.grid.major = element_line(size = 2, colour = "white"),
          panel.background=element_rect(fill = "transparent"))
worldmap

# t-shirt layout

#"#00c0c0"

png("C:\\Users\\Caroline\\Documents\\cfpTShirts\\DataTees\\PlotOnEarth_Tee.png", 
    width = 4500, height = 5400, units = "px", res=300, bg="transparent")

text.top <- textGrob("Plot on Earth", gp=gpar(fontfamily="Mistral", 
                                        fontface="bold", fontsize = 159,
                                        col = "white"))

text.bottom <- textGrob("Goodwill to Men", gp=gpar(fontfamily="Mistral", 
                                      fontface="bold", fontsize = 159,
                                        col = "white"))


grobs <- list(text.top, worldmap, text.bottom)


layout <- rbind(c(NA, 1, NA),
                c(NA, 2, NA),
                c(NA, 3, NA),
                c(NA, NA, NA))

heights <- c(600, 1800, 600, 2400)

widths <- c(1350, 1800, 1350)

grid.arrange(grobs=grobs,
             layout_matrix=layout,
             nrow <- 4,
             ncol <- 3,
             heights = heights,
             widths = widths)

dev.off()



