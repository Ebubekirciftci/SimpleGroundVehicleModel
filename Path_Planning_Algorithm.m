clc
clear
%% Waypoints Defining [X position, Y position, Velocity, Waiting Time,Turn Diameter]
%units: [meter, meter, meter/second, second, meter]
% warning: Simulink file have to run after waypoints are determined and run
% this file.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%% Path Planing Alghoritm %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% Writed By Ebu Bekir Çiftçi %%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


waypoint(1,:)=[200 400 10 0 30];
%waypoint(1,:)=[1000 1100 20 0 30];
%waypoint(3,:)=[2000 300 110/3.6 0 0];
%waypoint(4,:)=[3000 500 120/3.6 0 0];











ww=waypoint;

%% Points Calculation for Turn Situation
h=height(waypoint);
 k=0;
 m=0;
for i=1:h
   m=m+1;
    if waypoint(i,5)>0
        
    R=waypoint(i,5)/2;
    X=waypoint(i,1);
    Y=waypoint(i,2);
    if i>1;
       
    first_angle=atan2(waypoint(i,2)-waypoint(i-1,2),waypoint(i,1)-waypoint(i-1,1));
    dist=sqrt((waypoint(i,1)-waypoint(i-1,1))^2 +(waypoint(i,2)-waypoint(i-1,2))^2)
    W(m,1)=waypoint(i,1)-dist/4*cos(first_angle);
    W(m,2)=waypoint(i,2)-dist/4*sin(first_angle);
    W(m,3)=waypoint(i,3);
    W(m,4)=0;
    W(m,5)=0;
    else
        m=m-1;
        first_angle=atan2(waypoint(i,2),waypoint(i,1));
    end
    if first_angle>0 && first_angle<=pi/2
        a=first_angle+135 :-15:first_angle-195;
    
    elseif first_angle<=-pi/2 && first_angle>-pi
        a=first_angle-25 :-15:first_angle-355;
    
    elseif first_angle>pi/2 && first_angle<=pi
        a=first_angle+225 :-15:first_angle-105;
    
    elseif first_angle>-pi/2 && first_angle<0
        a=first_angle+25 :-15:first_angle-305;
    end
    for j=a(1):-15:a(23)
        m=m+1;
      
        theta=j*pi/180;
        x=X+R*cos(theta);
        y=Y+R*sin(theta);
        Waypoint(1)=x;
        Waypoint(2)=y;
        Waypoint(3)=1.1;
        Waypoint(4)=0;
        Waypoint(5)=first_angle;
        
        
        W(m,:)=Waypoint;
        
    end
    else
    W(m,:)=waypoint(i,:);
    end
    
end

waypoint=W;

%Waypoint_Number=height(waypoint)

%waypoint_with_start=[0 0 0 0 0;waypoint];



%% Points Calculation for stop situation


m=0;
for i=1:height(waypoint)
    m=m+1;
   
    if waypoint(i,4)>0
        
    if i>1;
       
    psi_angle=atan2(waypoint(i,2)-waypoint(i-1,2),waypoint(i,1)-waypoint(i-1,1));
    w(m,1)=waypoint(i,1)-waypoint(i,3)*20*cos(psi_angle);
    w(m,2)=waypoint(i,2)-waypoint(i,3)*20*sin(psi_angle);
    w(m,3)=waypoint(i,3);
    w(m,4)=0;
    w(m,5)=0;
    
    m=m+1;
    else
    psi_angle=atan2(waypoint(i,2),waypoint(i,1));
    w(m,1)=waypoint(i,1)-waypoint(i,3)*20*cos(psi_angle);
    w(m,2)=waypoint(i,2)-waypoint(i,3)*20*sin(psi_angle);
    w(m,3)=waypoint(i,3);
    w(m,4)=0;
    w(m,5)=0;
    
    m=m+1;
    end
    w(m,1)=waypoint(i,1);
    w(m,2)=waypoint(i,2);
    w(m,3)=1;
    w(m,4)=waypoint(i,4)+25; % +30 second for Velocity response time
    w(m,5)=waypoint(i,5);
   
    else
    w(m,:)=waypoint(i,:);
    end
    
    
    
    
end  

waypoint=w;

Waypoint_Number=height(waypoint);

if Waypoint_Number==1;
waypoint=[waypoint(1,:);waypoint(1,:)];
Waypoint_Number=Waypoint_Number+1;
end


waypoint
Waypoint_Number
waypoint_with_start=[0 0 0 0 0;waypoint]

