state.df %>% filter(OCCURENCES > 1000) %>% ggplot(aes(x=OCCURENCES, y=EVENT_TYPE, color=STATE)) + geom_point(size=4) + ggtitle("Over 1000 Weather Occurrences")
