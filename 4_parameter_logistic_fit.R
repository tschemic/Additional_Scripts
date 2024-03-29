### Fitting 4 Parameter Logistic (4PL) models to dose-response with dr4pl package

library(dr4pl)

# Default method
sample_data <- sample_data_1[sample_data_1$Dose != 0,] # Filter out dose 0 values for log transformation

a <- dr4pl(dose = sample_data$Dose,
           response = sample_data$Response,
           method.init = "logistic")
plot(a)


# Dataframe method

#data.frame method
b <- dr4pl(data = sample_data,
           dose = Dose,
           response = Response,
           method.init = "logistic")
plot(b)

#compatable with ggplot
library(ggplot2) #load ggplot2

### import plot cleanup
library(RCurl)
eval(parse(text = getURL("https://raw.githubusercontent.com/tschemic/Additional_Scripts/master/plot_cleanup.R", ssl.verifypeer = FALSE)))

### Fit data
c <- dr4pl(Response~Dose, 
           data = sample_data,
           method.init = "logistic",
           trend = "decreasing")
confint(c)

d <- plot(c) 
d
d + cleanup




### Fitting 4 Parameter Logistic (4PL) models to dose-response with drc package
library(drc)
require(dr4pl) # required for sample data
require(RCurl)
eval(parse(text = getURL("https://raw.githubusercontent.com/tschemic/Additional_Scripts/master/plot_cleanup.R", ssl.verifypeer = FALSE)))

### Model building and fitting
data2.LL.4 <- drm(data = sample_data, Response~Dose, fct=LL.4(), na.action = na.omit) # build 4PL model
data2.fits <- expand.grid(conc=exp(seq(log(1.00e-04), log(1.00e+05), length=100))) # predictions and confidence intervals.
pm <- predict(data2.LL.4, newdata=data2.fits, interval="confidence") 
data2.fits$p <- pm[,1]
data2.fits$pmin <- pm[,2]
data2.fits$pmax <- pm[,3] # new data with predictions


### import plot cleanup 
library(RCurl)
eval(parse(text = getURL("https://raw.githubusercontent.com/tschemic/Additional_Scripts/master/plot_cleanup.R", ssl.verifypeer = FALSE)))

xlb <- readline(prompt = "Enter x axis label:") # Enter x-axis title
ylb <- readline(prompt = "Enter y axis label:") # Enter y-axis title
xlimits <- c(1.00e-05, 1.00e+05)    ### set xlimits manually
xticks <- c(1e-05, 1.00e-04, 1.00e-03, 0.01, 0.1, 1, 10, 100, 1000, 1.00e+04, 1.00e+05, 1.00e+06)   ### set xtick marks manually 
ylimits <- c(0, 125000)    ### set ylimits manually
yticks <- c(0, 0.25e+05, 0.5e+05, 0.75e+05, 1e+05, 1.25e+05)   ### set ytick marks manually 

myplot <- ggplot(sample_data, aes(x = Dose, y = Response)) +
  geom_point() +
  xlab(xlb) + ylab(ylb) +
  scale_x_continuous(limits = xlimits, expand = c(0,0), breaks = xticks) +
  scale_y_continuous(limits = ylimits, expand = c(0,0), breaks = yticks) +
  ## geom_ribbon(data=data2.fits, aes(x=conc, y=p, ymin=pmin, ymax=pmax), alpha=0.2) +  ## plots errors
  geom_line(data=data2.fits, aes(x=conc, y=p)) +
  coord_trans(x="log") +
  cleanup

myplot


