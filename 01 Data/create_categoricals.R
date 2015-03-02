# Generate categorical columns

CategoricalsStormPath<- eval(parse(text=substring(getURL(URLencode('http://129.152.144.84:5001/rest/native/?query="select * from storm_path"'), httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_aip256', PASS='orcl_aip256', MODE='native_mode', MODEL='model', returnFor = 'R', returnDimensions = 'True'), verbose = TRUE), 1, 2^31-1)))

CategoricalsStormMeta<- eval(parse(text=substring(getURL(URLencode('http://129.152.144.84:5001/rest/native/?query="select * from storm_meta"'), httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_aip256', PASS='orcl_aip256', MODE='native_mode', MODEL='model', returnFor = 'R', returnDimensions = 'True'), verbose = TRUE), 1, 2^31-1)))

CategoricalsStormImpact<- eval(parse(text=substring(getURL(URLencode('http://129.152.144.84:5001/rest/native/?query="select * from storm_impact"'), httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL', USER='C##cs329e_aip256', PASS='orcl_aip256', MODE='native_mode', MODEL='model', returnFor = 'R', returnDimensions = 'True'), verbose = TRUE), 1, 2^31-1)))