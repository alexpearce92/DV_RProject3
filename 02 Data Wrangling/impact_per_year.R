# Deaths according to each type of storm over time
impact_per_year.df <- dplyr::left_join(StormMeta.df, StormImpact.df, by = "EVENT_ID") %>%
  mutate("INJURIES"=INJURIES_DIRECT + INJURIES_INDIRECT, "DEATHS"=DEATHS_DIRECT + DEATHS_INDIRECT, "DAMAGE"=DAMAGE_PROPERTY + DAMAGE_CROPS) %>%   
  select(EVENT_TYPE, YEAR, INJURIES,DEATHS, DAMAGE) %>%
  arrange(desc(YEAR)) %>%
  group_by(YEAR, EVENT_TYPE) %>%
  summarise(sumDeaths = sum(DEATHS), sumInjuries = sum(INJURIES), sumDamage=sum(DAMAGE)/1000000) %>%
  filter((sumDeaths > 0 | sumInjuries > 0))
tbl_df(impact_per_year.df)
