## load library
library(tidyverse)

## ggplot

ggplot(data = mtcars,
       mapping = aes(x= mpg, y = hp )) +
    geom_point() +
    geom_smooth(method = "lm")

## point shape available in R 
## Hex color
## modify components of the theme

## one variable - continuous

ggplot(mtcars, aes(mpg)) +
  geom_histogram(bins = 6)

base <- ggplot(mtcars, aes(mpg))

base + geom_density()
base + geom_histogram(bins = 5, 
                      fill="gold",
                      color="black")
base + geom_area(stat = "bin")

## one variable - discrete
# only geom_bar

mtcars %>%
  select(am, hp, wt) %>%
  mutate(am = ifelse(am==0 , "Auto", "Manual")) %>%
  ggplot(aes(am,fill=am)) +
  geom_bar()

## two variables - both continuous

base <- ggplot(data = mtcars,
       mapping = aes(hp, mpg))
base +
  geom_point() +
  geom_smooth(method = "lm") +
  geom_rug()

## setting VS mapping 
# setting
base +
  geom_point(
    col = "red", # color
    size = 3, # size of shape
    alpha = 0.5, # opacity [0 -> 1]
    shape = 19 # number of shape in R
  )

# mapping
base +
  geom_point(mapping = aes(col=factor(am))) 

base +
  geom_point(mapping = aes(col=wt))

## explore data with chart
set.seed(42)
small_df <- diamonds %>%
  sample_frac(0.1) %>%
  filter(cut %in% c("Fair","Premium","Ideal"))

ggplot(small_df, aes(carat,price)) +
  geom_point(alpha = 0.3,
             col = "orange") +
  theme_minimal()

base2 <- ggplot(small_df, aes(carat,price,col=cut)) +
  geom_point() +
  theme_minimal()

## facet , sub-plot
base2 + 
  facet_wrap(~cut, nrow = 1)

base2 +
  facet_wrap(~color, ncol = 3)
  
ggplot(small_df, aes(carat,price,col=cut)) +
  geom_point() +
  theme_minimal() +
  facet_grid(color ~ cut) # x=color, y=cut

ggplot(small_df, aes(carat,price)) +
  geom_point() +
  geom_smooth(se = FALSE, col = "red") + 
  # SE = standard error (confidence interval)
  theme_minimal() +
  facet_grid(color ~ cut) 

## Example: Stats Case
# limit the number of data point interval (by filter) to reduce outlier (make more clear "lm", not too curve)
# data points were more grouped
ggplot(small_df %>%
         filter(carat <= 2.5),
         mapping =  aes(carat,price)) +
  geom_point() +
  geom_smooth(se = FALSE, col = "red") + 
  theme_minimal()

## set title, caption, x/y label
base3 <- ggplot(small_df %>%
                filter(carat <= 2.5),
                mapping =  aes(carat,price)) +
  geom_point() +
  geom_smooth(se = FALSE, col = "red") + 
  theme_minimal()

base3 +
  labs(title = "Correlation is vey strong",
       subtitle = "Correlation = 0.85", 
       caption = "Source: ggplot packages",
       x = "Diamond carat",
       y = "Price $ USD")

## change color manual
df <-data.frame(
  ID = 1:5,
  fruits = c(rep("orange",3), (rep("banana",2))),
  price = c(5,10,15,20,25),
  weight = c(10,12,14,12,11)
  )

#scale color on Discrete value
# apply-> scale_color_manual
ggplot(df, aes(weight,price, color=fruits)) +
  geom_point(size=3) +
  scale_color_manual(values = c("gold","blue")) +
  theme_minimal()

#scale color on Continuous value
# apply-> scale_color_gradient
ggplot(df, aes(weight,price, color=price)) +
  geom_point(size=3) +
  scale_color_gradient(low = "gold",high = "red") +
  theme_minimal()


## multiple data frame in one chart

df1 <- df %>% filter(weight < 12)
df2 <- df %>% filter(weight >= 12)

ggplot() +
  theme_minimal() +
  geom_point(data = df1,
             mapping = aes(weight,price),
             color="salmon", size=3) +
  geom_point(data = df2,
             mapping = aes(weight,price),
             color="black", size=3)


