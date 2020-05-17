### Barplot with stacked scatter plot with mean/s.d. ###
library(ggplot2)


### Import data ###
rdata = read.table(file.choose(), header = TRUE, sep = "\t") ### Data are in long format!!! ###
rdata
dim(rdata)

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
rdata$sample <- factor(rdata$sample, levels = c("untr", "tr"))  ### change "untr", "tr" to desired conditions in desired order


### Plot data ###

myplot = ggplot(rdata, aes(x=sample, y=value)) +      ### add color=Sample in the parentathesis to get group coloring
  ylab(ylb) +
  xlab(xlb) +
  theme(axis.title.y = element_text(face = "bold", size = 14, color = "black", margin = margin(0,0.3,0,0,"cm"))) +
  theme(axis.title.x = element_text(face = "bold", size = 14, color = "black", margin = margin(0.3,0,0,0,"cm"))) +
  theme(axis.text.x = element_text(face = "bold", size = 12, color = "black", angle = 0, vjust = 0.2, hjust = 0.5)) +
  theme(axis.text.y = element_text(face = "bold", size = 10, color = "black", angle = 0, margin = margin(0,0.1,0,0,"cm"))) +
  scale_y_continuous(limits = ylimits, breaks = yticks, expand = c(0,0)) +  ##limits = ylimits, breaks = yticks - add this for manual y ticks and limits
  #scale_x_continuous(expand = c(0,0)) +  ##limits = xlimits, breaks = xticks - add this for manual x ticks and limits
  stat_summary(fun.y=mean, geom="bar", color="black", fill="yellow", size=0.2, width = 0.6) +  ### chane "goem=" to "bar" for barchart       
  #geom_errorbar(aes(ymin=value-se, ymax=value+se)) +
  #stat_summary(fun.ymin=function(x)(mean(x)-sd(x)), ### these 3 lines are for sd error bars
  #fun.ymax=function(x)(mean(x)+sd(x)),
  #geom="errorbar", width=0.1) +
  stat_summary(geom = "errorbar", fun.data = mean_se, width = 0.2) +
  #geom_point(size=1, color="grey40", position=position_jitter(w=0.1, h=0)) +
  geom_dotplot(binaxis='y', stackdir='center', dotsize = 2, binwidth = 0.11, fill = "grey", color = "grey") +
  cleanup     ### Alternative cleanup is: theme_bw() - is built-in

myplot

label.df <- data.frame(sample = c("untr", "tr"), value = c(4.5, 7.5), signif = c("*", "***"))
myplot + geom_text(data = label.df, label = label.df$signif, size = 10)

