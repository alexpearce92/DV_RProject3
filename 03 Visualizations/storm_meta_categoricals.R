# Characterization of StormMeta Categoricals

myplot <- function(df, x) {
  names(df) <- c("x")
  ggplot(df, aes(x=x)) + geom_histogram(na.rm = TRUE) + scale_x_discrete(x) + theme (axis.text.x = element_text(size=3, angle=90, vjust=0.5)) + labs(title=paste("Categorical Plot - ", x)) + theme(plot.title = element_text(size=20, face="bold", vjust=1, family="Times"))
}

StormMetaPlotList <- list()
for (i in names(StormMeta.df)) { 
  if (i %in% CategoricalsStormMeta[[1]]) {
    r <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select \\\""i"\\\" from STORM_META where \\\""i"\\\" is not null"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='C##cs329e_aip256',PASS='orcl_aip256',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON', i=i),verbose = TRUE)))
    p <- myplot(r,i)
    print(p) 
    StormMetaPlotList[[i]] <- p
  }
}

# Create png for StormMeta categorical plots
if (length(StormMetaPlotList) > 0) {
  png("../00 Doc/StormMetaCategoricals.png", width = 50, height = 30, units = "in", res = 72)
  grid.newpage() 
  row <- 1
  col <- 1
  interval <- 1
  colMax <- 6
  rowMax <- 2
  firstPlotLarge <- TRUE
  pushViewport(viewport(layout = grid.layout(rowMax, colMax)))   
  for (i in StormImpactPlotList){
    if (firstPlotLarge == TRUE){
      print(i, vp = viewport(layout.pos.row = row, layout.pos.col = col:colMax))
      firstPlotLarge == FALSE
    } else {
      print(i, vp = viewport(layout.pos.row = row, layout.pos.col = col:col + interval))
    }
    col <- col + interval + 1
    if (col >= colMax | col + interval >= colMax) {
      row <- row + 1
      col <- 1
    }  
  }
  
  pushViewport(viewport(layout = grid.layout(2, 6)))   
  print(StormMetaPlotList[[1]], vp = viewport(layout.pos.row = 1, layout.pos.col = 1:6))
  print(StormMetaPlotList[[2]], vp = viewport(layout.pos.row = 2, layout.pos.col = 1:2))
  print(StormMetaPlotList[[3]], vp = viewport(layout.pos.row = 2, layout.pos.col = 3:4))
  print(StormMetaPlotList[[4]], vp = viewport(layout.pos.row = 2, layout.pos.col = 5:6))
  
  dev.off()
}

