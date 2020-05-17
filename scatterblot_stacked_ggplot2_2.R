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
                axis.ticks = element_line(size = 0.7, lineend = "round", color = "black"))

vmax = max(rdata$Value, na.rm=T)
vmax
ymax = 1250000000
ylimits = c(0, ymax)    ### set ylimits manually
yticks = c(0, ymax*0.2, ymax*0.4, ymax*0.6, ymax*0.8, ymax)   ### set ytick marks manually 
                
### Enter axis labels ###
# xlb = readline(prompt = "Enter x axis label:")
ylb = readline(prompt = "Enter y axis label:")
### Plot data ###


myplot = ggplot(rdata, aes(x=Sample, y=Value)) +      ### add color=Sample in the parentathesis to get group coloring
  geom_point(size=4, alpha=0.7, color="black", position=position_jitter(w=0.1, h=0)) +
  ylab(ylb) +
  xlab("") +
  theme(axis.title.y = element_text(face = "bold", size = 24, color = "black", margin = margin(0,1,0,0,"cm"))) +
  theme(axis.text.x = element_text(face = "bold", size = 20, color = "black", angle = 45, vjust = 0.9, hjust = 1)) +
  theme(axis.text.y = element_text(face = "bold", size = 16, color = "black", angle = 0, margin = margin(0,0.2,0,0,"cm"))) +
  scale_y_continuous(limits = ylimits, expand = c(0,0), breaks = yticks) +
  stat_summary(fun.y=mean, fun.ymin = mean, fun.ymax= mean, geom="crossbar", color="black", fill="black", size=0.4, width = 0.3) +         
  stat_summary(fun.ymin=function(x)(mean(x)-sd(x)), 
               fun.ymax=function(x)(mean(x)+sd(x)),
               geom="errorbar", width=0.1) +
  cleanup     ### Alternative cleanup is: theme_bw() - is built-in
myplot  

### Save plot to file ###

png("myplot.png", family = "Liberation Sans",  bg = "transparent")
myplot
dev.off()

pdf("myplot.pdf", family = "Liberation Sans")
myplot
dev.off()

