# plot impact per year
ggplot(impact_per_year.df, aes(x=YEAR), na.rm = "TRUE") + geom_line(aes(y=sumDamage, color="Damage"), show_guide=FALSE) + facet_wrap(~EVENT_TYPE, nrow=9) + theme (axis.text.x = element_text(angle=90, vjust=0.5)) + scale_y_continuous("Damage in millions ($)") + scale_x_continuous(breaks=c(2000:2010))
