function [ ServiceName, Region, Availability, Outages, DownTime, Cost, Price ]  = ReadAmazonDataSet()
%CONVERTTOTXTTOMATRIX Summary of this function goes here
%   Detailed explanation goes here
format short;


doc1='D:\Matlab Projects\Hedonic Game WS\AmazonEC2';

doc11=[doc1 '.txt'];
    
[ServiceName, Region, Availability, Outages, DownTime, Cost, Price]= textread(doc11,'%s %s %f %f %s %f %f');

 
end