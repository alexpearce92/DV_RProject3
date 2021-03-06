tornados.df <- StormMeta.df %>% 
  select(EVENT_ID, STATE, YEAR, MONTH_NAME, EVENT_TYPE) %>% 
  filter(EVENT_TYPE == "Tornado") %>% 
  inner_join(StormImpact.df, by = "EVENT_ID") %>% 
  group_by(STATE, YEAR, MONTH_NAME) %>% 
  summarise( dir_inj = sum(INJURIES_DIRECT), indir_inj = sum(INJURIES_INDIRECT), deaths_dir = sum(DEATHS_DIRECT), deaths_indir = sum(DEATHS_INDIRECT), dmg_prop = sum(DAMAGE_PROPERTY), dmg_crop = sum(DAMAGE_CROPS)) %>% 
  mutate( Deaths = deaths_indir + deaths_dir, Cost=dmg_prop + dmg_crop, Injuries=indir_inj + dir_inj) %>% 
  unite("Date",YEAR,MONTH_NAME, sep = " ") 

tornados.df$Date <- as.Date(paste(tornados.df$Date,1), format="%Y %B %d")
