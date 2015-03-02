# Create png for StormPath categorical plots

png("../00 Doc/StormPathCategoricals.png", width = 25, height = 10, units = "in", res = 72)
grid.newpage()
pushViewport(viewport(layout = grid.layout(2, 12)))   

col <- 1
row <- 1
for (i in StormMetaPlotList){
  print(i, vp = viewport(layout.pos.row = row, layout.pos.col = col:col+5))
  col <- col + 6
  if (col >= 12){
    col <- 1
    row <- row + 1
  }
}

dev.off()