# Characterization of StormPath Categoricals

myplot <- function(df, x) {
  names(df) <- c("x")
  ggplot(df, aes(x=x)) + geom_histogram() + scale_x_discrete(x) + theme (axis.text.x = element_text(size=6, angle=90, vjust=0.5))
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

png("./00 Doc/StormPathCategoricals.png", width = 10, height = 10, units = "in", res = 72)
grid.newpage()
pushViewport(viewport(layout = grid.layout(1, 15)))   

col <- 1
row <- 1
for (i in StormPathPlotList){
  print(i, vp = viewport(layout.pos.row = row, layout.pos.col = col:col+3))
  col <- col + 4
  if (col >= 15){
    col <- 1
    row <- row + 1
  }
}

dev.off()