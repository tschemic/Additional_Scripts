library(ggplot2)
library(ggrepel)

theme_set(
  theme_bw() +
    theme(legend.position = "top")
)

#Load data
data("mtcars")
df <- mtcars
df$cyl <- as.factor(df$cyl)

# Initialize plot
b <- ggplot(df, aes(x = wt, y = mpg))


# Add text to the plot
.labs <- rownames(df)
b + geom_point(aes(color = cyl)) +
  geom_text_repel(aes(label = .labs,  color = cyl), size = 3)+
  scale_color_manual(values = c("#00AFBB", "#E7B800", "#FC4E07"))

# Draw a rectangle underneath the text, making it easier to read.
b + geom_point(aes(color = cyl)) +
  geom_label_repel(aes(label = .labs,  color = cyl), size = 3)+
  scale_color_manual(values = c("#00AFBB", "#E7B800", "#FC4E07"))



