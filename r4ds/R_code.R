########################### R code described in "R for Data Science" book #################################

########################## Part I: Explore ################################################################

########################## Chapter 1: Data Visualization with ggplot2 ####################################

library(tidyverse)

######################### First Steps #######################

mpg
?mpg
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))

## Exercises
# 2)
dim(mtcars) # 32 rows and 11 columns
# 4)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = hwy, y = cyl))
# 5)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = class, y = drv)) # points are overlapping

########################## Aesthetic Mappings ############################

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = class)) # controls color of points

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, size = class)) # controls size
# warning for mapping an unordered variable to an ordered aesthetic - not good

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, alpha = class)) # controls transparency

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, shape = class)) # controls shape
# by default ggplot plots only 6 shapes at a time, rest is not plotted!

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

## Exercises
# 3)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = year))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, size = year))

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, shape = year))
# 4)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = hwy, size = hwy))
# 5)
?geom_point
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, stroke = cyl)) # controls stroke thickness
# 6)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, color = displ < 5))

############################### Facets ###############################

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ class, nrow = 2)

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(drv ~ cyl) # faceting by 2 categorical variables

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(. ~ cyl) # faceting only x axis, not y axis

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_grid(cyl ~ .) # faceting only y axis, not x axis

## Exercises
# 1)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) +
  facet_wrap(~ year) # faceting by continuous variable creates bins
# 2)
ggplot(data = mpg) +
  geom_point(mapping = aes(x = drv, y = cyl)) # shows combinations with no values like facet_grid(drv ~ cyl)
# 5)
?facet_wrap

##################################### Geometric Objects ##########################

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy))
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, linetype = drv))

ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy))
ggplot(data = mpg) +
  geom_smooth(mapping = aes(x = displ, y = hwy, group = drv)) # using only group does not add legend/distinguishing feature 
ggplot(data = mpg) +
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend = FALSE
  )

ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy)) + # multiple geoms
  geom_smooth(mapping = aes(x = displ, y = hwy)) # local mapping for each geom

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) + # global mapping
  geom_point() +
  geom_smooth()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) + # local mapping overwrites global mapping
  geom_smooth()

ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = class)) +
  geom_smooth(
    data = filter(mpg, class == "subcompact"),
    se = FALSE
  )

## Exercises
# 2)
ggplot(
  data = mpg,
  mapping = aes(x = displ, y = hwy, color = drv)
) +
  geom_point() +
  geom_smooth(se = FALSE)

# 6)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(se = FALSE)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point() +
  geom_smooth(mapping = aes(group = drv), se = FALSE)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(color = drv)) +
  geom_smooth(mapping = aes(lty = drv), se = FALSE)
ggplot(data = mpg, mapping = aes(x = displ, y = hwy)) +
  geom_point(mapping = aes(fill = drv), shape = 21, color = "white", size = 3, stroke = 2)

################################### Statistical transformations #######################

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut))
?geom_bar() # default value for stat (statistical transformation) in geom_bar is count

ggplot(data = diamonds) +
  stat_count(mapping = aes(x = cut)) # stats and geoms can be used interchangeably - same plot as above
# default geom for stat_count is bar

demo <- tribble(
  ~a,
  ~b,
  "bar_1", 20,
  "bar_2", 30,
  "bar_3", 40
)
ggplot(data = demo) +
  geom_bar(
    mapping = aes(x = a, y = b), stat = "identity") # overwriting default stat
# plot values of y instead of count

ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(x = cut, y = ..prop.., group = 1)) 
# overwrites default mapping from transformed variables to aesthetics

ggplot(data = diamonds) +
  stat_summary(
    mapping = aes(x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median)
# summarizes y values for each unique value of x

## Exercises
# 1)
?stat_summary # default geom for stat_summary is point_range
ggplot(data = diamonds) +
  geom_pointrange(mapping = aes(x = cut, y = depth),
                  stat = "summary",
                  fun.min = min,
                  fun.max = max,
                  fun = median)

# 2)
?geom_col # uses "identity" as the default stat in contrast to geom_bar (uses "count")

# 4)
?stat_smooth

# 5)
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, y = ..prop..)) # w/o group argument prop is calculated within each group
ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(x = cut, fill = color, group = color, y = ..prop..))

################################ Position Adjustments ############################################

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, color = cut)) # color defines border color
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = cut)) # fill defines fill color

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, fill = clarity))
# fill with other variable than x causes stacking because of position = "stack" in geom_bar
# this position adjustment can be changed to "identity", "dodge" or "fill"

ggplot(
  data = diamonds,
  mapping = aes(x = cut, fill = clarity)
) +
  geom_bar(alpha = 1/5, position = "identity")
ggplot(
  data = diamonds,
  mapping = aes(x = cut, color = clarity)
) +
  geom_bar(fill = NA, position = "identity")
# with position = "identity" the objects overlap in the graph for bar charts - more useful in 2D (e.g. points)


ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(x = cut, fill = clarity),
    position = "fill"
  )
# position = "fill" is useful for comparing proportions

ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(x = cut, fill = clarity),
    position = "dodge"
  )
# position = "fill" is useful for comparing individual values for groups (bars side-by-side)

ggplot(data = mpg) +
  geom_point(
    mapping = aes(x = displ, y = hwy),
    position = "jitter" # position = "jitter" adds noise to position to avoid overlapping
  )
# geom_jitter() is a shorthand for geom_point(position = "jitter")

## Exercises
# 1)
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() # problem: overlapping points

ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_jitter() # geom_jitter() shows all points

# 2)
?geom_jitter # width and height parameters control amount of jittering (horizontally and vertically)

# 3)
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_count() # also adds information about number of values at specific position to show overlap

# 4)
?geom_boxplot # default position argument is "dodge2"

ggplot(data = mpg) +
  geom_boxplot(mapping = aes(x = drv, y = hwy))


###################################### Coordinate Systems ###########################################

ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot()
ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot() +
  coord_flip() # flips the axis

nz <- map_data("nz")
ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", color = "black")
ggplot(nz, aes(long, lat, group = group)) +
  geom_polygon(fill = "white", color = "black") +
  coord_quickmap() # sets the aspect ratio correctly for maps

bar <- ggplot(data = diamonds) +
  geom_bar(
    mapping = aes(x = cut, fill = cut),
    show.legend = FALSE,
    width = 1
  ) +
  theme(aspect.ratio = 1) +
  labs(x = NULL, y = NULL)
bar + coord_flip()
bar + coord_polar() # uses polar coordinates - connected to bar charts

## Exercises
# 1)
bar <-  ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = factor(1), fill = clarity), width = 1)

bar
bar + coord_polar(theta = "y") # turns stacked bar chart into pie chart

# 2)
?labs() # modification of axes labels and titles

# 3)
?coord_map # projects spherical area onto 2D plane
?coord_quickmap # preserves straight lines

# 4)
ggplot(data = mpg, mapping = aes(x = cty, y = hwy)) +
  geom_point() +
  geom_abline() + # adds straight line to plot
  coord_fixed() # fixes coordinate ratio


################################ Chapter 3: Data Transformation with dplyr ###################################

library(nycflights13)
library(tidyverse)

?flights
flights

################################ Filter Rows with filter() #################################################

filter(flights, month == 1, day == 1) # filter observations/rows

jan1 <- filter(flights, month == 1, day == 1) # dplyr never modifies original data

(dec25 <- filter(flights, month == 12, day == 25)) # printing result and assigning in 1 line

# Check for equality - take care of floating point numbers vs. integers
sqrt(2) ^ 2 == 2
1/49 * 49 == 1
# Both are false because the computer cannot store an infinite number of digits
near(sqrt(2) ^ 2, 2)
near(1 / 49 * 49, 1) # near() can be used to check for this kind of equality

filter(flights, month == 11 | month == 12) # flights from Nov or Dec
nov_dec <- filter(flights, month %in% c(11, 12)) # alternative to above

filter(flights, !(arr_delay > 120 | dep_delay > 120))
filter(flights, arr_delay <= 120, dep_delay <= 120) # same as above - according to De Morgans's law

df <- tibble(x = c(1, NA, 3))
filter(df, x > 1) # filter removes NA values by default
filter(df, is.na(x) | x > 1) # has to be included specifically in filter to keep NAs

## Exercises
# 1)
# a)
filter(flights, arr_delay >= 2)
# b)
filter(flights, dest %in% c("IAH", "HOU"))
# c)
filter(flights, carrier %in% c("UA", "AA", "DL"))
# d)
filter(flights, month %in% c(7,8,9))
# e)
filter(flights, arr_delay > 120 & dep_delay <= 0)
# f)
filter(flights, dep_delay >= 60 & arr_delay < 30)
# g)
filter(flights, dep_time == 2400 | dep_time < 600)

# 2)
filter(flights, dep_time == 2400 | between(dep_time, 0, 600))

# 3)
filter(flights, is.na(dep_time))


##################################### Arrange Rows with arrange() ####################################

arrange(flights, year, month, day) # used to order rows/observations by one or multiple columns/variables
arrange(flights, desc(arr_delay)) # desc() for descending order of specific column

df <- tibble(x = c(5, 2, NA))
arrange(df, x) # NAs are always at the end
arrange(df, desc(x))

## Exercises
# 1)
arrange(df, desc(is.na(x)))
# 2)
arrange(flights, desc(dep_delay), dep_time)
# 3)
arrange(flights, air_time)
# 4)
arrange(flights, distance)
arrange(flights, desc(distance))


##################################### Select Columns with select() ########################################

# Select columns by name
select(flights, year, month, day)
# Select all columns between year and day (inclusive)
select(flights, year:day)
# Select all columns except those from year to day (inclusive)
select(flights, -(year:day))
# helper functions for select(): starts_with(), ends_with(), contains(), matches(), num_range()

rename(flights, tail_num = tailnum) # for renaming variables (renaming can also be done directly with select())

select(flights, time_hour, air_time, everything()) # everything() means the rest - useful for column reordering

## Exercises
# 1)
select(flights, dep_time ,dep_delay , arr_time , arr_delay)
select(flights, dep_time:arr_delay, -sched_dep_time, -sched_arr_time)
# 2)
select(flights, dep_time, dep_time ,dep_delay , arr_time , arr_delay)
# 3)
vars <- c(
  "year", "month", "day", "dep_delay", "arr_delay"
)
select(flights, one_of(vars)) 
# selects all columns that mach and gives warning for not matching (all_of() selects only if all elements match)
# 4)
select(flights, contains("TIME")) # is not case sensitive by default (ignore.case = TRUE)


##################################### Add New Variables with mutate() #########################################
require(nycflights13)

flights_sml <- select(flights,
                      year:day,
                      ends_with("delay"),
                      distance,
                      air_time
)
mutate(flights_sml,
       gain = arr_delay - dep_delay,
       speed = distance / air_time * 60 )

mutate(flights_sml,
       gain = arr_delay - dep_delay,
       hours = air_time / 60,
       gain_per_hour = gain / hours ) # just created columns can be referred to

transmute(flights, # only keeps the newly generated columns
          gain = arr_delay - dep_delay,
          hours = air_time / 60,
          gain_per_hour = gain / hours )

transmute(flights,
          dep_time,
          hour = dep_time %/% 100, # integer division
          minute = dep_time %% 100 # remainder from integer division (modulus)
)

(x <- 1:10)
lag(x) # returns lagging values (e.g. for computing running differences)
lead(x) # returns leading values

x
cumsum(x) # cumulative sum (base R function together with: cumprod(), cummin() , cummax())
cummean(x) # cumulative mean (from dplyr)
# For computing rolling aggregates see RcppRoll package

y <- c(1, 2, 2, NA, 3, 5)
min_rank(y) # used for ranking - by default smallest value get lowest rank, ties are possible with no subsequent rank
min_rank(desc(y))
# other ranking functions:
row_number(y)
dense_rank(y) # ties with subsequent rank (no empty ranks)
percent_rank(y)
cume_dist(y) # cumulative distribution

## Exercises
# 1)
transmute(flights,
          dep_time,
          sched_dep_time,
          dep_time_min_to_midnight = (dep_time %/% 100)*60 + dep_time %% 100,
          sched_dep_time_min_to_midnight = (sched_dep_time %/% 100)*60 + sched_dep_time %% 100
)
# 2)
transmute(flights,
          dep_time,
          arr_time,
          dep_time_min_to_midnight = (dep_time %/% 100)*60 + dep_time %% 100,
          arr_time_min_to_midnight = (arr_time %/% 100)*60 + arr_time %% 100,
          diff_time = arr_time_min_to_midnight - dep_time_min_to_midnight,
          air_time,
          diff = air_time - diff_time)
# Problem: time difference between origin and destination!!!
# 3)
transmute(flights,
          dep_time , 
          sched_dep_time , 
          dep_delay)
# 4)
?min_rank
arrange(flights,
        min_rank(desc(dep_delay)))


##################################### Grouped Summaries with summarize() ####################################

summarize(flights, delay = mean(dep_delay, na.rm = TRUE)) # collapses df into single row
# usually only useful when paired with group_by

by_day <- group_by(flights, year, month, day)
summarize(by_day, delay = mean(dep_delay, na.rm = TRUE))

# explore the relationship between the distance and average delay for each location - use of pipes
by_dest <- group_by(flights, dest)
delay <- summarize(by_dest,
                   count = n(),
                   dist = mean(distance, na.rm = TRUE),
                   delay = mean(arr_delay, na.rm = TRUE)
)
delay <- filter(delay, count > 20, dest != "HNL")
ggplot(data = delay, mapping = aes(x = dist, y = delay)) +
  geom_point(aes(size = count), alpha = 1/3) +
  geom_smooth(se = FALSE)
# It looks like delays increase with distance up to ~750 miles
# and then decrease. Maybe as flights get longer there's more
# ability to make up delays in the air?

# Same analysis with the use of the pipe
delays <- flights %>%
  group_by(dest) %>%
  summarize(
    count = n(),
    dist = mean(distance, na.rm = TRUE),
    delay = mean(arr_delay, na.rm = TRUE)
  ) %>%
  filter(count > 20, dest != "HNL")

flights %>%
  group_by(year, month, day) %>%
  summarize(mean = mean(dep_delay))
flights %>%
  group_by(year, month, day) %>%
  summarize(mean = mean(dep_delay, na.rm = TRUE)) # na.rm = TRUE is important for aggregation functions to avoid NAs

# Alternative to avoid NAs: remove cancelled flights
not_cancelled <- flights %>%
  filter(!is.na(dep_delay), !is.na(arr_delay))
not_cancelled %>%
  group_by(year, month, day) %>%
  summarize(mean = mean(dep_delay))

# It is always good to include a count (n()) or count of nonmissing values (sum(!is.na(x)) in aggregations as control
delays <- not_cancelled %>%
  group_by(tailnum) %>%
  summarize(
    delay = mean(arr_delay)
  )
ggplot(data = delays, mapping = aes(x = delay)) +
  geom_freqpoly(binwidth = 10) # looks like some planes have huge average delay
delays <- not_cancelled %>%
  group_by(tailnum) %>%
  summarize(
    delay = mean(arr_delay, na.rm = TRUE),
    n = n()
  )
ggplot(data = delays, mapping = aes(x = n, y = delay)) +
  geom_point(alpha = 1/10) # planes with huge delay have low number of flights!

# Combination of dplyr pipe with ggplot2
delays %>%
  filter(n > 25) %>% # filter out planes low number flights to get a better picture with more reliable data
  ggplot(mapping = aes(x = n, y = delay)) + # note: switch from %>% to + from dplyr to ggplot2
  geom_point(alpha = 1/10)

# Relationship of variance and sample size
# Convert to a tibble so it prints nicely
batting <- as_tibble(Lahman::Batting)
batters <- batting %>%
  group_by(playerID) %>%
  summarize(
    ba = sum(H, na.rm = TRUE) / sum(AB, na.rm = TRUE), # ba is batting average (skill level of player)
    ab = sum(AB, na.rm = TRUE) # ab is at bat - number of opportunities
  )
batters %>%
  filter(ab > 100) %>% 
  ggplot(mapping = aes(x = ab, y = ba)) +
        geom_point() +
        geom_smooth(se = FALSE)
# variation decreases with increasing number of data points
# positive correlation between skill level and opportunities - better players get more bats

batters %>%
  arrange(desc(ba)) # also important for sorting - number of data points has to be considered

# Aggregation with logical subsetting
not_cancelled %>%
  group_by(year, month, day) %>%
  summarize(
    # average delay:
    avg_delay1 = mean(arr_delay),
    # average positive delay:
    avg_delay2 = mean(arr_delay[arr_delay > 0])
  )

# Measures of spread: sd(), IQR(), mad() (median absolute deviation)
# Why is distance to some destinations more variable than to others?
not_cancelled %>%
  group_by(dest) %>%
  summarize(distance_sd = sd(distance)) %>% # calculates sd for each dest
  arrange(desc(distance_sd))

# Measures of rank min(x) , quantile(x, 0.25) , max(x)
# When do the first and last flights leave each day?
not_cancelled %>%
  group_by(year, month, day) %>%
  summarize(
    first = min(dep_time),
    last = max(dep_time)
  )

# Measures of position first(x) , nth(x, 2) , last(x)
not_cancelled %>%
  group_by(year, month, day) %>%
  summarize(
    first_dep = first(dep_time),
    last_dep = last(dep_time)
  )

not_cancelled %>%
  group_by(year, month, day) %>%
  mutate(r = min_rank(desc(dep_time))) %>%
  filter(r %in% range(r)) # filtering on ranks

# Counts: n(), sum(!is.na(x)) (nonmissing values), n_distinct(x) (distinct/unique values)
# Which destinations have the most carriers?
not_cancelled %>%
  group_by(dest) %>%
  summarize(carriers = n_distinct(carrier)) %>%
  arrange(desc(carriers))

not_cancelled %>%
  count(dest) # short helper for count

not_cancelled %>%
  count(tailnum, wt = distance) # count with weight (total number of miles for each plane)

# Counts and proportions of logical values (TRUE/FALSE = 1/0)
# How many flights left before 5am? (these usually
# indicate delayed flights from the previous day)
not_cancelled %>%
  group_by(year, month, day) %>%
  summarize(n_early = sum(dep_time < 500))

# What proportion of flights are delayed by more than an hour?
not_cancelled %>%
  group_by(year, month, day) %>%
  summarize(hour_perc = mean(arr_delay > 60))

# Grouping by Multiple Variables
daily <- group_by(flights, year, month, day)
(per_day <- summarize(daily, flights = n()))
(per_month <- summarize(per_day, flights = sum(flights)))
(per_year <- summarize(per_month, flights = sum(flights)))

# Ungrouping
daily %>%
  ungroup() %>%
  # no longer grouped by date
  summarize(flights = n()) # all flights

## Exercises
# 2)
not_cancelled %>% count(dest)
not_cancelled %>% 
  group_by(dest) %>% 
  summarise(n = n())

not_cancelled %>% count(tailnum, wt = distance)
not_cancelled %>% 
  group_by(tailnum) %>% 
  summarise(n = sum(distance))

# 4)
flights %>% 
  group_by(year, month, day) %>% 
  summarise(n_cancelled = sum(is.na(dep_delay)) ) %>% 
  ggplot(mapping = aes(x = month, y = log2(n_cancelled))) +
    geom_point()

flights %>% 
  group_by(year, month, day) %>% 
  summarise(avg_delay = mean(dep_delay, na.rm = TRUE), 
            prop_cancelled = mean(is.na(dep_delay)) ) %>% 
  ggplot(mapping = aes(x = avg_delay, y = log2(prop_cancelled))) +
  geom_point()

# 5)
flights %>% 
  group_by(carrier) %>% 
  summarise(avg_delay = mean(dep_delay[dep_delay > 0], na.rm = TRUE)) %>% 
  arrange(desc(avg_delay))

flights %>% 
  group_by(carrier, origin) %>% 
  summarise(avg_delay = mean(dep_delay[dep_delay > 0], na.rm = TRUE)) %>% 
  arrange(desc(avg_delay))

# 6)
flights %>% 
  group_by(tailnum) %>% 
  filter(dep_delay <= 60) %>% 
  summarise(n_flights = n())

# 7)
not_cancelled %>%
  count(dest, sort = TRUE) # sort = TRUE sorts output


################################### Grouped Mutates (and Filters) ############################################

# Find the worst members of each group:
flights_sml %>%
  group_by(year, month, day) %>%
  filter(rank(desc(arr_delay)) < 10)

# Find all groups bigger than a threshold:
popular_dests <- flights %>%
  group_by(dest) %>%
  filter(n() > 365)
popular_dests

# Standardize to compute per group metrics:
popular_dests %>%
  filter(arr_delay > 0) %>%
  mutate(prop_delay = arr_delay / sum(arr_delay)) %>%
  select(year:day, dest, arr_delay, prop_delay)

## Exercises
# 2)
flights %>% 
  group_by(tailnum) %>% 
  filter(dep_delay > 0) %>% 
  summarise(mean_delay = mean(dep_delay, na.rm = TRUE)) %>% 
  arrange(desc(mean_delay))

# 3)
flights %>% 
  filter(!is.na(dep_delay)) %>% 
  #group_by(year, month, day) %>% 
  ggplot(mapping = aes(x = dep_time, y = dep_delay)) +
    geom_point()

# 4)
flights %>% 
  filter(!is.na(dep_delay)) %>% 
  count(dest, wt = dep_delay)

flights %>% 
  filter(!is.na(dep_delay)) %>% 
  group_by(dest, flight) %>% 
  select(dest, flight, dep_delay) %>% 
  summarise(total = sum(dep_delay),
            prop = dep_delay / sum(dep_delay))

# 7)
flights %>% 
  group_by(dest) %>% 
  summarise(car = length(unique(carrier))) %>% 
  filter(car >= 2) %>% 
  arrange(desc(car))


##################################### Chapter 5: Exploratory Data Analysis ########################################

require(tidyverse)

##################################### Visualizing Distributions ##################################################

ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut)) # visualizing distribution of categorical variable

diamonds %>%
  count(cut) # calculate distribution manually

ggplot(data = diamonds) +
  geom_histogram(mapping = aes(x = carat), binwidth = 0.5) # visualizing distribution of continuous variable

diamonds %>%
  count(cut_width(carat, 0.5)) # calculate distribution manually

smaller <- diamonds %>%
  filter(carat < 3) # filter small diamonds
ggplot(data = smaller, mapping = aes(x = carat)) +
  geom_histogram(binwidth = 0.1) # lower bin width

ggplot(data = smaller, mapping = aes(x = carat, color = cut)) +
  geom_freqpoly(binwidth = 0.1) # good for overlaying multiple histograms/distributions

ggplot(data = smaller, mapping = aes(x = carat)) +
  geom_histogram(binwidth = 0.01) # reducing bin width exposes patterns and groups/clusters

ggplot(data = faithful, mapping = aes(x = eruptions)) +
  geom_histogram(binwidth = 0.25) # histogram shows two clusters

ggplot(diamonds) +
  geom_histogram(mapping = aes(x = y), binwidth = 0.5) # outliers are not visible in histogram
ggplot(diamonds) +
  geom_histogram(mapping = aes(x = y), binwidth = 0.5) +
  coord_cartesian(ylim = c(0, 50)) # shows unusual values/outliers
unusual <- diamonds %>%
  filter(y < 3 | y > 20) %>%
  arrange(y)
unusual

## Exercises
# 1)
ggplot(data = smaller, mapping = aes(x = x)) +
  geom_histogram(binwidth = 0.01) 

ggplot(data = smaller, mapping = aes(x = y)) +
  geom_histogram(binwidth = 0.5) +
  coord_cartesian(ylim = c(0,50))
filtery <- diamonds %>%
  filter(y > 3 & y < 20)
ggplot(data = filtery, mapping = aes(x = y)) +
  geom_histogram(binwidth = 0.01)

ggplot(data = smaller, mapping = aes(x = z)) +
  geom_histogram(binwidth = 0.5) +
  coord_cartesian(ylim = c(0,50))
filterz <- diamonds %>%
  filter(z > 2 & z < 20)
ggplot(data = filterz, mapping = aes(x = z)) +
  geom_histogram(binwidth = 0.01)

# 2)
ggplot(data = smaller, mapping = aes(x = price)) +
  geom_histogram(binwidth = 1000)
ggplot(data = smaller, mapping = aes(x = price)) +
  geom_histogram(binwidth = 100)
ggplot(data = smaller, mapping = aes(x = price)) +
  geom_histogram(binwidth = 10)
ggplot(data = smaller, mapping = aes(x = price)) +
  geom_histogram(binwidth = 1)

ggplot(data = smaller, mapping = aes(x = price)) +
  geom_histogram(binwidth = 100) +
  coord_cartesian(ylim = c(0,200))

diamonds %>% 
  filter(price > 1200 & price < 1800) %>% 
ggplot(mapping = aes(x = price)) +
  geom_histogram(binwidth = 5) # no diamonds with price ~ 500 in the data set?

# 3)
diamonds %>% 
  filter(carat > 0.95 & carat < 1.05) %>% 
ggplot(mapping = aes(x = carat)) +
  geom_histogram(binwidth = 0.01)

# 4)
ggplot(data = smaller, mapping = aes(x = price)) +
  geom_histogram(binwidth = 100) +
  coord_cartesian(ylim = c(0,200)) # coord_cartesian keeps the data outside of limits!!!

ggplot(data = smaller, mapping = aes(x = price)) +
  geom_histogram(binwidth = 100) +
  ylim(c(0,200)) # ylim / xlim remove data outside of limits!!!
ggplot(data = smaller, mapping = aes(x = price)) +
  geom_histogram(binwidth = 1000) +
  xlim(c(5000,5500)) # bins outside of limits are removed


################################ Missing Values ########################################################

diamonds2 <- diamonds %>%
  filter(between(y, 3, 20)) # drop entire row with unusual value - not recommended, removes good data

diamonds2 <- diamonds %>%
  mutate(y = ifelse(y < 3 | y > 20, NA, y)) # replace unusual value with NA

ggplot(data = diamonds2, mapping = aes(x = x, y = y)) +
  geom_point() # ggplot gives a warning for missing values in teh data set (they are not plotted)
ggplot(data = diamonds2, mapping = aes(x = x, y = y)) +
  geom_point(na.rm = TRUE) # warning is suppressed

nycflights13::flights %>%
  mutate(
    cancelled = is.na(dep_time), # groups data in cancelled and noncancelled flights
    sched_hour = sched_dep_time %/% 100,
    sched_min = sched_dep_time %% 100,
    sched_dep_time = sched_hour + sched_min / 60 # calculates time in hours after midnight
  ) %>%
  ggplot(mapping = aes(sched_dep_time)) +
  geom_freqpoly(
    mapping = aes(color = cancelled), # comparison of cancelled and noncancelled flights
    binwidth = 1/4
  )
# Problem: there are many more noncancelled than cancelled flights - this problem is addressed in next section

## Exercises
# 1)
ggplot(data = nycflights13::flights, mapping = aes(x = dep_time)) +
  geom_histogram(binwidth = 1) # NAs are removed

ggplot(data = nycflights13::flights, mapping = aes(x = dep_time)) +
  geom_bar()

####################################### Covariation ########################################################

####################################### A Categorical and Continuous Variable ##############################

ggplot(data = diamonds, mapping = aes(x = price)) +
  geom_freqpoly(mapping = aes(color = cut), binwidth = 500) # Problem: hard to compare groups with different count

ggplot(diamonds) +
  geom_bar(mapping = aes(x = cut))

ggplot(
  data = diamonds,
  mapping = aes(x = price, y = ..density..) # this shows density on y-axis (area under curve is 1)
) +
  geom_freqpoly(mapping = aes(color = cut), binwidth = 500)

ggplot(data = mpg, mapping = aes(x = class, y = hwy)) +
  geom_boxplot() # boxplot to visualize distribution per class

ggplot(data = mpg) +
  geom_boxplot(
    mapping = aes(
      x = reorder(class, hwy, FUN = median), # reorders classes for plotting
      y = hwy
    )
  )

ggplot(data = mpg) +
  geom_boxplot(
    mapping = aes(
      x = reorder(class, hwy, FUN = median),
      y = hwy
    )
  ) +
  coord_flip() # flips plot

## Exercises
# 1)
nycflights13::flights %>%
  mutate(
    cancelled = is.na(dep_time), # groups data in cancelled and noncancelled flights
    sched_hour = sched_dep_time %/% 100,
    sched_min = sched_dep_time %% 100,
    sched_dep_time = sched_hour + sched_min / 60 # calculates time in hours after midnight
  ) %>%
  ggplot(mapping = aes(x = sched_dep_time, y = ..density..)) +
  geom_freqpoly(
    mapping = aes(color = cancelled), # comparison of cancelled and noncancelled flights
    binwidth = 1/4
  )

# 2)
ggplot(data = diamonds) +
  geom_point(mapping = aes(x = carat, y = price))
ggplot(data = diamonds) +
  geom_point(mapping = aes(x = depth, y = price))
ggplot(data = diamonds) +
  geom_boxplot(mapping = aes(x = reorder(clarity, price, FUN = median), y = price))
ggplot(data = diamonds) +
  geom_boxplot(mapping = aes(x = reorder(cut, price, FUN = median), y = price))

ggplot(data = diamonds) +
  geom_boxplot(mapping = aes(x = reorder(cut, carat, FUN = median), y = carat))
# Fair diamonds are bigger (more carat) on average - explains higher average price


# 3)
library(ggstance)
ggplot(data = diamonds) +
  ggstance::geom_boxploth(mapping = aes(x = carat, y = reorder(cut, carat, FUN = median)))
# makes horizontal boxplot

ggplot(data = diamonds) +  
  geom_boxplot(mapping = aes(x = reorder(cut, carat, FUN = median), y = carat)) +
  coord_flip()

# 4)
library(lvplot)
ggplot(data = diamonds) +  
  geom_lv(mapping = aes(x = reorder(cut, carat, FUN = median), y = carat)) 
# shows less points as outliers

# 5)
ggplot(
  data = diamonds,
  mapping = aes(x = price, y = ..density..) # this shows density on y-axis (area under curve is 1)
) +
  geom_freqpoly(mapping = aes(color = cut), binwidth = 500)

ggplot(data = diamonds, mapping = aes(x = cut, y = price)) +
  geom_violin()

ggplot(data = diamonds, mapping = aes(x = price)) +
  geom_histogram() +
  facet_grid(cut ~ ., scales = "free")

# 6)
library(ggbeeswarm)
# provides tools similar to geom_jitter

ggplot(data = mpg, mapping = aes(
  x = class,
  y = hwy)) +
  geom_quasirandom()

ggplot(data = mpg, mapping = aes(
  x = class,
  y = hwy)) +
  geom_quasirandom(width = 0.1)    
    

################################### Two Categorical Variables ############################################
require(tidyverse)

ggplot(data = diamonds) +
  geom_count(mapping = aes(x = cut, y = color)) # count observations in both categorical variables

diamonds %>%
  count(color, cut) # calculate counts

diamonds %>%
  count(color, cut) %>%
  ggplot(mapping = aes(x = color, y = cut)) +
  geom_tile(mapping = aes(fill = n))

# alternativels seriation (for reordering categories), d3heatmap and heatmaply packages are useful

## Exercises
# 1)
diamonds %>%
  count(cut, color, sort = TRUE) %>%
  ggplot(mapping = aes(x = cut, y = color)) +
  geom_tile(mapping = aes(fill = n))

# 2)
nycflights13::flights %>% 
  group_by(dest, month) %>% 
  summarize(delay = mean(dep_delay, na.rm = TRUE)) %>% 
  ggplot(mapping = aes(x = as.factor(month), y = dest)) +
  geom_tile(mapping = aes(fill = delay))


######################################## Two Continuous Variables #######################################

ggplot(data = diamonds) +
  geom_point(mapping = aes(x = carat, y = price)) # scatterplot to show covariation

ggplot(data = diamonds) +
  geom_point(
    mapping = aes(x = carat, y = price),
    alpha = 1 / 100 # use alpha to avoid overplotting
  )

smaller <- diamonds %>%
  filter(carat < 3)
ggplot(data = smaller) +
  geom_bin2d(mapping = aes(x = carat, y = price)) # uses rectangular 2D bins

ggplot(data = smaller) +
  geom_hex(mapping = aes(x = carat, y = price)) # uses hexagonal 2D bins

ggplot(data = smaller, mapping = aes(x = carat, y = price)) +
  geom_boxplot(mapping = aes(group = cut_width(carat, 0.1))) # binning of 1 variable (make it categorical)

ggplot(data = smaller, mapping = aes(x = carat, y = price)) +
  geom_boxplot(mapping = aes(group = cut_width(carat, 0.1)), varwidth = TRUE) # option to show number of points in bins

ggplot(data = smaller, mapping = aes(x = carat, y = price)) +
  geom_boxplot(mapping = aes(group = cut_number(carat, 20))) # shows ~same number of points in each bin

## Exercises
# 1)
ggplot(data = smaller, mapping = aes(price)) +
  geom_freqpoly(mapping = aes(color = cut_number(carat, 10))) # same number of data points per group
ggplot(data = smaller, mapping = aes(price)) +
  geom_freqpoly(mapping = aes(color = cut_width(carat, 0.2))) # different number of data points/group!!!
# For geom_freqpoly cut_number is better to avoid different number of data points in groups

# 2)
ggplot(data = smaller, mapping = aes(carat)) +
  geom_freqpoly(mapping = aes(color = cut_number(price, 10)))

# 4)
diamonds %>%
  mutate(carat_class = cut_number(carat, 10)) %>% 
  group_by(carat_class, cut) %>% 
  summarise(carat_class, cut, mean_price = mean(price, na.rm = TRUE)) %>% 
  ggplot(mapping = aes(x = carat_class, y = cut)) +
  geom_tile(mapping = aes(fill = mean_price))

# 5)
ggplot(data = diamonds) +
  geom_point(mapping = aes(x = x, y = y)) +
  coord_cartesian(xlim = c(4, 11), ylim = c(4, 11)) # outliers in the combination of 2 variables are visible


################################### Patterns and Models ########################################################

ggplot(data = faithful) +
  geom_point(mapping = aes(x = eruptions, y = waiting)) # longer wait times correlate with longer eruptions
# Patterns reveal covariation

library(modelr)
mod <- lm(log(price) ~ log(carat), data = diamonds)
diamonds2 <- diamonds %>%
  add_residuals(mod) %>%
  mutate(resid = exp(resid))
ggplot(data = diamonds2) +
  geom_point(mapping = aes(x = carat, y = resid))
# shows residuals of the model price ~ carat (= price once the effect of carat is removed)

ggplot(data = diamonds2) +
  geom_boxplot(mapping = aes(x = cut, y = resid))
# Now better cut shows also better price (after removal of strong carat - price relationship)
# More on modeling in Part IV


################################## Part III: Wrangle ##################################################

################################## Chapter 7: Tibbles with tibble #####################################

require(tidyverse)

as_tibble(iris) # conversion of data frame to tibble

tibble(
  x = 1:5,
  y = 1,
  z = x ^ 2 + y ) # manually creating tibble 
# tibble() never changes name or type of variables (e.g.strings to factors) or creates row names

tb <- tibble(
  `:)` = "smile", # nonsyntatic column names are allowed, but have to be within backticks
  ` ` = "space",
  `2000` = "number"
)
tb # backticks for these names are also required for other tidyverse packages

tribble( # transposed tibble
  ~x, ~y, ~z,
  #--|--|---- # this is just an optional comment line, good for readability
  "a", 2, 3.6,
  "b", 1, 8.5 )
# is customized for data entry in code: column headings are defined by formulas (i.e., they start with ~ ), and entries are separated by commas

tibble(
  a = lubridate::now() + runif(1e3) * 86400,
  b = lubridate::today() + runif(1e3) * 30,
  c = 1:1e3,
  d = runif(1e3),
  e = sample(letters, 1e3, replace = TRUE) ) # only first 10 rows are printed

nycflights13::flights %>%
  print(n = 10, width = Inf) # print() overwrites default printing of tibbles
# default printing of tibbles can be changed using options()

nycflights13::flights %>%
  View() # shows whole data set

df <- tibble(
  x = runif(5),
  y = rnorm(5)
)
# Extract by name
df$x
df[["x"]] # one pair of [] always returns again a tibble (same as e.g. dplyr::select())
# caution: with data.frames [] sometimes returns a data.frame and sometimes a vector!!!

# Extract by position
df[[1]]

df %>% .$x # use within pipe
df %>% .[["x"]]

class(as.data.frame(tb)) # conversion to data.frame (some older R functions don't work with tibbles)

## Exercises
# 2)
df <- data.frame(abc = 1, xyz = "a")
df$x # does partial matching!
df[, "xyz"] # returns a vector!
df[, c("abc", "xyz")] # return a data.frame!
tb <- as_tibble(df)
tb$x # no partial matching!
tb[, "xyz"] # always return a tibble
tb[, c("abc", "xyz")]

# 3)
var <- "mpg"
tb <- as_tibble(mtcars)
tb[[var]]

# 4)
annoying <- tibble(
  `1` = 1:10,
  `2` = `1` * 2 + rnorm(length(`1`))
)
annoying$`1`
ggplot(annoying, aes(`1`, `2`)) +
  geom_point()
annoying$`3` <- annoying$`2` / annoying$`1`
annoying
names(annoying) <- c("one", "two", "three")
annoying

# 5)
v <- c(1,2,3,4,5)
names(v) <- c("one", "two", "three", "four", "five")
v
tibble::enframe(v) # converts named vectors or lists to tibble

# 6)
package?tibble
# tibble.max_extra_cols controls number of column names printed in footer of tibble


##################################### Chapter 8: Data Import with readr #####################################

require(tidyverse)

heights <- read_csv("heights.csv")
read_csv("a,b,c
1,2,3
4,5,6")

read_csv("The first line of metadata
The second line of metadata
x,y,z
1,2,3", skip = 2) # skips first 2 lines

read_csv("# A comment I want to skip
x,y,z
1,2,3", comment = "#") # skips all lines with "#"

read_csv("1,2,3\n4,5,6", col_names = FALSE) # no column names
# "\n" is a convenient shortcut for adding a new line

read_csv("1,2,3\n4,5,6", col_names = c("x", "y", "z")) # passing col names as vector

read_csv("a,b,c\n1,2,.", na = ".") # define missing values

## Exercises
# 2)
?read_csv

# 3)
?read_fwf

# 4)
read_csv("x,y\n1,'a,b'", quote = "\'")

# 5)
read_csv("a,b\n1,2,3\n4,5,6") # first row has only 2 entries
read_csv("a,b,c\n1,2\n1,2,3,4") # second row has only 2, third has 4 entries
read_csv("a,b\n\"1") # second row has only 1 entry
read_csv("a,b\n1,2\na,b")
read_csv("a;b\n1;3") # ";" as separator
# Number of entries in first row (column names) defines the number of columns in a tibble


####################################### Parsing a Vector ####################################################

# parse_*() functions take a character vector and return a more specialized vector like a logical, integer, or date
str(parse_logical(c("TRUE", "FALSE", "NA")))
str(parse_integer(c("1", "2", "3")))
str(parse_date(c("2010-01-01", "1979-10-14")))
# these are used by readr to parse columns

parse_integer(c("1", "231", ".", "456"), na = ".") # define NAs

x <- parse_integer(c("123", "345", "abc", "123.45")) #  warning if parsing fails
x
problems(x) #  returns tibble with all parsing failures, if there are more

### Parsing numbers
parse_double("1.23")
parse_double("1,23", locale = locale(decimal_mark = ",")) # setting decimal separator

parse_number("$100") # non-numeric characters before and after number are ignored
parse_number("20%")
parse_number("It cost $123.45")

parse_number("$123,456,789")
parse_number(
  "123.456.789",
  locale = locale(grouping_mark = ".") # grouping mark can be defined and is then ignored during parsing
)
parse_number(
  "123'456'789",
  locale = locale(grouping_mark = "'")
)

### Parsing strings
charToRaw("Hadley") # shows underlying representation of the string in R (hexadecimal)
# Mapping from hexadecimal number to string is called encoding - in this case ASCII
# readr uses UTF-8 encoding everywhere - it assumes data are UTF-8 encoded

x1 <- "El Ni\xf1o was particularly bad this year"
x2 <- "\x82\xb1\x82\xf1\x82\xc9\x82\xbf\x82\xcd"
parse_character(x1, locale = locale(encoding = "Latin1")) # specify other encoding manually for non-UTF-8 input
parse_character(x2, locale = locale(encoding = "Shift-JIS"))

guess_encoding(charToRaw(x1)) # used to guess encoding from data (if it is not known), input can also be a file
guess_encoding(charToRaw(x2))

### Factors
fruit <- c("apple", "banana")
parse_factor(c("apple", "banana", "bananana"), levels = fruit) # warning for value not in levels

### Dates, Date-Times, and Times
parse_datetime("2010-10-01T2010") # expects ISO8601 format (year, month, day, hour, minute, second)
parse_datetime("20101010") # time is set to midnight if missing

parse_date("2010-10-01") # expects four-digit year, a - or / , the month, a - or / , then the day

library(hms)
parse_time("01:10 am") # expects the hour, : , minutes, optionally : and seconds, and an optional a.m./p.m. specifier
parse_time("20:10:01")
# Base R doesn’t have a great built-in class for time data

parse_date("01/02/15", "%m/%d/%y") # supply own format
parse_date("01/02/15", "%d/%m/%y")
parse_date("01/02/15", "%y/%m/%d")
parse_date("1 janvier 2015", "%d %B %Y", locale = locale("fr")) # set language with locale

## Exercise
# 1)
?locale

# 2)
parse_number(
  "123,456,789,00",
  locale = locale(decimal_mark = "," ,grouping_mark = ",") ) # must be different
parse_number(
  "123.456,33",
  locale = locale(decimal_mark = ",") ) # grouping_mark changes to "."
parse_number(
  "123.456,33",
  locale = locale(grouping_mark = ".") ) # decimal_mark changes to ","

# 3)
?locale
parse_datetime("0102152201", "%d%m%y%H%M", locale = locale(date_format = "%AT", time_format = "%AT") )
# 4)
my_locale <- locale("de")
# 5)
?read_csv
# 7)
d1 <-   "January 1, 2010"
parse_date(d1, "%B %d, %Y")
d2 <- "2015-Mar-07"
parse_date(d2, "%Y-%b-%d")
d3 <- "06-Jun-2017"
parse_date(d3, "%d-%b-%Y")
d4 <- c("August 19 (2015)", "July 1 (2015)")
parse_date(d4, "%B %d (%Y)")
d5 <- "12/30/14" # Dec 30, 2014
parse_date(d5, "%m/%d/%y")
t1 <- "1705"
parse_time(t1, "%H%M")
t2 <- "11:15:10.12 PM"
parse_time(t2, "%I:%M:%OS %p")


########################################## Parsing a File ###############################################

require(tidyverse)

guess_parser("2010-10-01") # is used by readr to guess the type based on top 1000 rows
guess_parser("15:01")
guess_parser(c("TRUE", "FALSE"))
guess_parser(c("1", "5", "9"))
guess_parser(c("12,352,561"))
str(parse_guess("2010-10-10"))

challenge <- read_csv(readr_example("challenge.csv"))
# example of a challenging csv file to parse (included in readr)
# problem if first 1000 rows are not representative (e.g. only NAs or int and rest is doubles)

problems(challenge) # shows all parsing problems
# fixing problems: start by defining types manually as detected by the automatic parsing
challenge <- read_csv(
  readr_example("challenge.csv"),
  col_types = cols(
    x = col_integer(), # actually the automatic parser correctly converted it to duoble already
    y = col_character()
  )
)
# Modify the types to be correct
challenge <- read_csv(
  readr_example("challenge.csv"),
  col_types = cols(
    x = col_double(),
    y = col_character()
  )
)

tail(challenge) # dates are in y column
challenge <- read_csv(
  readr_example("challenge.csv"),
  col_types = cols(
    x = col_double(),
    y = col_date() # correct manually
  )
)
tail(challenge)
# every parse_* function has a corresponding col_* function to tell readr manually, which type to use

challenge2 <- read_csv(
  readr_example("challenge.csv"),
  guess_max = 1001 # using more rows to guess can also help
)
challenge2

# Reading in data as character vectors can help to diagnose the problem
challenge2 <- read_csv(readr_example("challenge.csv"),
                       col_types = cols(.default = col_character())
)

df <- tribble(
  ~x, ~y,
  "1", "1.21",
  "2", "2.32",
  "3", "4.56"
)
df
type_convert(df) # applies parsing heuristic to character columns

### Writing files
write_csv(challenge, "challenge.csv")
challenge
write_csv(challenge, "challenge-2.csv")
read_csv("challenge-2.csv") # type information is lost when saving as csv!

write_tsv(challenge, "challenge-3.csv") # for tab-separation
write_excel_csv(challenge, "challenge-4.csv") # for csv files to be imported into Excel (includes info about UTF-8)

write_rds(challenge, "challenge.rds") # saves data in binary RDS format (no info is lost)
read_rds("challenge.rds")

library(feather)
write_feather(challenge, "challenge.feather")
read_feather("challenge.feather")
# saves data in a binary file format that can be shared across programing languages

# Other useful packages for data import:
# haven reads SPSS, Stata, and SAS files
# readxl reads Excel files (both .xls and .xlsx)
# DBI, along with a database-specific backend (e.g., RMySQL, RSQLite, RPostgreSQL, etc.) allows you to run SQL queries against a database and return a data frame
# jsonlite for JSON files
# xml2 for XML files
# For other file types try R data import/export manual and rio package


############################### Chapter 9: Tidy Data with tidyr #############################################

require(tidyverse)

# Same data in different formats
table1
table2
table3
table4a
table4b
# only table1 is tidy: each variable in own column, each observation in own row, each vaue in own cell

# tidy data are easier to work with: Compute rate per 10,000
table1 %>%
  mutate(rate = cases / population * 10000)

# Compute cases per year
table1 %>%
  count(year, wt = cases)

# Visualize changes over time
ggplot(table1, aes(year, cases)) +
  geom_line(aes(group = country), color = "grey50") +
  geom_point(aes(color = country))

## Exercises
# 2)
cases <- table2 %>% 
  filter(type == "cases") %>% 
  select(country, year, count)
cases['population'] <- table2 %>% 
  filter(type == "population") %>% 
  select(count)
cases['rate'] <- cases$count / cases$population * 10000
cases

table4a
table4b
table4 <- table4a %>%
  gather(`1999`, `2000`, key = "year", value = "cases")
table4['population'] <- table4b %>%
  gather(`1999`, `2000`, key = "year", value = "population") %>% 
  select(population)
table4['rate'] <- table4$cases / table4$population * 10000
table4

# 3)
table2
spread(table2, key = type, value = count) %>% 
  ggplot(aes(year, cases)) +
  geom_line(aes(group = country), color = "grey50") +
  geom_point(aes(color = country))


######################################### Spreading and Gathering ##########################################

table4a # column names are values of variable year and each row is two observations
table4a %>%
  gather(`1999`, `2000`, key = "year", value = "cases")
# gather requires 1) the set of columns that represent values of a variable,
            # 2) the name of the variable whose values form the column names (called key)
            # 3) The name of the variable whose values are spread over the cells (called value)
            # column selection uses the same pattern as for dplyr::select()

table4b %>%
  gather(`1999`, `2000`, key = "year", value = "population")
tidy4a <- table4a %>%
  gather(`1999`, `2000`, key = "year", value = "cases")
tidy4b <- table4b %>%
  gather(`1999`, `2000`, key = "year", value = "population")
left_join(tidy4a, tidy4b) # more on joining in chapter 10

table2 # observations are scattered across multiple rows
spread(table2, key = type, value = count)
# spread requires 1) column that contains variable names (key)
                # 2) column that contains values from multiple variables (value)

## Exercises
# 1)
stocks <- tibble(
  year = c(2015, 2015, 2016, 2016),
  half = c( 1, 2, 1, 2),
  return = c(1.88, 0.59, 0.92, 0.17)
)
stocks
stocks %>%
  spread(year, return) %>%
  gather("year", "return", `2015`:`2016`)
# new columns are added at the end - column order changes
# type of year variable changes - gather produces by default character type vor column names 

stocks
stocks %>%
  spread(year, return) %>%
  gather("year", "return", `2015`:`2016`, convert = TRUE) # convert runs type conversion on ey column

# 2)
table4a %>%
  gather(1999, 2000, key = "year", value = "cases")
# Fails because of non-syntactical names - requires backticks

# 3)
people <- tribble(
  ~name,             ~key,    ~value,
  #-----------------|---------|------
  "Phillip Woods",   "age",    45,
  "Phillip Woods",   "height", 186,
  "Phillip Woods",   "age",    50,
  "Jessica Cordero", "age",    37,
  "Jessica Cordero", "height", 156
)
people %>% 
  spread(key, value)
# spreading fails here due to lack of unique combination of keys
people %>% 
  mutate(ID = c(1,1,2,3,3)) %>% # problem solved by adding unique ID
  spread(key, value)

# 4)
preg <- tribble(
  ~pregnant, ~male, ~female,
  "yes",     NA,    10,
  "no",      20,    12
)
preg
preg %>% 
  gather(male, female, key = "sex", value = "value")


################################ Separating and Pull #################################################

table3
table3 %>% 
  separate(rate, into = c("cases", "population")) # splits column at any non-alphanumeric character by default
table3 %>%
  separate(rate, into = c("cases", "population"), sep = "/") # separator specified
# by default no type conversion is done
table3 %>%
  separate(
    rate,
    into = c("cases", "population"),
    convert = TRUE # with type conversion of new columns
  )
table3 %>%
  separate(year, into = c("century", "year"), sep = 2) # sep = int splits by position

table5
table5 %>%
  unite(new, century, year) # opposite of separate; default places underscore as separator

table5 %>%
  unite(new, century, year, sep = "")

## Exercises
# 1)
tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>%
  separate(x, c("one", "two", "three"))
tibble(x = c("a,b,c", "d,e,f,g", "h,i,j")) %>%
  separate(x, c("one", "two", "three"), extra = "merge") # extra defines what happens to additional values

tibble(x = c("a,b,c", "d,e", "f,g,i")) %>%
  separate(x, c("one", "two", "three"))
tibble(x = c("a,b,c", "d,e", "f,g,i")) %>%
  separate(x, c("one", "two", "three"), fill = "left") # fill defines what happens if there are not enough values

# 2)
tibble(x = c("a,b,c", "d,e,f", "h,i,j")) %>%
  separate(x, c("one", "two", "three"), remove = FALSE) # keeps input column

# 3)
?tidyr::extract # can extract group using regex and puts then into new columns
?separate # always splits column (also by regex)


##################################### Missing Values ########################################################

stocks <- tibble(
  year   = c(2015, 2015, 2015, 2015, 2016, 2016, 2016),
  qtr    = c(1, 2, 3, 4, 2, 3, 4),
  return = c(1.88, 0.59, 0.35, NA, 0.92, 0.17, 2.66)
) # 2015 q 4 is explicitly missing and 2016 q1 is implicitly missing
stocks
stocks %>%
  spread(year, return) # makes all missing values explicit
stocks %>%
  spread(year, return) %>%
  gather(year, return, `2015`:`2016`, na.rm = TRUE) # na.rm=TRUE turns explicit missing values implicit

stocks %>%
  complete(year, qtr) # also shows all missing values explicitly

treatment <- tribble(
  ~ person,            ~ treatment,   ~response,
  "Derrick Whitmore",  1,             7,
  NA,                  2,             10,
  NA,                  3,             9,
  "Katherine Burke",   1,             4
)
treatment
treatment %>%
  fill(person) # carries forward last observation to fill NAs

## Exercises
# 1)
?spread
?complete
# Both have fill arguments to fill missing values, spread can only fill on value, complete also a vector

# 2)
treatment %>%
  fill(person, .direction = "up") # .direction defines filling direction


##################################### Case Study #########################################################

# WHO tuberculosis data set
who
# data are messy - convert to tidy format
who1 <- who %>%
  gather(
    new_sp_m014:newrel_f65, key = "key",
    value = "cases",
    na.rm = TRUE
  )
who1
who1 %>%
  count(key)
# "new" means new cases (all in this data set), next is type of TB, then sex of patient, finally age group

who2 <- who1 %>%
  mutate(key = stringr::str_replace(key, "newrel", "new_rel")) # corrects the type "rel" - _ is missing
who2

who3 <- who2 %>%
  separate(key, c("new", "type", "sexage"), sep = "_") # split at "_"
who3

who3 %>%
  count(new) # all are new cases - column can be dropped
who4 <- who3 %>%
  select(-new, -iso2, -iso3) # drop unnecessary and redundant columns

who5 <- who4 %>%
  separate(sexage, c("sex", "age"), sep = 1)
who5

# all steps in one pipe:
who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>%
  mutate(
    code = stringr::str_replace(code, "newrel", "new_rel")
  ) %>%
  separate(code, c("new", "var", "sexage")) %>%
  select(-new, -iso2, -iso3) %>%
  separate(sexage, c("sex", "age"), sep = 1)


## Exercise
# 3)
who
length(unique(who$country))
length(unique(who$iso2))
length(unique(who$iso3))

# 4)
who_tidy <- who %>%
  gather(code, value, new_sp_m014:newrel_f65, na.rm = TRUE) %>%
  mutate(
    code = stringr::str_replace(code, "newrel", "new_rel")
  ) %>%
  separate(code, c("new", "var", "sexage")) %>%
  select(-new, -iso2, -iso3) %>%
  separate(sexage, c("sex", "age"), sep = 1)
who_tidy
who_tidy %>% 
  group_by(country, year, sex) %>% 
  count(wt = value) %>% 
  ggplot(aes(x = year, y = n)) +
    geom_point(aes(pch = sex, color = country), show.legend = FALSE)

who_tidy %>% 
  group_by(country, year, sex) %>% 
  count(wt = value) %>% 
  filter(year > 1993) %>% 
  ggplot(aes(x = as.factor(year), y = n)) +
    geom_boxplot(aes(color = as.factor(sex)))


################################### Chapter 10: Relational Data with dplyr #################################

library(tidyverse)
library(nycflights13)

airlines
airports
planes
weather
planes %>%
  count(tailnum) %>%
  filter(n > 1) # check if primary keys are unique
weather %>%
  count(year, month, day, hour, origin) %>%
  filter(n > 1) # shows 3 entries not unique? in the book there are none

flights %>%
  count(year, month, day, flight) %>%
  filter(n > 1) # flights has no unique primary key
flights %>%
  count(year, month, day, tailnum) %>%
  filter(n > 1)

## Exercises
# 1)
flights %>% 
  mutate(key = row_number(flights$month))

# 2)
# a)
Lahman::Batting # keys: playerID + yearID + stint + teamID
# e)
ggplot2::diamonds # no key


################################ Mutating Joins ###########################################################

flights2 <- flights %>%
  select(year:day, hour, origin, dest, tailnum, carrier)
flights2

flights2 %>%
  select(-origin, -dest) %>%
  left_join(airlines, by = "carrier")

flights2 %>%
  select(-origin, -dest) %>%
  mutate(name = airlines$name[match(carrier, airlines$carrier)]) # alternative using base R subsetting


x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  3, "x3"
)
y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2",
  4, "y3"
)

x %>%
  inner_join(y, by = "key") # inner join

x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  2, "x3",
  1, "x4"
)
y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2"
)
left_join(x, y, by = "key") # left join

x <- tribble(
  ~key, ~val_x,
  1, "x1",
  2, "x2",
  2, "x3",
  3, "x4"
)
y <- tribble(
  ~key, ~val_y,
  1, "y1",
  2, "y2",
  2, "y3",
  3, "y4"
)
left_join(x, y, by = "key") # duplicated keys in both tables - Cartesian product obtained (all combinations)

flights2 %>%
  left_join(weather) # by default all matching columns are used as keys

flights2 %>%
  left_join(planes, by = "tailnum") # key specified

flights2 %>%
  left_join(airports, c("dest" = "faa")) # specify matching columns in both tables
flights2 %>%
  left_join(airports, c("origin" = "faa"))

## Exercsises
# 1)
flights %>% 
  group_by(dest) %>% 
  summarise(avg_delay = mean(dep_delay, na.rm = TRUE)) %>% 
  left_join(airports, c("dest" = "faa")) %>% 
  ggplot(aes(lon, lat)) +
    borders("state") +
    geom_point(aes(color = avg_delay)) +
    coord_quickmap()

airports %>%
  semi_join(flights, c("faa" = "dest")) %>%
  ggplot(aes(lon, lat)) +
    borders("state") +
    geom_point() +
    coord_quickmap()

# 2)
flights2 %>% 
  left_join(airports, c("origin" = "faa")) %>% 
  left_join(airports, c("dest" = "faa"))

# 3)
flights %>% 
  group_by(tailnum) %>% 
  summarise(avg_delay = mean(dep_delay, na.rm = TRUE)) %>% 
  left_join(planes, by = "tailnum") %>% 
  ggplot(aes(x = year, y = avg_delay)) +
    geom_point() # no clear relationship between age and delay

# 4)
flights %>% 
  group_by(year, month, day, hour, origin) %>% 
  summarise(avg_delay = mean(dep_delay, na.rm = TRUE)) %>% 
  left_join(weather, by = c("year", "month","day","hour","origin")) %>% 
  ggplot(aes(x = as.factor(visib), y = avg_delay)) +
    geom_boxplot()

# 5)
flights %>% 
  filter(month == 6 & day == 13) %>% 
  group_by(year, month, day, hour, origin) %>% 
  summarise(avg_delay = mean(dep_delay, na.rm = TRUE)) %>% 
  left_join(weather, by = c("year", "month","day","hour","origin")) %>% 
  ggplot(aes(x = hour, y = avg_delay)) +
    geom_point()


################################## Filtering Joins ########################################################

require(tidyverse)
require(nycflights13)

# semi_join(x, y) keeps all observations in x that have a match in y
# anti_join(x, y) drops all observations in x that have a match in y

top_dest <- flights %>%
  count(dest, sort = TRUE) %>%
  head(10)
top_dest

# Find all flights that went to one of those destinations
flights %>%
  filter(dest %in% top_dest$dest) # this approach is difficult for multiple variables

flights %>%
  semi_join(top_dest) # alternative with semi_join()

flights %>%
  anti_join(planes, by = "tailnum") %>% # flights without a match in planes
  count(tailnum, sort = TRUE)

## Exercises
# 1)
flights %>% 
  filter(is.na(tailnum)) %>% 
  summary() # all flights w/o tailnum did not depart

flights %>%
  anti_join(planes, by = "tailnum") %>% # flights without a match in planes
  mutate(carrier = as.factor(carrier)) %>% # tailnum missing in planes are from 2 carriers: AA & MQ
  summary()

# 2)
top_planes <- flights %>%
  count(tailnum, sort = TRUE) %>%
  filter(n >= 100 & !is.na(tailnum))
top_planes
flights %>%
  semi_join(top_planes)

# 3)
fueleconomy::vehicles
fueleconomy::common

fueleconomy::vehicles %>% 
  semi_join(fueleconomy::common)

# 4)
worst_hours <- flights %>% 
  filter(!is.na(dep_delay)) %>% 
  group_by(time_hour) %>% 
  summarise(mean_delay = mean(dep_delay)) %>% 
  arrange(desc(mean_delay)) %>% 
  head(n = 48)
  #count(time_hour, wt = dep_delay, sort = TRUE)
worst_hours
weather %>% 
  semi_join(worst_hours) %>% 
  summary()
weather %>% 
  summary() # lower average visibility and higher wind speed in worst hours

# 5)
airports
anti_join(flights, airports, by = c("dest" = "faa")) # flights with dest not in airports
anti_join(airports, flights, by = c("faa" = "dest")) # airports not present in flights

# 6)
planes
airlines
flights %>% 
  select(tailnum, carrier) %>% 
  unique() %>% 
  dim() # 4067 plane - airline combinations
flights %>% 
  select(tailnum, carrier) %>% 
  unique() %>% 
  select(tailnum) %>% 
  unique() %>% 
  dim() # only 4044 unique tailnums -> some planes were used by more than one airline
dupl_planes <- flights %>% 
  select(tailnum, carrier) %>% 
  unique() %>% 
  count(tailnum, sort = TRUE) %>% 
  filter(!is.na(tailnum) & n > 1) # 17 planes were use by 2 different airlines
dupl_planes

flights %>% 
  semi_join(dupl_planes) %>% 
  select(tailnum, carrier) %>% 
  unique() %>% 
  arrange(tailnum) %>% 
  select(carrier) %>% 
  unique()


####################################### Join Problems ###################################################

# To avoid join problems with own data:
# 1) Start by identifying the variables that form the primary key in each table - 
#   not only by looking for unique combinations of variables, but also based on understanding of the data
airports %>% count(alt, lon) %>% filter(n > 1)
# alt and lon give a unique combination for each airport, but are no good identifiers in general

# 2) Check that none of the variables in the primary key are missing

# 3) Check that your foreign keys match primary keys in another table (e.g. with anti_join())


########################################### Set Operations ################################################

# Set operations work with complete rows, comparing the values of each variable

df1 <- tribble(
  ~x, ~y,
  1, 1,
  2, 1
)
df2 <- tribble(
  ~x, ~y,
  1, 1,
  1, 2
)

intersect(df1, df2) # Return only observations in both df1 and df2

union(df1, df2) # Return unique observations in df1 and df2

setdiff(df1, df2) # Return observations in df1 , but not in df2
setdiff(df2, df1) # Return observations in df2 , but not in df1


############################# Chapter 11: Strings with stringr ###########################################

require(tidyverse)
library(stringr)

string1 <- "This is a string"
string2 <- 'To put a "quote" inside a string, use single quotes' # singe and double quotes are exchangeble in R

double_quote <- "\"" # escaping " inside a string or use '"'
single_quote <- '\'' # or "'"

x <- c("\"", "\\")
x # escape characters are also printed!
writeLines(x) # shows only the raw string

?'"'    # or \"'" shows help on strings with all special characters e.g. /n

x <- "\u00b5" # for writing non-English characters that works on all platforms 
x

c("one", "two", "three") # character vector

str_length(c("a", "R for data science", NA)) # shows # of characters in string
# all stringr functions start with str_


########################################## Combining Strings ################################################

str_c("x", "y") # combining strings
str_c("x", "y", "z")
str_c("x", "y", sep = ", ") # with separator

x <- c("abc", NA)
str_c("|-", x, "-|") # NAs are not treated as strings
str_c("|-", str_replace_na(x), "-|") # includes NAs as "NA"

str_c("prefix-", c("a", "b", "c"), "-suffix") # str_c is vectorized (recycles shorter vectors)

name <- "Hadley"
time_of_day <- "morning"
birthday <- FALSE

str_c(
  "Good ", time_of_day, " ", name,
  if (birthday) " and HAPPY BIRTHDAY", # objects of length 0 are silently dropped, useful with if
  "."
)

str_c(c("x", "y", "z"), collapse = ", ") # collapsing vector into single string


######################################### Subsetting Strings #################################################

x <- c("Apple", "Banana", "Pear")
str_sub(x, 1, 3) # extract part of string
str_sub(x, -3, -1) # negative numbers count backwards from end
str_sub("a", 1, 5) # does not fail if string is too short

str_sub(x, 1, 1) <- str_to_lower(str_sub(x, 1, 1)) # can be used in assignments
x


##################################### Locales #############################################################

# Turkish has two i's: with and without a dot, and it
# has a different rule for capitalizing them:
str_to_upper(c("i", "ı"))

str_to_upper(c("i", "ı"), locale = "tr") # setting locales

x <- c("apple", "eggplant", "banana")
str_sort(x, locale = "en") # sorting strings with English locales
str_sort(x, locale = "haw") # Hawaiian


## Exercises
# 1) str_c() is equivalent to paste0 (no separator), paste includes " " as separator

# 3) 
x <- "abcde"
str_length(x)
str_sub(x, str_length(x)/2 + 1, str_length(x)/2 + 1) # str_sub rounds down floats
x <- "abcdef"
str_length(x)
str_sub(x, str_length(x)/2, str_length(x)/2 + 1)

# 4)
?str_wrap # formats number of words in lines

# 5)
?str_trim # removes whitespace from start and end of strings

# 6)
x <- c("a", "b", "c")
my_fun <- function(s) {
  l <- length(s)
  if (l >= 3) {
    sub <- s[1:l-1]
    out <- str_c(sub, collapse = ", ")
    out <- str_c(out, s[l], sep = ", and ")
  } else if (l == 2) {
    out <- str_c(s, collapse = " and ")
  } else {
    out <- s
  }
  return(out)
}
my_fun(x)


############################### Matching Patterns with Regular Expressions #################################

require(tidyverse)
require(stringr)

x <- c("apple", "banana", "pear")
str_view(x, "an") # shows where the regexp is matching
str_view(x, ".a.") # . is any character except new line

dot <- "\\." 
# escaping is done with \
# Two \ are required because \ is also escape symbol in regular strings and regexps are provided as strings!!!
writeLines(dot) # shows the regular expression
str_view(c("abc", "a.c", "bef"), "a\\.c")

x <- "a\\b" # escaping the \ within a normal string to create "a\b"
writeLines(x)
str_view(x, "\\\\")
# Four \ are required to match one \ in a string:
# 1 \ escapes the literal \ in the regexp and each of the 2 \ has to be escaped in the string containing the regexp


## Exercises:
# 2)
x <- "\"\'\\"
writeLines(x)
str_view(x, "\"\'\\\\")

# 3)
re <- "\\..\\..\\.."
writeLines(re)
x <- ".a.b.c"
str_view(x, re)


######################################### Anchors #########################################################

# ^ to match the start of the string
# $ to match the end of the string

x <- c("apple", "banana", "pear")
str_view(x, "^a")
str_view(x, "a$")
x <- c("apple pie", "apple", "apple cake")
str_view(x, "apple")
str_view(x, "^apple$")
# \b is used to match word boundaries in R

## Exercises
# 1)
x <- "$^$"
writeLines(x)
str_view(x, "^\\$\\^\\$$") # first ^and last $ are optional here

# 2)
x <- stringr::words
# a)
str_view(x, "^y", match = TRUE)
# b)
str_view(x, "x$", match = TRUE)
# c)
str_view(x, "^...$", match = TRUE)
# d)
str_view(x, "^.......", match = TRUE)


################################### Character Classes and Alternatives ########################################

# \d matches any digit (\ has to be escaped in the string containing the regexp!)
# \s matches any whitespace (e.g., space, tab, newline)
# [abc] matches a, b, or c
# [^abc] matches anything except a, b, or c

str_view(c("grey", "gray"), "gr(e|a)y") # | means OR


## Exercises:
# 1)
x <- stringr::words
# a)
str_view(x, "^[aeiou]", match = TRUE)
# b)
str_view(x, "^[^aeiou]+$", match = TRUE)
# c)
str_view(x, "[^e]ed$", match = TRUE)
# d)
str_view(x, "(ing)|(ize)$", match = TRUE)

# 2)
str_view(x, "cei", match = TRUE)
str_view(x, "cie", match = TRUE)
str_view(x, "[^c]ei", match = TRUE)
str_view(x, "[^c]ie", match = TRUE)

# 3)
str_view(x, "q[^u]", match = TRUE)

# 4)
str_view(x, "recogni[sz]e", match = TRUE)

# 5)
x <- "+436641122345"
y <- "034741234"
re <- "((\\+43)|(0043)|(0))\\d{3,4}\\d+"
str_view(x, re)
str_view(y, re)


########################################### Repetition ######################################################

# ? : 0 or 1 matches
# + : 1 or more
# * : 0 or more

x <- "1888 is the longest year in Roman numerals: MDCCCLXXXVIII"
str_view(x, "CC?")
str_view(x, "CC+")
str_view(x, 'C[LX]+')

# {n} : exactly n matches
# {n,} : n or more matches
# {,m} : at most m matches
# {n,m} : between n and m matches

str_view(x, "C{2}")
str_view(x, "C{2,}")
str_view(x, "C{2,3}")
# regexps are greedy by default (returning longest possible match)

str_view(x, 'C{2,3}?') # ? makes it lazy - returns shortest possible match
str_view(x, 'C[LX]+?')

## Exercises:
# 3)
x <- stringr::words
# a)
re <- "^[^aeiou]{3}"
str_view(x, re, match = TRUE)
# b)
re <- "[aeiou]{3,}"
str_view(x, re, match = TRUE)
# c)
re <- "([aeiou][^aeiou]){2,}"
str_view(x, re, match = TRUE)


##################################### Grouping and Backreferences ##########################################

str_view(fruit, "(..)\\1", match = TRUE) # matches whatever it finds repeated 1 time

## Exercises:
# a)
x <- "aaaaa"
str_view(x, "(.)\\1\\1", match = TRUE) # group repeated 2 times (3 in total)
# b)
x <- "ababba"
str_view(x, "(.)(.)\\2\\1", match = TRUE)
# c)
str_view(x, "(..)\\1", match = TRUE)
# d)
x <- "abacad"
str_view(x, "(.).\\1.\\1", match = TRUE)
# e)
x <- "abcdefcbaghi"
str_view(x, "(.)(.)(.).*\\3\\2\\1", match = TRUE)

# 2)
# a)
re <- "^(.).*\\1$"
str_view(words, re, match = TRUE)
# b)
re <- "(.)(.).*\\1\\2"
str_view(words, re, match = TRUE)
# c)
re <- "(.).*\\1.*\\1"
str_view(words, re, match = TRUE)


######################################### Detect Matches #################################################

x <- c("apple", "banana", "pear")
str_detect(x, "e")
# How many common words start with t?
sum(str_detect(words, "^t"))
# What proportion of common words end with a vowel?
mean(str_detect(words, "[aeiou]$"))

# Break down complex problems into smaller pieces
# Find all words containing at least one vowel, and negate
no_vowels_1 <- !str_detect(words, "[aeiou]")
# Find all words consisting only of consonants (non-vowels)
no_vowels_2 <- str_detect(words, "^[^aeiou]+$")
identical(no_vowels_1, no_vowels_2)

words[str_detect(words, "x$")]
str_subset(words, "x$") # wrapper for subsetting

df <- tibble(
  word = words,
  i = seq_along(word)
)
df %>%
  filter(str_detect(words, "x$")) # in a data frame setting

x <- c("apple", "banana", "pear")
str_count(x, "a")

# On average, how many vowels per word?
mean(str_count(words, "[aeiou]"))

df %>%
  mutate(
    vowels = str_count(word, "[aeiou]"),
    consonants = str_count(word, "[^aeiou]")
  )

str_count("abababa", "aba") # regexps don't count overlapping matching!
str_view_all("abababa", "aba")


## Exercises:
# 1)
# a)
str_detect(words, "(^x)|(x$)") %>% sum()
(str_detect(words, "^x") | str_detect(words, "x$")) %>% sum()
# b)
str_detect(words, "(^[aeiou]).*([^aeiou]$)") %>% sum()
(str_detect(words, "^[aeiou]") & !str_detect(words, "[aeiou]$")) %>% sum()
# c)
( str_detect(words, "a") & str_detect(words, "e") & str_detect(words, "i") & str_detect(words, "o") &
  str_detect(words, "u") ) %>% sum()
# d)
words[str_count(words, "[aeiou]") %>% which.max()]

words[(str_count(words, "[aeiou]") / str_length(words)) 
      %>% which.max()]


###################################### Extract Matches ######################################################

length(sentences)
head(sentences)
# we want to find all sentences that contain a color
colors <- c(
  "red", "orange", "yellow", "green", "blue", "purple"
)
color_match <- str_c(colors, collapse = "|")
color_match
has_color <- str_subset(sentences, color_match)
matches <- str_extract(has_color, color_match) # extracts only first match!
head(matches)
more <- sentences[str_count(sentences, color_match) > 1]
str_view_all(more, color_match)
str_extract(more, color_match)
str_extract_all(more, color_match) # returns all matches as lists
str_extract_all(more, color_match, simplify = TRUE) # returns a matrix

x <- c("a", "a b", "a b c")
str_extract_all(x, "[a-z]", simplify = TRUE) # empty strings for lower number of matches


## Exercises:
# 1)
x <- c("flickered", "this is blue and red.")
color_match <- str_c(colors, collapse = "|")
color_match
color_match <- str_c("\\b(", color_match, ")\\b")
writeLines(color_match)
str_view_all(x, color_match)

# 2)
# a)
str_extract(sentences, "^.+?\\b")
# b)
sub <- str_subset(sentences, "\\w*ing\\b")
str_extract_all(sub, "\\w*ing\\b")
# c)
sub <- str_subset(sentences, "\\w+s\\b")
str_extract_all(sub, "\\w+s\\b") # not possible to specifically detect plurals?


###################################### Grouped Matches #####################################################

# extract nouns
noun <- "(a|the) ([^ ]+)" # definition of noun used here
has_noun <- sentences %>%
  str_subset(noun) %>%
  head(10)
has_noun %>%
  str_extract(noun)
has_noun %>%
  str_match(noun) # return only match for each group too (as matrix)

# for tibbles use tidyr::extract
tibble(sentence = sentences) %>%
  tidyr::extract(
    sentence, c("article", "noun"), "(a|the) ([^ ]+)",
    remove = FALSE
  )


## Exercises:
# 1)
nums <- c(
  "one", "two", "three", "four", "five", "six","seven","eight","nine","ten",
  "eleven","twelve","thirteen","fifteen","twenty","thirty","fifty"
)
nums_match <- str_c(nums, collapse = "|")
nums_match
nums_match <- str_c("((", nums_match, ")((teen)|(ty))*) ([^ ]+)")
nums_match
has_num <- sentences %>%
  str_subset(nums_match)
res <- has_num %>%
  str_match(nums_match)
res[,c(1,2,7)]

# 2)
sub <- str_subset(sentences, "'")
str_match_all(sub, "([a-z_AZ]+)'([a-zA_Z]+)")


##################################### Replacing Matches #####################################################

x <- c("apple", "pear", "banana")
str_replace(x, "[aeiou]", "-")
str_replace_all(x, "[aeiou]", "-")

x <- c("1 house", "2 cars", "3 people")
str_replace_all(x, c("1" = "one", "2" = "two", "3" = "three")) # multiple replacements by supplying a named vector

sentences %>%
  str_replace("([^ ]+) ([^ ]+) ([^ ]+)", "\\1 \\3 \\2") %>% # with backreference
  head(5)


## Exercises:
# 1)
writeLines(str_replace("my/string", "/", "\\\\"))
# 2)
lower <- letters
names(lower) <- LETTERS
str_replace_all("ABCDE", lower)
# 3)
repl <- str_replace(words, "\\b(\\w)(\\w*)(\\w)\\b", "\\3\\2\\1")
repl[repl %in% words]


################################### Splitting ############################################################

require(tidyverse)
require(stringr)

sentences %>%
  head(5) %>%
  str_split(" ") # returns a list

"a|b|c|d" %>%
  str_split("\\|") %>%
  .[[1]] # extract first element

sentences %>%
  head(5) %>%
  str_split(" ", simplify = TRUE) # returns matrix

fields <- c("Name: Hadley", "Country: NZ", "Age: 35")
fields %>% str_split(": ", n = 2, simplify = TRUE) # define maximum number of pieces

x <- "This is a sentence. This is another sentence."
str_view_all(x, boundary("word"))
str_split(x, " ")[[1]]
str_split(x, boundary("word"))[[1]] # splitting by word boundary (other options: character, line, sentence)


## Exercises:
# 1)
x <- "apples, pears, and bananas"
str_split(x, boundary("word"))[[1]]

# 3)
str_split(x, "")[[1]] # splitting by empty string splits each character (equivalent to below)
str_split(x, boundary("character"))[[1]]


######################################## Other Types of Pattern ###############################################

# The regular call:
str_view(fruit, "nana") # a string supplied is automatically wrapped into a call to regex()
# Is shorthand for
str_view(fruit, regex("nana")) # regex() has more arguments to control details of the match

bananas <- c("banana", "Banana", "BANANA")
str_view(bananas, "banana")
str_view(bananas, regex("banana", ignore_case = TRUE)) # ignores case

x <- "Line 1\nLine 2\nLine 3"
str_extract_all(x, "^Line")[[1]]
str_extract_all(x, regex("^Line", multiline = TRUE))[[1]]
# allows ^ and $ to match the start and end of each line rather than the start and end of the complete string

# Including explaining comments into regex:
phone <- regex("
\\(?
# optional opening parens
(\\d{3}) # area code
[)- ]?
# optional closing parens, dash, or space
(\\d{3}) # another three numbers
[ -]?
# optional space or dash
(\\d{3}) # three more numbers
", comments = TRUE)

str_match("514-791-8141", phone)

# dotall = TRUE allows . to match everything, including \n

microbenchmark::microbenchmark(
  fixed = str_detect(sentences, fixed("the")), # fixed() matches exactly the specified sequence of bytes (no regex)
  regex = str_detect(sentences, "the"),
  times = 20
)
# fixed is much faster then using regex, but bytes have to match exactly
a1 <- "\u00e1" # can be a problem with some characters, that can be represented in different ways
a2 <- "a\u0301"
c(a1, a2)
a1 == a2 # render identically, but they’re defined differently

str_detect(a1, fixed(a2))
str_detect(a1, coll(a2)) # coll can be used instead, takes this problem into account

# coll() compares strings using standard collation rules, is dependent on the locale!!
# That means you also need to be aware of the difference
# when doing case-insensitive matches:
i <- c("I", "İ", "i", "ı")
i
str_subset(i, coll("i", ignore_case = TRUE))
str_subset(
  i,
  coll("i", ignore_case = TRUE, locale = "tr")
)
# fixed() and regex() have ignore_case arguments, but they do not allow you to pick the locale (always use default)
stringi::stri_locale_info()
# coll() is relatively slow compared to regex() and fixed()

x <- "This is a sentence."
str_view_all(x, boundary("word"))
str_extract_all(x, boundary("word")) # boundary() can be used with different functions


## Exercises:
# 1)
x <- c("first item", "second item", "thi\\rd item", "item fo\\ur")
writeLines(x)
str_view_all(x, regex(".*\\\\.*"))
str_extract_all(x, regex(".*\\\\.*"))
x[str_detect(x, regex(".*\\\\.*"))]

str_view_all(x, fixed("\\"))
x[str_detect(x, fixed("\\"))]

# 2)
nested <- str_extract_all(sentences, boundary("word"))
sort(table(unlist(nested)), decreasing = TRUE)[1:5]


# apropos() from base R searches all objects available from the global environment
apropos("replace")
# dir() lists all the files in a directory
head(dir(pattern = "\\.R$"))
# both use regex

# stringi is a more extensive library for string manipulation than sringr
## Exercises:
require(stringi)
# 1a)
?stri_count_words
# b)
?stri_duplicated
# c)
stri_rand_strings(5, 10)

# 2)
?stri_sort # language is controlled by locale setting


####################################### Chapter 12: Factors with forcats ###################################

library(tidyverse)
library(forcats)

####################################### Creating Factors ###################################################

x1 <- c("Dec", "Apr", "Jan", "Mar")
x2 <- c("Dec", "Apr", "Jam", "Mar") # Typos are possible when using strings
sort(x1) # string don't sort properly

month_levels <- c(
  "Jan", "Feb", "Mar", "Apr", "May", "Jun",
  "Jul", "Aug", "Sep", "Oct", "Nov", "Dec"
) # valid levels for the categorical variable
y1 <- factor(x1, levels = month_levels) # creating a factor
y1
sort(y1)
y2 <- factor(x2, levels = month_levels) # values not in levels are converted to NA
y2
y2 <- parse_factor(x2, levels = month_levels) # aöternative, which gives an error for values not in levels

factor(x1) # omitting levels leads to levels in alphabetical order

f1 <- factor(x1, levels = unique(x1)) # levels in order of first appearance
f1
f2 <- x1 %>% factor() %>% fct_inorder() # alternative for line above
f2

levels(f2) # accessing valid levels

gss_cat # example data from General Social Survey

gss_cat %>%
  count(race) # count shows the levels of a factor variable
ggplot(gss_cat, aes(race)) +
  geom_bar() # plots the factor levels
ggplot(gss_cat, aes(race)) +
  geom_bar() +
  scale_x_discrete(drop = FALSE) # also shows levels without any value

## Exercises
# 1)
ggplot(gss_cat, aes(rincome)) +
  geom_bar()
levels(gss_cat$rincome)
gss_cat %>% 
  filter(!rincome %in% c("No answer", "Don't know", "Refused", "Not applicable")) %>% 
  ggplot(aes(rincome)) +
  geom_bar()

# 2)
gss_cat %>% 
  count(relig) %>% 
  arrange(desc(n))
gss_cat %>% 
  count(partyid) %>% 
  arrange(desc(n))

# 3)
table(gss_cat$relig, gss_cat$denom) # denom applies to Protestant
gss_cat %>% 
  ggplot(aes(x = relig, group = denom, fill = denom)) +
    geom_bar()


############################################### Modifying Factor Order #########################################

relig <- gss_cat %>%
  group_by(relig) %>%
  summarize(
    age = mean(age, na.rm = TRUE),
    tvhours = mean(tvhours, na.rm = TRUE),
    n = n()
  )
ggplot(relig, aes(tvhours, relig)) + geom_point()

ggplot(relig, aes(tvhours, fct_reorder(relig, tvhours))) + # reorders levels, default function is median
  geom_point()

relig %>%
  mutate(relig = fct_reorder(relig, tvhours)) %>% # alternative to above with mutate
  ggplot(aes(tvhours, relig)) +
  geom_point()

rincome <- gss_cat %>%
  group_by(rincome) %>%
  summarize(
    age = mean(age, na.rm = TRUE),
    tvhours = mean(tvhours, na.rm = TRUE),
    n = n()
  )
ggplot(
  rincome,
  aes(age, fct_reorder(rincome, age)) # makes not much sense here because factor has a principled order
) + geom_point()

ggplot(
  rincome,
  aes(age, fct_relevel(rincome, "Not applicable")) ) + # relevel moves level to top
  geom_point()

by_age <- gss_cat %>%
  filter(!is.na(age)) %>%
  group_by(age, marital) %>%
  count() %>%
  ungroup() %>% 
  mutate(prop = n / sum(n))
by_age
ggplot(by_age, aes(age, prop, color = marital)) +
  geom_line(na.rm = TRUE)

ggplot(
  by_age,
  aes(age, prop, color = fct_reorder2(marital, age, prop)) # reorders levels by y value associated with largest x value
) +
  geom_line() +
  labs(color = "marital")

gss_cat %>%
  mutate(marital = marital %>% fct_infreq() %>%  # fct_infreq orders by frequency
           fct_rev() ) %>% # fct_rev reverses order
  ggplot(aes(marital)) +
  geom_bar()


## Exercises
# 1)
ggplot(gss_cat, aes(y = tvhours, x = relig)) +
  geom_boxplot()
mean(gss_cat$tvhours, na.rm = TRUE)
median(gss_cat$tvhours, na.rm = TRUE)
gss_cat %>% 
  group_by(relig) %>% 
  summarise(mean = mean(tvhours, na.rm = TRUE), 
            median = median(tvhours, na.rm = TRUE),
            n = n())
# Median is better than mean

# 2)
gss_cat %>% 
  count(marital) # levels arbitrary
gss_cat %>% 
  count(race) # levels arbitrary
gss_cat %>% 
  count(rincome) # # levels ordered
gss_cat %>% 
  count(partyid) # levels ordered
gss_cat %>% 
  count(relig) # levels arbitrary
gss_cat %>% 
  count(denom) # levels arbitrary


########################################### Modifying Factor Levels ############################################

gss_cat %>% count(partyid)

gss_cat %>%
  mutate(partyid = fct_recode(partyid, # changes levels, leaves not mentioned levels as is
                              "Republican, strong"
                              = "Strong republican",
                              "Republican, weak"
                              = "Not str republican",
                              "Independent, near rep" = "Ind,near rep",
                              "Independent, near dem" = "Ind,near dem",
                              "Democrat, weak"
                              = "Not str democrat",
                              "Democrat, strong"
                              = "Strong democrat"
  )) %>%
  count(partyid)

gss_cat %>%
  mutate(partyid = fct_recode(partyid,
                              "Republican, strong"
                              = "Strong republican",
                              "Republican, weak"
                              = "Not str republican",
                              "Independent, near rep" = "Ind,near rep",
                              "Independent, near dem" = "Ind,near dem",
                              "Democrat, weak"
                              = "Not str democrat",
                              "Democrat, strong"
                              = "Strong democrat",
                              "Other"                    # use same label multiple times to combine levels
                              = "No answer",
                              "Other"
                              = "Don't know",
                              "Other"
                              = "Other party"
  )) %>%
  count(partyid)

gss_cat %>%
  mutate(partyid = fct_collapse(partyid,       # also combines multiple levels
                                other = c("No answer", "Don't know", "Other party"),
                                rep = c("Strong republican", "Not str republican"),
                                ind = c("Ind,near rep", "Independent", "Ind,near dem"),
                                dem = c("Not str democrat", "Strong democrat")
  )) %>%
  count(partyid)

gss_cat %>%
  mutate(relig = fct_lump(relig)) %>%   # fct_lump() lumps together all small groups
  count(relig)
# by default keeps combining groups until the combined group is not the samllest any more

gss_cat %>%
  mutate(relig = fct_lump(relig, n = 10)) %>%  # specify how many groups to keep
  count(relig, sort = TRUE) %>%
  print(n = Inf)


## Exercises:
# 1)
gss_cat %>% 
  mutate(partyid = fct_collapse(partyid,       # also combines multiple levels
                                other = c("No answer", "Don't know", "Other party"),
                                rep = c("Strong republican", "Not str republican"),
                                ind = c("Ind,near rep", "Independent", "Ind,near dem"),
                                dem = c("Not str democrat", "Strong democrat")
  )) %>%
  ggplot(aes(x = year, fill = partyid)) +
    geom_bar(position = "fill") +
    xlab("Year") + ylab("Proportion of people")

# 2)
gss_cat %>% 
  mutate(rincome = fct_collapse(rincome,       
                                "Not available" = c("No answer", "Don't know", "Refused", "Not applicable"),
                                "Low" = c("Lt $1000", "$1000 to 2999", "$3000 to 3999", "$4000 to 4999" ),
                                "Medium" = c("$5000 to 5999", "$6000 to 6999", "$7000 to 7999", "$8000 to 9999"),
                                "High" = c("$10000 - 14999", "$15000 - 19999", "$20000 - 24999","$25000 or more" )
  )) %>% 
  count(rincome)


######################################### Chapter 13: Dates and Times with lubridate ###########################













