# Characterization of StormMeta Categoricals

plotHistogram <- function(df, x) {
  names(df) <- c("x")
  p <- ggplot(df, aes(x=x)) + geom_histogram(na.rm = TRUE) + scale_x_continuous(x) + theme(axis.text.x = element_text(size=7, angle=90, vjust=0.5), axis.text.y = element_text(size=10, vjust=0.5), axis.title.x = element_text(size=10), axis.title.y = element_text(size=10), plot.title = element_text(size=15, face="bold", vjust=1, family="Times")) + labs(title=paste("Measure Plot - ", x))
  p
}

plotPoint <- function (df, x) {
  g <- names(df)
  names(df) <- c("x", "n")
  p <- ggplot(df, aes(x=x, y=n)) + geom_point() + scale_x_discrete(x) + labs(title=paste("Categorical Plot - ", x)) + theme(axis.text.x = element_text(size=7, angle=90, vjust=0.5),  axis.text.y = element_text(size=10, vjust=0.5), axis.title.x = element_text(size=10), axis.title.y = element_text(size=10), plot.title = element_text(size=15, face="bold", vjust=1, family="Times"))
  p
}

StormMetaHistPlotList <- list()
StormMetaPointPlotList <- list()

for (i in names(StormMeta.df)) { 
  
  #Categorical Columns
  if (i %in% CategoricalsStormMeta[[1]]) {
    r <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select \\\""i"\\\", count(*) n from STORM_META group by \\\""i"\\\" "'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='C##cs329e_aip256',PASS='orcl_aip256',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON', i=i),verbose = TRUE)))
    p <- plotPoint(r,i)
    print(p) 
    StormMetaPointPlotList[[i]] <- p
  }
  
  # Measure columns
  if (i %in% CategoricalsStormMeta[[2]]) {
    r <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select \\\""i"\\\" from STORM_META where \\\""i"\\\" is not null"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='C##cs329e_aip256',PASS='orcl_aip256',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON', i=i),verbose = TRUE)))
    p <- plotHistogram(r,i)
    print(p) 
    StormMetaHistPlotList[[i]] <- p
  }
}

# Create png for StormMeta plots
if (length(StormMetaPointPlotList) > 0) {
  png("../00 Doc/StormMetaCategoricals.png", width = 25, height = 25, units = "in", res = 72)
  grid.newpage()
  pushViewport(viewport(layout = grid.layout(2, 6)))   
  print(StormMetaPointPlotList[[1]], vp = viewport(layout.pos.row = 1, layout.pos.col = 1:6))
  print(StormMetaPointPlotList[[2]], vp = viewport(layout.pos.row = 2, layout.pos.col = 1:2))
  print(StormMetaPointPlotList[[3]], vp = viewport(layout.pos.row = 2, layout.pos.col = 3:4))
  print(StormMetaPointPlotList[[4]], vp = viewport(layout.pos.row = 2, layout.pos.col = 5:6))
  dev.off()
}

if (length(StormMetaHistPlotList) > 0){
  png("../00 Doc/StormMetaMeasurables.png", width = 15, height = 15, units = "in", res = 72)
  grid.newpage()
  pushViewport(viewport(layout = grid.layout(2, 6)))   
  print(StormMetaHistPlotList[[1]], vp = viewport(layout.pos.row = 1, layout.pos.col = 1:6))
  print(StormMetaHistPlotList[[2]], vp = viewport(layout.pos.row = 2, layout.pos.col = 1:6))
  dev.off()
}
