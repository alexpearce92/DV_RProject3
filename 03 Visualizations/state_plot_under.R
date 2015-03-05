state.df %>% ggplot(aes(x=OCCURENCES, y=EVENT_TYPE, color=STATE)) + geom_point(size = 4) + xlim(c(0, 850)) + ggtitle("Below 1000 Weather Occurrences")

#ggplot(state.df, aes(x=STATE, y=OCCURENCES, fill=OCCURENCES)) + geom_bar(stat="identity") + facet_wrap(~EVENT_TYPE)
