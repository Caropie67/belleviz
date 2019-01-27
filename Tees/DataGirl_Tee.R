# Author - Caroline Pierce
# Creation Date - 1/27/2018
# DataGril T-Shirt Graphic

#install.packages("ggplot2")
#install.packages("ggmap")
#install.packages("maps")
#install.packages("mapdata")
#install.packages("grid")
#install.packages("gridExtra")
#install.packages("extrafont")

library(ggplot2)
library(grid)
library(gridExtra)
library(extrafont)

#font_import() # import all your fonts
# requires input - "y" or "n"

data = data.frame(count=c(100, 100, 100), awesomeness=c(" beautiful", " breezy", " easy"))
plot.bar <- ggplot(data, aes(x=awesomeness, y=count, fill=awesomeness)) +
            geom_bar(stat = "identity") +
            geom_text(label=data$awesomeness, hjust=0, position=position_stack(vjust=0), 
                      colour="black", fontface="italic", size=16 ) + 
            geom_text(label=c("100%", "100%", "100%"), vjust = -0.3, angle=-90, 
                      colour="black", size=10 ) + 
            scale_fill_manual(values = c("tomato", "sandybrown", "lightpink")) +
            labs(x="Data Insight\nAwesomeness") +
            theme(legend.position="none",
                  axis.line = element_blank(),
                  axis.text.x = element_blank(),
                  axis.text.y = element_blank(),
                  axis.ticks = element_blank(),
                  axis.title.x = element_blank(),
                  axis.title.y = element_text(size=42, vjust = -5),
                  panel.grid.major=element_blank(),
                  panel.grid.minor=element_blank(),
                  panel.background=element_rect(fill = "white", colour = "white"),
                  plot.margin=margin(t = 0, r = 0, b = -3, l = -3, unit = "pt")) +
            coord_flip()

#plot.bar

# t-shirt layout

png("C:\\Users\\Caroline\\Documents\\cfpTShirts\\DataTees\\DataGirl_Tee.png", 
    width = 4500, height = 5400, units = "px", res=300, bg="black")

text.bot <- textGrob("DATAGIRL", gp=gpar(fontfamily="Broadway", 
                                             fontface="bold", fontsize = 96,
                                             col = "white"))

grobs <- list(plot.bar, text.bot)

layout <- rbind(c(NA, NA, NA),
                c(NA, 1, NA),
                c(NA, 2, NA),
                c(NA, NA, NA))

heights <- c(500, 1550, 500, 2850)

widths <- c(675, 3150, 675)

grid.arrange(grobs=grobs,
             layout_matrix=layout,
             nrow <- 4,
             ncol <- 3,
             heights = heights,
             widths = widths)

dev.off()



