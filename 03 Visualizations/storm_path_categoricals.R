# Characterization of StormPath Categoricals

myplot <- function(df, x) {
  names(df) <- c("x")
  p <- ggplot(df, aes(x=x)) + geom_histogram(na.rm = TRUE) + scale_x_discrete(x) + theme(axis.text.x = element_text(size=6, angle=90, vjust=0.5), axis.title.x = element_text(size=20)) + labs(title=paste("Categorical Plot - ", x)) + theme(plot.title = element_text(size=40, face="bold", vjust=1, family="Times")) 
  if (x == "END_LOCATION" | x == "BEGIN_LOCATION"){
    p <- p + scale_y_continuous(limits=c(0,100))
  }
  p
}

StormPathPlotList <- list()
for (i in names(StormPath.df)) { 
  if (i %in% CategoricalsStormPath[[1]]) {
    r <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select \\\""i"\\\" from STORM_PATH where \\\""i"\\\" is not null"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='C##cs329e_aip256',PASS='orcl_aip256',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON', i=i),verbose = TRUE)))
    p <- myplot(r,i)
    print(p) 
    StormPathPlotList[[i]] <- p
  }
}

# Create png for StormPath categorical plots

if (length(StormPathPlotList) > 0) {
  png("../00 Doc/StormPathCategoricals.png", width = 50, height = 70, units = "in", res = 72)
  grid.newpage()
  pushViewport(viewport(layout = grid.layout(3, 6)))   
  print(StormPathPlotList[[1]], vp = viewport(layout.pos.row = 1, layout.pos.col = 1:3))
  print(StormPathPlotList[[2]], vp = viewport(layout.pos.row = 1, layout.pos.col = 4:6))
  print(StormPathPlotList[[3]], vp = viewport(layout.pos.row = 2, layout.pos.col = 1:6, height = 0.5))
  print(StormPathPlotList[[4]], vp = viewport(layout.pos.row = 3, layout.pos.col = 1:6, height = 0.5))
  dev.off()
}
