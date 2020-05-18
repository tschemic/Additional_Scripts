### Highcharter examples

# Example 1
library("highcharter")
data(diamonds, mpg, package = "ggplot2")

hc <- hchart(mpg, "scatter", hcaes(x = displ, y = hwy, group = class))
hc %>% hc_add_theme(hc_theme_google())
htmltools::save_html(html = hc, file = "output3.html")

mpg %>% filter(manufacturer %in% c("audi","volkswagen")) %>% 
  hchart(., type = "scatter",
         hcaes(x = displ,
               y = hwy,
               group = class)) %>% 
  hc_xAxis(title = list(text = "x axis title"),
           majorTickInterval = 5,
    plotLines = list(
      list(label = list(text = "This is a plotLine"),
         color = "black",
         width = 10))) %>% 
  hc_yAxis(title = list(text = "y axis title"),
           majorTickInterval = 5,
           minorTickInterval = 1,
           minorGridLineDashStyle = "LongDashDotDot",
           showFirstLabel = FALSE,
           showLastLabel = FALSE,
           plotLines = list(list(label = list(text = "This is a plotLine"),
                  color = "black", width = 5)))


highchart() %>% 
  hc_add_series(data = c(7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2,
                         26.5, 23.3, 18.3, 13.9, 9.6),
                type = "spline") %>% 
  hc_xAxis(title = list(text = "x Axis at top", style = list(fontSize = "3.0vh")),
           labels = list(step = 1, rotation = -90, style = list(fontSize = "3.0vh")),
           lineWidth = 1.5,
           lineColor = "#000000",
           opposite = FALSE,
           tickWidth = 1.5,
           tickLength = 5,
           tickColor = "#000000",
           plotLines = list(list(label = list(text = "This is a plotLine"),
                  color = "green",
                  width = 2,
                  value = 5.5))) %>% 
  hc_yAxis(title = list(text = "y Axis at right", style = list(fontSize = "3.0vh")),
           lineWidth = 1.5,
           lineColor = "black",
           max = 35,
           opposite = FALSE,
           TickInterval = 2.5,
           gridLineDashStyle = "LongDash",
           gridLineColor = "#ABABAB",
           gridLineWidth = 1,
           tickWidth = 1.5,
           tickLength = 5,
           tickColor = "#000000",
           showFirstLabel = FALSE,
           showLastLabel = TRUE,
           plotBands = list(
             list(from = 25, to = 80, color = "rgba(100, 0, 0, 0.1)",
                  label = list(text = "This is a plotBand"))))




highchart() %>% 
  hc_yAxis_multiples(
    list(top = "0%", height = "30%", lineWidth = 3),
    list(top = "30%", height = "70%", offset = 0,
         showFirstLabel = FALSE, showLastLabel = FALSE)) %>% 
  hc_add_series(data = rnorm(10)) %>% 
  hc_add_series(data = rexp(10), type = "spline", yAxis = 1)

highchart() %>% 
  hc_add_series(data = c(7.0, 6.9, 9.5, 14.5, 18.2, 21.5, 25.2,
                         26.5, 23.3, 18.3, 13.9, 9.6),
                type = "spline") 


# Example 2
library("forecast")

airforecast <- forecast(auto.arima(AirPassengers), level = 95, fan = TRUE)

hchart(airforecast)


require("dplyr")

data("citytemp")

highchart() %>% 
  hc_xAxis(categories = citytemp$month) %>% 
  hc_add_series(name = "Tokyo", data = citytemp$tokyo) %>% 
  hc_add_series(name = "London", data = citytemp$london) %>% 
  hc_exporting(enabled = TRUE,
               filename = "/home/tschemic/Desktop/Test/output")
