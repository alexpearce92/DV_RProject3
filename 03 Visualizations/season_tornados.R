library(scales)
#Convert Dates to Seasons. 
#This function was found here: http://stackoverflow.com/questions/9500114/find-which-season-a-particular-date-belongs-to Thanks to Josh O' Brien.
getSeason <- function(DATES) {
  WS <- as.Date("2012-12-15", format = "%Y-%m-%d")
  SE <- as.Date("2012-3-15",  format = "%Y-%m-%d")
  SS <- as.Date("2012-6-15",  format = "%Y-%m-%d")
  FE <- as.Date("2012-9-15",  format = "%Y-%m-%d")
  
  d <- as.Date(strftime(DATES, format="2012-%m-%d"))
  
  ifelse (d >= WS | d < SE, "Winter",
          ifelse (d >= SE & d < SS, "Spring",
                  ifelse (d >= SS & d < FE, "Summer", "Fall")))
}

tornados.df$Date <- getSeason(tornados.df$Date)

tornados.df %>% ggplot(aes(x=Date, y=Injuries, color= Deaths, size=Cost)) + scale_color_gradient2(low="white", high="red") + geom_point() + ylab("Injuries") + ggtitle("Tornado Injuries Per Season")+ theme(plot.title =element_text(size= 18, face="bold",vjust = 1.5)) + theme(legend.key = element_blank())+ theme(axis.line=element_line(color='black')) + geom_jitter(alpha = 0.75, position = position_jitter(width = 0.4)) + theme(panel.background = element_rect(fill = "black")) + xlab("Season") + theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) + theme(legend.direction = "horizontal",legend.position="bottom", legend.box = "horizontal" )