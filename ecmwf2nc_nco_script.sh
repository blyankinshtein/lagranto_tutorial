#!/bin/sh

dates='2013-06-01 2013-06-02 2013-06-03 2013-06-04 2013-06-05'

hours='00 06 12 18'

for date in $dates;
do
echo $date
for hour in $hours;
do
echo $hour
touch combined*
touch output_*
rm combined*
rm output_*
cp erai/profile-$date-$hour output_profile
cp erai/lnsp-$date-$hour output_lnsp
cp erai/sp-$date-$hour output_sp
cp erai/moisture-$date-$hour output_moisture
#cp erai/geopotential-$date-$hour output_geopotential

ncrename -d latitude,lat -d longitude,lon -d level,lev output_profile
ncrename -d latitude,lat -d longitude,lon -d level,lev output_moisture 
ncrename -d latitude,lat -d longitude,lon output_lnsp
ncrename -d latitude,lat -d longitude,lon output_sp
#ncrename -d latitude,lat -d longitude,lon output_geopotential

ncap2 -O -s 'defdim("lev_2",1);LNSP[$time,$lev_2,$lat,$lon]=float(lnsp);LNSP@long_name=lnsp@long_name;LNSP@code=152;LNSP@table=128' output_lnsp output_lnsp
ncap2 -O -s 'defdim("lev_2",1);PS[$time,$lev_2,$lat,$lon]=float(sp/100.);PS@long_name=sp@long_name;PS@code=152;PS@table=128' output_sp output_sp

#ncea -d level,0,0 output_geopotential output_h500
#ncea -d level,1,1 output_geopotential output_h700
#ncea -d level,2,2 output_geopotential output_h850
#ncea -d level,3,3 output_geopotential output_h1000

#ncdiff -O -v z output_h500 output_h1000 output_h500
#ncap2 -O -s 'T105=float(z/9.80665);T105@long_name="1000-500hPa thickness";T105@units="m"' output_h500 output_h500
#ncks -C -O -x -v z output_h500 output_h500
#ncdiff -O -v z output_h700 output_h1000 output_h700
#ncap2 -O -s 'T107=float(z/9.80665);T107@long_name="1000-700hPa thickness";T107@units="m"' output_h700 output_h700
#ncks -C -O -x -v z output_h700 output_h700
#ncdiff -O -v z output_h850 output_h1000 output_h850
#ncap2 -O -s 'T107=float(z/9.80665);T108@long_name="1000-850hPa thickness";T108@units="m"' output_h850 output_h850
#ncks -C -O -x -v z output_h850 output_h850



ncks -C -O -x -v level output_profile output_profile
ncks -C -O -x -v level output_moisture output_moisture
ncks -O -x -v lnsp output_lnsp output_lnsp
ncks -O -x -v sp output_sp output_sp

#ncks -C -O -x -v level -v latitude -v longitude output_h500 output_h500
#ncrename -d level,lev_2 output_h500
#ncks -C -O -x -v level -v latitude -v longitude output_h700 output_h700
#ncrename -d level,lev_2 output_h700
#ncks -C -O -x -v level -v latitude -v longitude output_h850 output_h850
#ncrename -d level,lev_2 output_h850

ncks -A output_profile combined_outputP
ncks -A output_lnsp combined_outputP
ncks -A output_sp combined_outputP
ncks -A output_moisture combined_outputS
ncks -A output_lnsp combined_outputS
ncks -A output_sp combined_outputS
#ncks -A output_h500 combined_outputS
#ncks -A output_h700 combined_outputS
#ncks -A output_h850 combined_outputS

ncks -A dummy combined_outputP
ncks -A dummy combined_outputS

ncap2 -O -s 'U=float(u);V=float(v);OMEGA=float(w)' combined_outputP combined_outputP
ncap2 -O -s 'T=float(t)' combined_outputP combined_outputP 
ncap2 -O -s 'Q=float(q);CC=float(cc);CLWC=float(clwc);CIWC=float(ciwc)' combined_outputS combined_outputS
ncap2 -O -s 'lon=double(longitude);lat=double(latitude);time2=double(time)' combined_outputP combined_outputP
ncap2 -O -s 'lon=double(longitude);lat=double(latitude);time2=double(time)' combined_outputS combined_outputS


ncks -C -O -x -v u,v,w,t,longitude,latitude,time combined_outputP combined_outputP
ncks -C -O -x -v q,cc,clwc,ciwc,longitude,latitude,time combined_outputS combined_outputS
ncrename -v time2,time combined_outputP
ncrename -v time2,time combined_outputS

ncpdq -O -a -lat combined_outputP combined_outputP #flip latitudes
ncpdq -O -a -lat combined_outputS combined_outputS #flip latitudes
ncks -O --msa -d lon,180.,360. -d lon,0.,179. combined_outputP combined_outputP #rotate longitudes
ncks -O --msa -d lon,180.,360. -d lon,0.,179. combined_outputS combined_outputS #rotate longitudes
ncap2 -O -s 'where(lon>=180.0) lon = lon-360.0' combined_outputP combined_outputP
ncap2 -O -s 'where(lon>=180.0) lon = lon-360.0' combined_outputS combined_outputS


cp combined_outputP `echo lagrantodata/P$date\_$hour|sed -e 's/-//g'`;
cp combined_outputS `echo lagrantodata/S$date\_$hour|sed -e 's/-//g'`;

done;
done

rm combined*
rm output_*


