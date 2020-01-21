function [ ResponseTime,Availability,Throughput,Successability,Reliability,Compliance,BestPractices,Latency,ServiceName,WSDLAddress ]  = ConvertToTxtToMatrix()
%CONVERTTOTXTTOMATRIX Summary of this function goes here
%   Detailed explanation goes here
format short;


% x=zeros(0,0);
% y=zeros(0,0);
% z=zeros(0,0);
% dist=zeros(0,0);

doc1='D:\Matlab Projects\Hedonic Game WS\QWS_Dataset_v2';
%doc2='D:\code\vanet project 1\traceOutput_debuged_';

    doc11=[doc1 '.txt'];
    %doc22=[doc2 num2str(numberOfNodes) '.txt'];
    
    
[ResponseTime,Availability,Throughput,Successability,Reliability,Compliance,BestPractices,Latency, Documentation, ServiceName, WSDLAddress,~]= textread(doc11,'%f %f %f %f %f %f %f %f %f %s %s %s','delimiter',',');
%[~,DISTANCE,T2]= textread(doc22,'%s %f %f');

    
 
end