%% initRobot
clear all
close all
clc
global  pose robotpar ts
pose = [0 0 0];
robotpar = [0.26 0.035 0.035];
ts = 0.01;

%% Set variables
wheelspeed=[5.714 4.714];
%% drive forward
fwd(2,3);
%% turn
turn(pi/2,1);
%% drive forward
fwd(4,3)
%% turn
turn(pi/2,1);
%% drive forward
fwd(4,4);

%% Plot the results all commands
figure('Name','Log plot','Position',[950 50 600 300]);
t=0:1:length(pose)-1;
subplot(1,2,1)
plot(t*ts,pose(:,3))
title('Heading change')
xlabel('time in seconds');ylabel('theta in radians');
ylim([-pi pi]);
%figure('Name','Position')
subplot(1,2,2)
scatter(pose(:,1),pose(:,2),'x')
title('Position');
xlabel('x-coordinate');ylabel('y-coordinate');
%print('aarset3problem10a','-dpng')