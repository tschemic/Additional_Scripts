# Load libraries
library(ggplot2)
library(ggExtra)

# Load data
data("mtcars")
df <- mtcars
df$cyl <- as.factor(df$cyl)
df$class <- ifelse(df$cyl == 4, "low", "high")
df$class <- ifelse(df$cyl == 6, "medium", df$class)

# make a usual ggplot and store it
# point size increased, legend to the bottom
p1 <- ggplot(df, aes(x=mpg, y=wt , color=cyl)) +
  geom_point(size=2.5) +
  theme(legend.position="bottom")

# Label plot
#p1 + geom_text(x=15, y=2, label="8 cylinders", color = "black")
p2 <- p1 + annotate(geom="text", x=15, y=2, label="8 cylinders",
              color="black")

p3 <- p2 + stat_ellipse(type = "norm", linetype = 2, level = 0.95)
p3

# marginal boxplot
# relative size of the central plot increased
p4 <- ggMarginal(p3, type="density", size=7, groupColour = TRUE)
p4



