df <- tibble(parameter = c("p1", "p2", "p3", "p4"), gmr = c(100, 105, 102, 96), 
             lower = c(98, 102, 99, 94), upper = c(102, 108, 105, 98))

ggplot(df, aes(x=parameter, y=gmr)) +
  geom_crossbar(aes(ymin = gmr, ymax = gmr)) +
  geom_errorbar(aes(ymin = lower, ymax = upper), width = 0.25) +
  geom_hline(yintercept = c(67, 80, 100, 125, 150), lty = 2) +
  scale_y_continuous(breaks = c(20,40,60,80,100,120,140,160), limits = c(0,160), expand = c(0,0)) +
  theme_bw() +
  #geom_vline(xintercept = c(1.5,3.5)) +
  geom_rect(aes(xmin=1.5, xmax=3.5, ymin=0, ymax=160), color = "grey", alpha = 0.03, size=0)




