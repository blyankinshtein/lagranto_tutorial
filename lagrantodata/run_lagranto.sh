#!/bin/sh

# launch trajectories from 00UTC of June 1, 2013 to 00UTC of June 3, 2013

startdate='20130601_00'
enddate='20130603_00'

# create a file with starting locations
# every 80 km in a box [60W, 20E, 30N, 80N]
# every 8 hPa in a layer 1030-790 hPa

create_startf $startdate startf.2 'box.eqd(-60,20,30,80,80)@profile(1030,790,8)@hPa' -changet

# calculate trajectories. -j flag prevents stops at the ground level
caltra $startdate $enddate startf.2 traj.4 -j   

#repeat for additional trajectories launched every 6 hours

startdates=('20130601_06' '20130601_12' '20130601_18' '20130602_00' '20130602_06' '20130602_12' '20130602_18' '20130603_00')
enddates=('20130603_06' '20130603_12' '20130603_18' '20130604_00' '20130604_06' '20130604_12' '20130604_18' '20130605_00')

for i in {0..7};
do
#echo $i
#echo ${startdates[i]}
create_startf ${startdates[i]} startf.2 'box.eqd(-60,20,30,80,80)@profile(1030,790,8)@hPa' -changet
caltra ${startdates[i]} ${enddates[i]} startf.2 traj_i.4 -j   

mergetra traj_i.4 traj.4 traj.4
done

# select trajectories with ascent of more than 500 hPa

select.ecmwf traj.4 wcb.1 'GT:p(DIFF):500:FIRST,LAST'

# trace variables from tracevars file along selected trajectories

trace wcb.1 wcb.1
