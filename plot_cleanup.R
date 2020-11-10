### extensive cleanup for plot (run before plot) 
fsize = 18
cleanup = theme(panel.grid.major = element_blank(),
                panel.grid.minor = element_blank(),
                panel.background = element_blank(),
                axis.line = element_line(color = "black", lineend = "square", size =0.7),
                plot.margin = margin(0.5, 0.5, 0.5, 2, "cm"),
                axis.ticks = element_line(size = 0.7, lineend = "square", color = "black"),
                axis.ticks.length = unit(.1,"cm"),
                axis.title.x = element_text(face = "bold", size = fsize, vjust = -2),
                axis.title.y = element_text(face = "bold", size = fsize, vjust = 5),
                axis.text.x = element_text(size = fsize*0.75, face = NULL, 
                                hjust = NULL, vjust = NULL, angle = NULL,
                                margin = margin(5,0,0,0,"pt")),
                axis.text.y = element_text(size = fsize*0.75,
                                margin = margin(0,5,0,0,"pt")),
                legend.background = element_blank(),
                legend.key = element_blank(),
                legend.title = element_text(size = fsize),
                legend.text = element_text(size = fsize*0.9),
                plot.title = element_text(size = fsize*1.25),
                legend.position = "right")

