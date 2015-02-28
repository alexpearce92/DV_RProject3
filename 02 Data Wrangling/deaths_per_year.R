# Deaths according to each type of storm over time
deaths.df <- dplyr::left_join(StormMeta.df, StormImpact.df, by = "EVENT_ID") %>%
  mutate("INJURIES"=INJURIES_DIRECT + INJURIES_INDIRECT, "DEATHS"=DEATHS_DIRECT + DEATHS_INDIRECT) %>% 
  select(EVENT_TYPE, MONTH_NAME, INJURIES,DEATHS) %>%
  arrange(desc(INJURIES)) %>%
  group_by(MONTH_NAME, EVENT_TYPE) %>%
  summarise(sumDeaths = sum(DEATHS), sumInjuries = sum(INJURIES))
deaths.df
