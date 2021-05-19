%%%%In order for the code to run, the simulink file must be run first.


xx=out.X.data;
yy=out.Y.data;
psi=out.Psi.data;
time=out.Psi.time;



%%% global position for loop

figure
plot(out.sigma.time,out.sigma.data*180/pi,'LineWidth',2);
title('Steer angle input change with time');
ylim([min(out.sigma.data*180/pi)-1 max(out.sigma.data*180/pi)+1]);
xlabel('time (second)');
ylabel('steer angle (degree)');

figure

plot(time,psi*180/pi,'LineWidth',2);
title('Yaw angle change with time');
xlabel('time (second)');
ylabel('Yaw Angle (degree)');

figure

plot(time,out.r.data*180/pi,'LineWidth',2);

title('Yaw rate change with time');
xlabel('time (second)');
ylabel('Yaw rate (degree/second)');




figure
plot(time,out.Voltage.data,'LineWidth',2);
title('Voltage input change with time');
ylim([min(out.Voltage.data)-1 max(out.Voltage.data)+1]);
xlabel('time (second)');
ylabel('Voltage(V)');


figure
plot(time,out.Vlon.data*3.6,'LineWidth',2);
title('Longitudinal Velocity');
xlabel('time (second)');
ylabel('Velocity(kilometer/hour)');

figure
plot(out.X.data,out.Y.data,'LineWidth',2);
hold on
title('Global position');

xlabel('X (meter)');
ylabel('Y (meter)');

for i=1:height(ww)
    x_W(i)=ww(i,1);
    y_W(i)=ww(i,2);
    plot(x_W(i),y_W(i),'x','Color','k','LineWidth', 2);
    text(x_W(i)+10,y_W(i)+10,['Waypoint ',num2str(i)])
    hold on
end
