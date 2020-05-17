### Stacked scatter plot with mean/s.d. ###
library(ggplot2)
library(extrafont)
loadfonts(device="pdf")

### Backup graphical settings and set global parameters ###
#opar = par()
#par(family = "Liberation Sans")
#par(opar) ### This is to reset graphical parameters to default ###

### Import data ###
rdata = read.table(file.choose(), header = T, sep = ",") ### Data are in long format!!! ###

### extensive cleanup for plot (run before plot) 
cleanup = theme(panel.grid.major = element_blank(),
                panel.grid.minor = element_blank(),
                panel.background = element_blank(),
                axis.line = element_line(color = "black", lineend = "round", size =0.7),
                plot.margin = margin(0.5, 0.5, 0.5, 1, "cm"),
                axis.ticks = element_line(size = 0.7, lineend = "round", color = "black"),
                axis.title.x = element_text(face = "bold", size = 24, color = "black",
                                            margin = margin(1,0,0,0,"cm")),
                axis.title.y = element_text(face = "bold", size = 24, color = "black",
                                            margin = margin(0,1,0,0,"cm")),
                axis.text.x = element_text(face = "bold", size = 20, color = "black",
                                           angle = 0, margin = margin(0.2,0,0,0,"cm")),
                axis.text.y = element_text(face = "bold", size = 14, color = "black",
                                           angle = 0, margin = margin(0,0.2,0,0,"cm")))

vmax = max(rdata$Value, na.rm=T)
vmax
ymax = 3000000
xmax = max(rdata$Conc, na.rm=T)
xmax
xmax = 1000

ylimits = c(0, ymax)    ### set ylimits manually
yticks = c(0, ymax*0.2, ymax*0.4, ymax*0.6, ymax*0.8, ymax)   ### set ytick marks manually 
xlimits = c(0, xmax)    ### set xlimits manually
xticks = c(0, xmax*0.2, xmax*0.4, xmax*0.6, xmax*0.8, xmax)   ### set xtick marks manually 
title = ""

### Enter axis labels ###
# xlb = readline(prompt = "Enter x axis label:")
ylb = readline(prompt = "Enter y axis label:")
xlb = readline(prompt = "Enter x axis label:")
### Plot data ###

myplot = ggplot() +
  geom_line(aes(y = Value, x = Conc, color = Sample), data = rdata) +
  ylab(ylb) +
  xlab(xlb) +
  scale_y_continuous(limits = ylimits, expand = c(0,0), breaks = yticks) +
  scale_x_continuous(limits = xlimits, expand = c(0,0), breaks = xticks) +
  labs(title = title) +
  cleanup

myplot

