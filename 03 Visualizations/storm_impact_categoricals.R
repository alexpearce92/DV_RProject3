# Characterization of StormImpact Categoricals

myplot <- function(df, x) {
  names(df) <- c("x")
  ggplot(df, aes(x=x)) + geom_histogram() + scale_x_discrete(x) + theme (axis.text.x = element_text(size=6, angle=90, vjust=0.5)) + labs(title=paste("Categorical Plot - ", x)) + theme(plot.title = element_text(size=20, face="bold", vjust=1, family="Bauhaus93"))
}

StormImpactPlotList <- list()
for (i in names(StormImpact.df)) { 
  if (i %in% CategoricalsStormImpact[[1]]) {
    r <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select \\\""i"\\\" from STORM_IMPACT where \\\""i"\\\" is not null"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='C##cs329e_aip256',PASS='orcl_aip256',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON', i=i),verbose = TRUE)))
    p <- myplot(r,i)
    print(p) 
    StormImpactPlotList[[i]] <- p
  }
}

# Create png for StormImpact categorical plots
if (length(StormImpactPlotList) > 0) {
  png("./00 Doc/StormImpactCategoricals.png", width = 35, height = 50, units = "in", res = 72)
  grid.newpage()
  
  row <- 1
  colMax <- 5
  rowMax <- 4
  
  pushViewport(viewport(layout = grid.layout(rowMax, colMax), width = 1))   
  
  for (i in StormImpactPlotList){
    print(i, vp = viewport(layout.pos.row = row, layout.pos.col = 1:5))
    row <- row + 1
  }
  
  dev.off()
}