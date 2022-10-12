library(readr)
library(ggplot2)
library(dplyr)

# Read datasets/confirmed_cases_worldwide.csv into confirmed_cases_worldwide
confirmed_cases_worldwide <-read_csv("confirmed_cases_worldwide.csv")

# See the result
confirmed_cases_worldwide

# Draw a line plot of cumulative cases vs. date
# Label the y-axis
ggplot(confirmed_cases_worldwide,aes(date,cum_cases))+
  geom_line()+
  labs(y = "Cumulative confirmed cases")

confirmed_cases_china_vs_world <-
  read_csv("confirmed_cases_china_vs_world.csv")

# See the result
confirmed_cases_china_vs_world

# Draw a line plot of cumulative cases vs. date, colored by is_china
# Define aesthetics within the line geom
plt_cum_confirmed_cases_china_vs_world <- ggplot(confirmed_cases_china_vs_world,aes(date,cum_cases)) +
  geom_line(aes(date,cum_cases,colour="is_china")) +
  ylab("Cumulative confirmed cases")

# See the plot
plt_cum_confirmed_cases_china_vs_world

who_events <- tribble(
  ~ date, ~ event,
  "2020-01-30", "Global health\nemergency declared",
  "2020-03-11", "Pandemic\ndeclared",
  "2020-02-13", "China reporting\nchange"
) %>%
  mutate(date = as.Date(date))

# Using who_events, add vertical dashed lines with an xintercept at date
# and text at date, labeled by event, and at 100000 on the y-axis
plt_cum_confirmed_cases_china_vs_world +geom_vline(aes(xintercept=date), data= who_events, linetype="dashed")+
  geom_text(aes(x=date,label=event),data=who_events, y=100000)

# Filter for China, from Feb 15
china_after_feb15 <- confirmed_cases_china_vs_world %>%
  filter(date>="2020-02-15")
#china_after_feb15

# Using china_after_feb15, draw a line plot cum_cases vs. date
# Add a smooth trend line using linear regression, no error bars
ggplot(china_after_feb15,aes(date,cum_cases)) +
  geom_line() +
  geom_smooth(method='lm',se= FALSE)+
  ylab("Cumulative confirmed cases")