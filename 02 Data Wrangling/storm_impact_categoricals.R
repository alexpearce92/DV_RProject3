# Characterization of StormImpact Categoricals

myplot <- function(df, x) {
  names(df) <- c("x", "n")
  ggplot(df, aes(x=x, y=n)) + geom_point() + scale_x_discrete(x)
}

StormImpactPlotList <- list()
for (i in names(StormImpact.df)) { 
  if (i %in% CategoricalsStormImpact[[1]]) {
    r <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select \\\""i"\\\", count(*) n from STORM_IMPACT group by \\\""i"\\\" "'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='C##cs329e_aip256',PASS='orcl_aip256',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON', i=i),verbose = TRUE)))
    p <- myplot(r,i)
    print(p) 
    StormImpactPlotList[[i]] <- p
  }
}

