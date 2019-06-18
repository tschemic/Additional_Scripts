### extensive cleanup for plot (run before plot) 
cleanup = theme(panel.grid.major = element_blank(),
                panel.grid.minor = element_blank(),
                panel.background = element_blank(),
                axis.line = element_line(color = "black", lineend = "square", size =0.7),
                plot.margin = margin(0.5, 0.5, 0.5, 1, "cm"),
                axis.ticks = element_line(size = 0.7, lineend = "square", color = "black"))

