# plot impact per year
ggplot(impact_per_year.df, aes(x=YEAR), na.rm = "TRUE") + geom_line(aes(y=sumDeaths, color="Deaths")) + geom_line(aes(y=sumInjuries, color="Injuries")) +facet_wrap(~EVENT_TYPE, nrow=12) + theme (axis.text.x = element_text(angle=90, vjust=0.5)) + scale_y_continuous("Deaths and Injuries") + scale_x_continuous(breaks=c(2000:2010))
