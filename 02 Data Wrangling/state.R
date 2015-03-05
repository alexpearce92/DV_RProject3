# Create texas dataframe
texas.df <- StormMeta.df %>% 
  select(STATE, EVENT_TYPE) %>%
  group_by(STATE, EVENT_TYPE) %>%
  filter(STATE == "TEXAS") %>%
  summarise(OCCURENCES = n())

# Create california dataframe
california.df <- StormMeta.df %>% 
  select(STATE, EVENT_TYPE) %>%
  group_by(STATE, EVENT_TYPE) %>%
  filter(STATE == "CALIFORNIA") %>%
  summarise(OCCURENCES = n())

# Create florida dataframe
florida.df <- StormMeta.df %>% 
  select(STATE, EVENT_TYPE) %>%
  group_by(STATE, EVENT_TYPE) %>%
  filter(STATE == "FLORIDA") %>%
  summarise(OCCURENCES = n())

# Create final state dataframe
state.df <- dplyr::bind_rows(texas.df, california.df, florida.df)

# Preview state dataframe
tbl_df(state.df)
