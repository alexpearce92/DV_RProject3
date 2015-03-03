# Characterization of StormMeta Categoricals

myplot <- function(df, x) {
  names(df) <- c("x")
  ggplot(df, aes(x=x)) + geom_histogram() + scale_x_discrete(x) + theme (axis.text.x = element_text(size=6, angle=90, vjust=0.5)) + labs(title=paste("Categorical Plot - ", x)) + theme(plot.title = element_text(size=20, face="bold", vjust=1, family="Bauhaus93"))
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
  png("./00 Doc/StormMetaCategoricals.png", width = 35, height = 50, units = "in", res = 72)
  grid.newpage() 
  
  row <- 1
  colMax <- 5
  rowMax <- 4
  
  pushViewport(viewport(layout = grid.layout(rowMax, colMax), width = 1))   
  
  for (i in StormMetaPlotList){
    print(i, vp = viewport(layout.pos.row = row, layout.pos.col = 1:5))
    row <- row + 1
  }
  
  dev.off()
}

