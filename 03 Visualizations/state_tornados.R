library(scales)
tornados.df %>% ggplot(aes(x=Date, y=log(Cost), color= Injuries, size=Deaths)) + scale_color_gradient2(low="white", high="black") + geom_point() + scale_x_date()+ geom_line(color="grey") + scale_y_continuous(trans=log10_trans()) + facet_wrap(~STATE,nrow=52)
