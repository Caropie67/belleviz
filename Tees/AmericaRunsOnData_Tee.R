# Author - Caroline Pierce
# Creation Date - 8/26/2018
# America Runs on Data T-Shirt Graphic

#install.packages("ggplot2")
#install.packages("ggmap")
#install.packages("maps")
#install.packages("mapdata")
#install.packages("grid")
#install.packages("gridExtra")
#install.packages("extrafont")

library(ggplot2)
library(ggmap)
library(maps)
library(mapdata)
library(grid)
library(gridExtra)
library(extrafont)

#font_import() # import all your fonts
# requires input - "y" or "n"

# colors:
pink <- "#e03293"
brown <- "#633504"
yellow <- "#e0a919"
orange <- "#ea7d28"
white <- "#ffffff"

data = data.frame(count=c(10, 20, 30, 40), category=c("A", "B", "C", "D"))
plot.bar <- ggplot(data, aes(x=category, y=count)) +
            geom_bar(stat = "identity", fill=white, colour=white) +
            theme(legend.position="none",
                  axis.line = element_blank(),
                  axis.text.x = element_blank(),
                  axis.text.y = element_blank(),
                  axis.ticks = element_blank(),
                  axis.title.x = element_blank(),
                  axis.title.y = element_blank(),
                  panel.grid.major=element_blank(),
                  panel.grid.minor=element_blank(),
                  panel.background=element_rect(fill = yellow, colour = yellow),
                  plot.margin=margin(t = 0, r = 0, b = -3, l = -3, unit = "pt"))
#plot.bar

# it is necessary to layer each graph on top of a square so dimensions are uniform
plot.square <- ggplot() + 
               geom_rect(xmin = 0, xmax = 0,   ymin = Inf, ymax = Inf)
plot.square.bar <- plot.square + 
                   theme(panel.background=element_rect(fill = yellow, colour = yellow),
                   plot.margin=margin(t = 0, r = 0, b = -3, l = -3, unit = "pt")) +
                   annotation_custom(ggplotGrob(plot.bar), xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = Inf)
#plot.square.bar

# http://eriqande.github.io/rep-res-web/lectures/making-maps-with-R.html
usa <- map_data("usa")
plot.map <- ggplot() +
            geom_polygon(data = usa, aes(x=long, y = lat, group = group), fill=white, colour=white) + 
            coord_fixed(1.3) +
            theme(
            axis.line = element_blank(),
            axis.text.x = element_blank(),
            axis.text.y = element_blank(),
            axis.ticks = element_blank(),
            axis.title.x = element_blank(),
            axis.title.y = element_blank(),
            panel.grid.major=element_blank(),
            panel.grid.minor=element_blank(),
            panel.background=element_rect(fill = orange, colour = orange),
            plot.margin=margin(t = 0, r = 0, b = -3, l = -3, unit = "pt"))
#plot.map

plot.square.map <- plot.square + 
                   theme(panel.background=element_rect(fill = orange, colour = orange),
                   plot.margin=margin(t = 0, r = 0, b = -3, l = -3, unit = "pt")) +
                   annotation_custom(ggplotGrob(plot.map), xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = Inf)
#plot.square.map

# not using donut but keeping for reference
# https://stackoverflow.com/questions/13615562/ggplot-donut-chart
# Add addition columns, needed for drawing with geom_rect.
data$fraction = data$count / sum(data$count)
data = data[order(data$fraction), ]
data$ymax = cumsum(data$fraction)
data$ymin = c(0, head(data$ymax, n=-1))

plot.donut <- ggplot(data, aes(ymax=ymax, ymin=ymin, xmax=4, xmin=2)) +
              geom_rect(fill=white, colour=pink, lwd=4) +
              coord_polar(theta="y") +
              xlim(c(0, 4)) +
              theme(legend.position="none",
              axis.line = element_blank(),
              axis.text.x = element_blank(),
              axis.text.y = element_blank(),
              axis.ticks = element_blank(),
              axis.title.x = element_blank(),
              axis.title.y = element_blank(),
              panel.grid.major=element_blank(),
              panel.grid.minor=element_blank(),
              panel.background=element_rect(fill = pink, colour = pink),
              plot.margin=margin(t = 0, r = 0, b = -3, l = -3, unit = "pt"))
#plot.donut

# Not using pie - but keeping code for future reference
# http://www.sthda.com/english/wiki/ggplot2-pie-chart-quick-start-guide-r-software-and-data-visualization
data2 = data.frame(count=c(15, 15, 70), category=c("A", "B", "C"))
plot.pie <- ggplot(data2, aes(x="", y=count)) +
            geom_bar(width = 1, stat = "identity", fill=white, colour=pink, lwd=4) +
            coord_polar(theta="y") +
            theme(legend.position="none",
            axis.line = element_blank(),
            axis.text.x = element_blank(),
            axis.text.y = element_blank(),
            axis.ticks = element_blank(),
             axis.title.x = element_blank(),
            axis.title.y = element_blank(),
            panel.grid.major=element_blank(),
            panel.grid.minor=element_blank(),
            panel.background=element_rect(fill = pink, colour = pink),
            plot.margin=margin(t = 0, r = 0, b = -3, l = -3, unit = "pt"))
#plot.pie


plot.square.pie <- plot.square + 
                   theme(panel.background=element_rect(fill = pink, colour = pink),
                   plot.margin=margin(t = 0, r = 0, b = -3, l = -3, unit = "pt")) +
                   annotation_custom(ggplotGrob(plot.pie), xmin = -Inf, xmax = Inf, ymin = -Inf, ymax = Inf)
#plot.square.pie

# not using density plot but keeping for future reference
#https://github.com/tidyverse/ggplot2/issues/1528
plot.density <- ggplot(NULL, aes(c(-2,2))) +  
                geom_area(stat = "function", fun = dnorm, fill = white, xlim = c(-2, 2)) +
                theme(legend.position="none",
                axis.line = element_blank(),
                axis.text.x = element_blank(),
                axis.text.y = element_blank(),
                axis.ticks = element_blank(),
                axis.title.x = element_blank(),
                axis.title.y = element_blank(),
                panel.grid.major=element_blank(),
                panel.grid.minor=element_blank(),
                panel.background=element_rect(fill = yellow, colour = yellow),
                plot.margin=margin(t = 0, r = 0, b = -3, l = -3, unit = "pt"))
#plot.density

#http://www.sthda.com/english/wiki/ggplot2-line-plot-quick-start-guide-r-software-and-data-visualization

# not using series but keeping for reference
series <- data.frame(x=c(1, 2, 3, 4, 5), y=c(1, 10, 5, 7, 12))
plot.line <- ggplot(data=series, aes(x=x, y=y)) +
             geom_line(colour=white, lwd=5) +
             geom_point(colour=white, size=8) +
             theme(legend.position="none",
             axis.line = element_blank(),
             axis.text.x = element_blank(),
             axis.text.y = element_blank(),
             axis.ticks = element_blank(),
             axis.title.x = element_blank(),
             axis.title.y = element_blank(),
             panel.grid.major=element_blank(),
             panel.grid.minor=element_blank(),
             panel.background=element_rect(fill = yellow, colour = yellow),
             plot.margin=margin(t = 0, r = 0, b = -4, l = -3, unit = "pt"))    
#plot.line

# t-shirt layout

png("C:\\Users\\Caroline\\Documents\\cfpTShirts\\DataTees\\AmericaRunsOnData_Tee.png", 
    width = 4500, height = 5400, units = "px", res=300, bg="transparent")

text.top <- textGrob("AMERICA", gp=gpar(fontfamily="Bauhaus 93", 
                                        fontface="bold", fontsize = 96,
                                        col = white))
text.bot <- textGrob("RUNS ON DATA", gp=gpar(fontfamily="Bauhaus 93", 
                                             fontface="bold", fontsize = 96,
                                             col = white))

grobs <- list(text.top, plot.square.map, plot.square.bar, plot.square.pie, text.bot)

layout <- rbind(c(NA, 1, 1, 1, NA),
                c(NA, 2, 3, 4, NA),
                c(NA, 5, 5, 5, NA),
                c(NA, NA, NA, NA, NA))

heights <- c(500, 1050, 500, 3350)

widths <- c(675, 1050, 1050, 1050, 675)

grid.arrange(grobs=grobs,
             layout_matrix=layout,
             nrow <- 4,
             ncol <- 5,
             heights = heights,
             widths = widths)

dev.off()



