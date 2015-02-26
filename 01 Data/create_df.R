#Generate sat info
SatInfo.df <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from sat_info"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='C##cs329e_aip256',PASS='orcl_aip256',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))

#Generate sat origin
SatOrigin.df <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from sat_origins"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='C##cs329e_aip256',PASS='orcl_aip256',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))

#Generate sat launch info
SatLaunch.df <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select * from sat_launch"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='C##cs329e_aip256',PASS='orcl_aip256',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))

#Preview tables
tbl_df(SatInfo.df)
tbl_df(SatOrigin.df)
tbl_df(SatLaunch.df)

#Will create single table from all data frames
#Satellites.df <- data.frame(fromJSON(getURL(URLencode('129.152.144.84:5001/rest/native/?query="select o.SATNAME, o.COUNTRY, i.*, l.LAUNCH, l.SITE, l.DECAY, l.PERIOD, l.INCLINATION, l.APOGEE, l.PERIGEE from sat_info i full outer join sat_launch l on (i.norad_cat_id = l.norad_cat_id) full outer join sat_origins o on (i.norad_cat_id = o.norad_cat_id) order by o.satname"'),httpheader=c(DB='jdbc:oracle:thin:@129.152.144.84:1521:ORCL',USER='C##cs329e_aip256',PASS='orcl_aip256',MODE='native_mode',MODEL='model',returnDimensions = 'False',returnFor = 'JSON'),verbose = TRUE)))
#tbl_df(Satellites.df)
