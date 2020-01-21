function [ ServiceName, Region, Availability, Outages, DownTime ]  = ReadCloudDataSet()
%CONVERTTOTXTTOMATRIX Summary of this function goes here
%   Detailed explanation goes here
format short;


doc1='D:\Matlab Projects\Hedonic Game WS\CloudCompute';

doc11=[doc1 '.txt'];
    
[ServiceName, Region, Availability, Outages, DownTime]= textread(doc11,'%s %s %f %f %s');

 
end