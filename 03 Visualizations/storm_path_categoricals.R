# Characterization of StormPath Categoricals

myplot <- function(df, x) {
  names(df) <- c("x")
  ggplot(df, aes(x=x)) + geom_histogram(na.rm = TRUE) + scale_x_discrete(x) + theme (axis.text.x = element_text(size=6, angle=90, vjust=0.5)) + labs(title=paste("Categorical Plot - ", x)) + theme(plot.title = element_text(size=20, face="bold", vjust=1, family="Times"))
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
  png("../00 Doc/StormPathCategoricals.png", width = 35, height = 50, units = "in", res = 72)
  grid.newpage()
  row <- 1
  col <- 1
  interval <- 1
  colMax <- 4
  rowMax <- 2
  firstPlotLarge <- FALSE
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
  
  dev.off()
}
