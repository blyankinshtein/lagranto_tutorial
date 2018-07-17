def download_ERAi(date_str, hour_str):
    from ecmwfapi import ECMWFDataServer
    server = ECMWFDataServer()
    server.retrieve({ #required download of wind profile
        "class": "ei",
        "dataset": "interim",
        "date": date_str+"/to/"+date_str,
        "expver": "1",
        "grid": "1.0/1.0",
        "format": "netcdf",
        "levelist": "1/2/3/4/5/6/7/8/9/10/11/12/13/14/15/16/17/18/19/20/21/22/23/24/25/26/27/28/29/30/31/32/33/34/35/36/37/38/39/40/41/42/43/44/45/46/47/48/49/50/51/52/53/54/55/56/57/58/59/60",
        "levtype": "ml", #model levels
        "param": "130.128/131.128/132.128/135.128", #T, U, V, omega
        "step": "0",
        "stream": "oper",
        "time": hour_str+":00:00",
        "type": "an",
        "target": "erai/profile-"+date_str+"-"+hour_str,
    })
    server.retrieve({ #optional download of moisture and cloud profile
        "class": "ei",
        "dataset": "interim",
        "date": date_str+"/to/"+date_str,
        "expver": "1",
        "grid": "1.0/1.0",
        "format": "netcdf",
        "levelist": "1/2/3/4/5/6/7/8/9/10/11/12/13/14/15/16/17/18/19/20/21/22/23/24/25/26/27/28/29/30/31/32/33/34/35/36/37/38/39/40/41/42/43/44/45/46/47/48/49/50/51/52/53/54/55/56/57/58/59/60",
        "levtype": "ml", #model levels
        "param": "133.128/246.128/247.128/248.128", #q, clwc, ciwc, cc
        "step": "0",
        "stream": "oper",
        "time": hour_str+":00:00",
        "type": "an",
        "target": "erai/moisture-"+date_str+"-"+hour_str,
    })
#   server.retrieve({ #optional download of geopotential profile, e.g. for thickness computation
#	"class": "ei",
#	"dataset": "interim",
#	"date": date_str+"/to/"+date_str,
#	"expver": "1",
#	"grid": "1.0/1.0",
#	"format": "netcdf",
#	"levelist": "500/700/850/1000",
#	"levtype": "pl", #pressure levels
#	"param": "129.128",
#	"step": "0",
#	"stream": "oper",
#	"time": hour_str+":00:00",
#	"type": "an",
#	"target": "erai/geopotential-"+date_str+"-"+hour_str,
#   })
    server.retrieve({ #required download
        "class": "ei",
        "dataset": "interim",
        "date": date_str+"/to/"+date_str,
        "expver": "1",
        "grid": "1.0/1.0",
        "format": "netcdf",
        "levelist": "1",
        "levtype": "ml", # first model level
        "param": "129.128/152.128", #surface geopotential and logarithm of surface pressure
        "step": "0",
        "stream": "oper",
        "time": hour_str+":00:00",
        "type": "an",
        "target": "erai/lnsp-"+date_str+"-"+hour_str,
    })
    server.retrieve({ # required download
        "class": "ei",
        "dataset": "interim",
        "date": date_str+"/to/"+date_str,
        "expver": "1",
        "grid": "1.0/1.0",
        "format": "netcdf",
        "levtype": "sfc", #surface (1 level)
        "param": "134.128", #surface pressure
        "step": "0",
        "stream": "oper",
        "time": hour_str+":00:00",
        "type": "an",
        "target": "erai/sp-"+date_str+"-"+hour_str,
    })



from datetime import timedelta, date

def daterange(start_date, end_date):
    for n in range(int ((end_date - start_date).days)):
        yield start_date + timedelta(n)


start_date = date(2013, 6, 1)
end_date =   date(2013, 6, 6)


for single_date in daterange(start_date, end_date):
    date_str = single_date.strftime("%Y-%m-%d")
    for hour_str in ["00", "06", "12", "18"]:
        print date_str
        print hour_str
	download_ERAi(date_str, hour_str) 
