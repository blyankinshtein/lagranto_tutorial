#!/bin/sh

startdate='20130601_00'
enddate='20130604_00'

create_startf $startdate startf.2 'box.eqd(-80,20,40,80,80)@ level(100)@hPa,agl' -changet
head -10 startf.2
caltra $startdate $enddate startf.2 traj.4 -j   
select.ecmwf traj.4 wcb.1 'GT:p:700:FIRST & LT:p(MIN):400:0 to 48'
trace wcb.1 wcb.1

