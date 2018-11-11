# Author - Caroline Pierce
# Creation Date - 8/26/2018
# Plot a Tree T-Shirt Graphic

#install.packages("ggplot2")
#install.packages("grid")
#install.packages("gridExtra")
#install.packages("extrafont")
#install.packages("treemapify")
#install.packages("RColorBrewer")

library(ggplot2)
library(grid)
library(gridExtra)
library(extrafont)
library(treemapify)
library(RColorBrewer)

cars <- mtcars
cars$carname <- rownames(cars)

tree <- ggplot(mtcars, aes(area = disp, fill = cyl)) +
     geom_treemap(show.legend = FALSE, colour="#ffffcc", size=4) +
     scale_fill_gradientn(colors=c("#78c679", "#31a354", "#006837")) + 
    #scale_fill_gradientn(colors=brewer.pal(11, "RdYlGn")) 
    #scale_fill_gradientn(colors=brewer.pal(3, "Greens")) 
    theme(plot.margin=margin(t = 0, r = 0, b = -3, l = -3, unit = "pt"),
          panel.border = element_rect(fill = NA, colour = "#ffffcc", size=4))
tree

# t-shirt layout

png("C:\\Users\\Caroline\\Documents\\cfpTShirts\\DataTees\\PlotATree_Tee.png", 
    width = 4500, height = 5400, units = "px", res=300, bg="transparent")

text.top <- textGrob("plot a tree", gp=gpar(fontfamily="Kristen ITC", 
                                        fontface="bold", fontsize = 96,
                                        col = "#ffffcc"))

text.bottom <- textGrob("(map) today", gp=gpar(fontfamily="Kristen ITC", 
                                      fontface="bold", fontsize = 96,
                                        col = "#ffffcc"))


grobs <- list(text.top, tree, text.bottom)


layout <- rbind(c(NA, 1, NA),
                c(NA, 2, NA),
                c(NA, 3, NA),
                c(NA, NA, NA))

heights <- c(600, 1800, 500, 2500)

widths <- c(1350, 1800, 1350)


grid.arrange(grobs=grobs,
             layout_matrix=layout,
             nrow <- 4,
             ncol <- 3,
             heights = heights,
             widths = widths)

dev.off()



