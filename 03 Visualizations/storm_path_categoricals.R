# Characterization of StormPath Categoricals

plotHistogram <- function(df, x) {
  names(df) <- c("x")
  p <- ggplot(df, aes(x=x)) + geom_histogram(na.rm = TRUE) + scale_x_continuous(x) + theme(axis.text.x = element_text(size=7, angle=90, hjust=1), axis.text.y = element_text(size=10, vjust=0.5), axis.title.x = element_text(size=10), axis.title.y = element_text(size=10), plot.title = element_text(size=15, face="bold", vjust=1, family="Times")) + labs(title=paste("Measure Plot - ", x))
  p
}

plotPoint <- function (df, x) {
  names(df) <- c("x", "n")
  p <- ggplot(df, aes(x=x, y=n)) + geom_point() + scale_x_discrete(x, labels = abbreviate) + labs(title=paste("Categorical Plot - ", x)) + theme(axis.text.x = element_text(size=7, angle=90, hjust=1),  axis.text.y = element_text(size=10, vjust=0.5), axis.title.x = element_text(size=10), axis.title.y = element_text(size=10), plot.title = element_text(size=15, face="bold", vjust=1, family="Times"))
  if (x == "BEGIN_LOCATION" | x == "END_LOCATION"){
    p <- p + theme(axis.text.x = element_text(size=2, vjust=0.5)) + scale_y_continuous(limits=c(0,500))
  }
  p
}

StormPathHistPlotList <- list()
StormPathPointPlotList <- list()

for (i in names(StormPath.df)) { 
  
  #Categorical Columns
  if (i %in% CategoricalsStormPath[[1]]) {
    r <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select \\\""i"\\\", count(*) n from STORM_PATH group by \\\""i"\\\" "'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='C##cs329e_aip256',PASS='orcl_aip256',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON', i=i),verbose = TRUE)))
    p <- plotPoint(r,i)
    print(p) 
    StormPathPointPlotList[[i]] <- p
  }
  
  # Measure columns
  if (i %in% CategoricalsStormPath[[2]]) {
    r <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select \\\""i"\\\" from STORM_PATH where \\\""i"\\\" is not null"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='C##cs329e_aip256',PASS='orcl_aip256',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON', i=i),verbose = TRUE)))
    p <- plotHistogram(r,i)
    print(p) 
    StormPathHistPlotList[[i]] <- p
  }
}

# Create png for StormPath plots
if (length(StormPathPointPlotList) > 0) {
  png("../00 Doc/StormPathCategoricals.png", width = 25, height = 25, units = "in", res = 72)
  grid.newpage()
  pushViewport(viewport(layout = grid.layout(2, 6)))   
  print(StormPathPointPlotList[[1]], vp = viewport(layout.pos.row = 1, layout.pos.col = 1:3))
  print(StormPathPointPlotList[[2]], vp = viewport(layout.pos.row = 1, layout.pos.col = 4:6))
  print(StormPathPointPlotList[[3]], vp = viewport(layout.pos.row = 2, layout.pos.col = 1:3))
  print(StormPathPointPlotList[[4]], vp = viewport(layout.pos.row = 2, layout.pos.col = 4:6))
  dev.off()
}

if (length(StormPathHistPlotList) > 0){
  png("../00 Doc/StormPathMeasurables.png", width = 15, height = 25, units = "in", res = 72)
  grid.newpage()
  pushViewport(viewport(layout = grid.layout(4, 6)))   
  print(StormPathHistPlotList[[1]], vp = viewport(layout.pos.row = 1, layout.pos.col = 1:3))
  print(StormPathHistPlotList[[2]], vp = viewport(layout.pos.row = 1, layout.pos.col = 4:6))
  print(StormPathHistPlotList[[3]], vp = viewport(layout.pos.row = 2, layout.pos.col = 1:3))
  print(StormPathHistPlotList[[4]], vp = viewport(layout.pos.row = 2, layout.pos.col = 4:6))
  print(StormPathHistPlotList[[5]], vp = viewport(layout.pos.row = 3, layout.pos.col = 1:3))
  print(StormPathHistPlotList[[6]], vp = viewport(layout.pos.row = 3, layout.pos.col = 4:6))
  print(StormPathHistPlotList[[7]], vp = viewport(layout.pos.row = 4, layout.pos.col = 1:3))
  print(StormPathHistPlotList[[8]], vp = viewport(layout.pos.row = 4, layout.pos.col = 4:6))
  dev.off()
}
