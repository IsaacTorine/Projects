
# Please complete the following test using the data provided and summarize your thoughts in a Powerpoint Presentation.
# Please attach all code used to creating anything included in your final summary. 

# Question  ###############################################################################################################################################################

# Using the raw match data, tell the 'story of the game', incorporating information on each phase of the game and paying special attention to the Red Bull style of play.

# Library Statements  ###############################################################################################################################################################
library(tidyverse)
library(readr)
library(ggplot2)
library(dplyr)
# Read in Data  ###############################################################################################################################################################
match_events = read_csv("/Users/isaac_torine/Desktop/match_events_for_test.csv")
# Your Code Goes Below!  ###############################################################################################################################################################
#Summary of Stats
summary(match_events)


#Data for Red Bulls Passing
Passing <- match_events %>%
    filter(
      team == "New York Red Bulls",
      total_score >= 0,
      game_state %in% c('Drawing', 'Winning'),
      event_type %in% c('Pass')
    ) %>%
    arrange(total_score, possession)


#long-format data for both pass_height_name and pass_type_name
Passing_long <- Passing %>%
  select(total_score, pass_height_name, pass_type_name) %>%
  pivot_longer(cols = c(pass_height_name, pass_type_name), names_to = "attribute", values_to = "value") %>%
  drop_na(value)


#Bar Chart of Passing Frequency
ggplot(Passing_long, aes(x = total_score, fill = value)) +
  geom_bar(position = "stack") +
  facet_wrap(~ attribute, scales = "free_y") +
  scale_x_continuous(breaks = seq(min(Passing_long$total_score), max(Passing_long$total_score), by = 1)) +
  labs(title = "Frequency of Pass Attributes by Total Score",
       x = "Total Score",
       y = "Frequency",
       fill = "Pass Attribute Value") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.title = element_text(hjust = 0.5))  


#Data for Red Bulls TOP when in Attacking 3rd
time_of_poss<- match_events %>%
  filter(
    team =="New York Red Bulls",
    area %in% c('Attacking 3rd'),
    possession >= 0,
    time_in_poss>=0.011
  ) %>%
  arrange (total_score, possession)
summary(time_of_poss)


#Histogram of TOP in Attacking 3rd
ggplot(time_of_poss, aes(x = time_in_poss)) +
  geom_histogram(bins = 30, fill = "blue", color = "black") +
  labs(x = "Time in Possession (seconds)", y = "Frequency",
       title = "Time in Possession when Attacking 3rd") +
  scale_x_continuous(breaks = seq(min(time_of_poss$time_in_poss, na.rm = TRUE), 
                                  max(time_of_poss$time_in_poss, na.rm = TRUE), by = 15)) +
  theme_minimal()


#Data for Red Bulls TOP when Defending 3rd
time_of_poss_defending<- match_events %>%
  filter(
    team =="New York Red Bulls",
    area %in% c('Defending 3rd'),
    possession >= 0,
    time_in_poss>=0.011
  ) %>%
  arrange (total_score, possession)


#Histogram of TOP when Defending 3rd
ggplot(time_of_poss_defending, aes(x = time_in_poss)) +
  geom_histogram(bins = 30, fill = "blue", color = "black") +
  labs(x = "Time in Possession (seconds)", y = "Frequency",
       title = "Time in Possession when Defending 3rd") +
  scale_x_continuous(breaks = seq(min(time_of_poss$time_in_poss, na.rm = TRUE), 
                                  max(time_of_poss$time_in_poss, na.rm = TRUE), by = 15)) +
  theme_minimal()


#Data for Red Bulls TOP when in Middle 3rd
time_of_poss_middle<- match_events %>%
  filter(
    team =="New York Red Bulls",
    area %in% c('Middle 3rd'),
    possession >= 0,
    time_in_poss>=0.011
  ) %>%
  arrange (total_score, possession)


#Histogram of TOP when in Middle 3rd
ggplot(time_of_poss_middle, aes(x = time_in_poss)) +
  geom_histogram(bins = 30, fill = "blue", color = "black") +
  labs(x = "Time in Possession (seconds)", y = "Frequency",
       title = "Time in Possession when Middle 3rd") +
  scale_x_continuous(breaks = seq(min(time_of_poss$time_in_poss, na.rm = TRUE), 
                                  max(time_of_poss$time_in_poss, na.rm = TRUE), by = 15)) +
  theme_minimal()


#Data for Shot Location, time of game shot was taken, and who took it for the Red Bulls 
Shot_location <- match_events %>%
  filter(
    team == "New York Red Bulls",
    area %in% c('Defending 3rd', 'Middle 3rd', 'Attacking 3rd'),
    location_x >= 0,
    location_y >= 0,
    minute >= 0,
    second >= 0,
    db_player_id >= 0,
    event_type == 'Shot'
  ) %>%
  arrange(minute, second)


#Scatter Plot of Shot Location per player and time of game for Red Bulls
ggplot(Shot_location, aes(x = location_x, y = location_y, color = area, shape = factor(db_player_id))) +
  geom_point(alpha = 0.6, size = 3) +
  geom_text(aes(label = paste(minute, ":", second, sep = "")), vjust = -.5, hjust = 1) +  # Add time labels
  scale_color_manual(values = c('Defending 3rd' = 'red', 'Middle 3rd' = 'green', 'Attacking 3rd' = 'blue')) +
  labs(x = "Location X", y = "Location Y",
       title = "Shot Locations of New York Red Bulls") + 
  theme_minimal() +
  theme(legend.position = "right",plot.title = element_text(hjust = 0.5)) +
  guides(color = guide_legend(title = "Field Area"),
         shape = guide_legend(title = "Player ID"))


#Data for Shot Location, time of game shot was taken, and who took it for Inter Miami
Shot_location_opp <- match_events %>%
  filter(
    team == "Opposition",
    area %in% c('Defending 3rd', 'Middle 3rd', 'Attacking 3rd'),
    location_x >= 0,
    location_y >= 0,
    minute >= 0,
    second >= 0,
    db_player_id >= 0,
    event_type == 'Shot'
  ) %>%
  arrange(minute, second)


#Graph of Shot location for Inter Miami
ggplot(Shot_location_opp, aes(x = location_x, y = location_y, color = area, shape = factor(db_player_id))) +
  geom_point(alpha = 0.6, size = 3) +  # Adjust point transparency and size for visibility
  geom_text(aes(label = paste(minute, ":", second, sep = "")), vjust = -.5, hjust = 1) +  # Add time labels
  scale_color_manual(values = c('Defending 3rd' = 'green', 'Middle 3rd' = 'blue', 'Attacking 3rd' = 'red')) +
  labs(x = "Location X", y = "Location Y",
       title = "Shot Locations of Inter Miami") + 
  theme_minimal() +
  theme(legend.position = "right",plot.title = element_text(hjust = 0.5)) +
  guides(color = guide_legend(title = "Field Area"),
         shape = guide_legend(title = "Player ID"))


#Data for time of poss for Red Bulls removing outliers (mean 16.763)
non_outliers <- match_events %>%
  filter(team == "New York Red Bulls" & time_in_poss >= 4.107 & time_in_poss <= 24.727)
NYRB_time <- non_outliers %>%
  mutate(category = ifelse(time_in_poss > 16.763, "Above Mean", "Below Mean")) %>%
  group_by(category) %>%
  summarise(count = n()) %>%
  mutate(percentage = count / sum(count) * 100)


#Pie Chart of Red Bulls time of poss relative to mean
ggplot(NYRB_time, aes(x = "", y = percentage, fill = category)) +
  geom_bar(stat = "identity", width = 1) +  
  coord_polar(theta = "y") +  
  labs(fill = "Possession Category", 
       title = "Percentage of NY Red Bulls Time in Possession Relative to Mean",
       x = NULL, y = NULL) +   
  geom_text(aes(label = sprintf("%.1f%%", percentage)), position = position_stack(vjust = 0.5)) +  
  theme_void()  


#Data for time of poss Inter Miami removing outliers (mean 16.763)
non_outliers_opp <- match_events %>%
  filter(team == "Opposition" & time_in_poss >= 4.107 & time_in_poss <= 24.727)
opp_time <- non_outliers_opp %>%
  mutate(category = ifelse(time_in_poss > 16.763, "Above Mean", "Below Mean")) %>%
  group_by(category) %>%
  summarise(count = n()) %>%
  mutate(percentage = count / sum(count) * 100)


# Pie chart of Inter Miami time of poss relative to mean
ggplot(opp_time, aes(x = "", y = percentage, fill = category)) +
  geom_bar(stat = "identity", width = 1) +  # Use bars to create the pie chart
  coord_polar(theta = "y") +  # Transform the bar chart into a pie chart
  labs(fill = "Possession Category", 
       title = "Percentage of Inter Miami Time in Possession Relative to Mean",
       x = NULL, y = NULL) +  # Clean up labels
  geom_text(aes(label = sprintf("%.1f%%", percentage)), position = position_stack(vjust = 0.5)) +  # Add percentage labels inside the pie
  theme_void()  # Remove unnecessary elements like axes and grid lines


#Data for Pressure applied by Red Bulls in each area of the field
Pressure <- match_events %>%
  filter(team== "New York Red Bulls",
         event_type==('Pressure'),
         area %in% c('Attacking 3rd', 'Defending 3rd', 'Middle 3rd'),
         minute>=0,
         second>=0,
         total_score>=0
         ) %>%
  arrange(minute, second, total_score)


#Data to count how many times pressure is applied by the Red Bulls at each minute of the game
Pressure_count <- Pressure %>%
  group_by(minute, total_score) %>%
  summarise(pressure_count = n(), .groups = 'drop') %>%
  arrange(minute, total_score)


#Bar chart of frequency of pressure events for the Red Bulls per minute
ggplot(Pressure_count, aes(x = as.factor(minute), y = pressure_count, fill = as.factor(total_score))) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_fill_brewer(palette = "Set1", name = "Score") +
  labs(title = "Frequency of Pressure Events Per Minute",
       x = "Minute of Game",
       y = "Count of Pressure Events",
       fill = "Game Score") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 0, hjust = 1),
       plot.title= element_text(hjust = 0.5))


#Data to count how many Pressure events took place in each area of the field throughout the game for the Red Bulls
Pressure_area <- Pressure %>%
  group_by(area, sb_position) %>%
  summarise(pressure_area_count = n(), .groups='drop') %>%
  arrange(pressure_area_count)
ggplot(Pressure_area, aes(x = area, y = pressure_area_count, fill = sb_position)) +
  geom_bar(stat = "identity", position = position_dodge()) +
  scale_fill_brewer(palette = "Set3", name = "Position") +
  labs(title = "Pressure Events by Area and Position",
       x = "Area of the Field",
       y = "Count of Pressure Events",
       fill = "Position") +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1),
        plot.title= element_text(hjust=0.5))

#Count Frequency of Turnovers and Fouls Committed based on area in the field for Inter Miami
Opp_Turnovers <- match_events %>%
  filter(team == "Opposition",
         event_type %in% c('Error', 'Foul Committed', 'Miscontrol', 'Dispossessed'),
         area %in% c('Attacking 3rd', 'Defending 3rd', 'Middle 3rd')) %>%
  group_by(area, event_type) %>%
  summarise(opp_turnover_count = n(), .groups = 'drop') %>%
  arrange(desc(opp_turnover_count))

#Cumulative sum of opp_turnover_count within each area group for Red Bulls
Opp_Turnovers <- Opp_Turnovers %>%
  arrange(area, desc(event_type)) %>%  
  group_by(area) %>%
  mutate(cumsum = cumsum(opp_turnover_count),
         label_position = cumsum - (0.5 * opp_turnover_count))

#Count Frequency of Interceptions the Red Bulls had in each area of the field
RedBulls_Int <- match_events %>%
  filter(team == "New York Red Bulls",
         event_type == 'Interception',
         area %in% c('Attacking 3rd', 'Defending 3rd', 'Middle 3rd')) %>%
  group_by(area) %>%
  summarise(RB_Int_Count = n(), .groups = 'drop') %>%
  arrange(desc(RB_Int_Count))

#Bar chart of Inter Miami's turnovers/mistakes per area
ggplot(Opp_Turnovers, aes(x = area, y = opp_turnover_count, fill = event_type)) +
  geom_bar(stat = "identity", position = "stack") +
  geom_text(aes(y = label_position, label = opp_turnover_count), vjust = 0.5, color = "white", size = 3.5) +
  labs(title = "Opposition Turnovers by Area",
       x = "Field Area",
       y = "Number of Events",
       fill = "Event Type") +
  theme_minimal() +
  theme(plot.title= element_text(hjust=0.5))

#Bar Chart of Red Bulls Interceptions Per Area 
ggplot(RedBulls_Int, aes(x = area, y = RB_Int_Count, fill = "Interception")) +
  geom_bar(stat = "identity", position = "stack") +
  labs(title = "NY Red Bulls Interceptions by Area",
       x = "Field Area",
       y = "Number of Interceptions") +
  theme_minimal() +
  theme(plot.title= element_text(hjust=0.5)) 

#Data for location of Red Bulls players throughout the game
valid_events <- match_events %>%
  filter(team=="New York Red Bulls",
         !is.na(location_x) & !is.na(location_y))

#Heat Map of Player Positions on the field 
ggplot(valid_events, aes(x = location_x, y = location_y)) +
  stat_density_2d(aes(fill = ..level..), geom = "polygon", n = 100, contour_var = "ndensity") +
  scale_fill_viridis_c(option = "magma", direction = -1) +
  labs(title = "Density Plot of Player Positions",
       x = "Field Width",
       y = "Field Length") +
  theme_minimal() +
  theme(axis.title = element_text(size = 12),
        plot.title = element_text(hjust = 0.5))


        






    

