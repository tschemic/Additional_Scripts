library(tidyverse)
library(readxl)

d <- read_ods(path = "Untitled.ods")

d_long = gather(data = d, key = "Day", value = "Result", -mAb, -Alum, -Temperature)
d_long$Day <-  as.numeric(d_long$Day)
d_long$Alum <-  as.factor(d_long$Alum)
d_long$Temperature <- as.factor(d_long$Temperature)
d_long$mAb <- as.factor(d_long$mAb)
d_long$Sample <- paste0(d_long$mAb, d_long$Alum, d_long$Temperature)
d_long$Sample <- as.factor(d_long$Sample)

### extensive cleanup for plot (run before plot) 
cleanup = theme(panel.grid.major = element_blank(),
                panel.grid.minor = element_blank(),
                panel.background = element_blank(),
                axis.line = element_line(color = "black", lineend = "square", size =0.7),
                plot.margin = margin(0.5, 0.5, 0.5, 1, "cm"),
                axis.ticks = element_line(size = 0.7, lineend = "square", color = "black"))

ymax = 8  ### set ylimits manually - optional
ylimits = c(0, ymax)    ### set ylimits manually - optional
yticks = seq(0, 8, 1) ### set y tick marks manually - optional

### Enter axis labels ###
xlb = readline(prompt = "Enter x axis label:")   ### leave blank if no label is needed
ylb = readline(prompt = "Enter y axis label:")

### Change order of data ###
levels(d_long$mAb)
d_long$mAb <- factor(d_long$mAb, levels = c("E3", "C3"))
d_long$Alum <- factor(d_long$Alum, levels = c("no", "yes"))
d_long$Temperature <- factor(d_long$Temperature, levels = c("4°C", "45°C"))  ### change "untr", "tr" to desired conditions in desired order
d_long$Sample <- factor(d_long$Sample, levels = c("E3yes4°C", "E3no4°C", 
                                              "E3yes45°C", "E3no45°C",
                                              "C3yes4°C", "C3no4°C",
                                              "C3yes45°C", "C3no45°C"))

ggplot(data = d_long, aes(x = Sample, y = Result)) +
  stat_summary(fun.y=mean, geom="bar", color="black", fill="yellow", 
               size=0.2, width = 0.6) +
  stat_summary(geom = "errorbar", fun.data = mean_se, width = 0.2) +
  geom_dotplot(binaxis='y', stackdir='center', dotsize = 2, binwidth = 0.11, fill = "grey", color = "grey") +
  cleanup










