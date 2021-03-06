function newpose = kinupdate(pose, robotpar, ts, time, wheelspeed)
%This function takes a 
%   pose: [x,y,theta] in INERTIAL FRAME (column vector)
%   robotpar [wheel separation, radius right wheel, radius left wheel]
%   sampletime [ts],
%   time [time], 
%   wheelspeed [angular velocity right wheel, angular velocity left wheel]
% The function returns
%   newpose [x, y, theta] in the INERTIAL FRAME (row vector)
%   ---
%   ---
%   It is associated with 31388 Adv. Aut. Robots Course
%   Gruop 8, spring 2017, DTU Electrical Engineering
%   ---

% Robot Parameters
w = robotpar(1);
rightWheelRadius = robotpar(2);
leftWheelRadius = robotpar(3);

% Wheel Pose
x = pose(1);
y = pose(2);
theta = pose(3);

% Wheel Speed
rightWheelSpeed = wheelspeed(1);
leftWheelSpeed = wheelspeed(2);

%A = [0.5, 0.5, 0; 0, 0. 1; 1/w, 0]

b =[(rightWheelRadius*rightWheelSpeed)/2 + (leftWheelRadius*leftWheelSpeed)/2; ...
    0; (rightWheelRadius*rightWheelSpeed)/(2*(w/2)) - (leftWheelRadius*leftWheelSpeed)/(2*(w/2))];

R= [cos(theta), sin(theta), 0; -sin(theta), cos(theta), 0; 0, 0, 1];


xi = R\b;
%zeta = inv(R)*A*b'

% Pre-Allocation
newPose = zeros(time/ts,3);
Ts = ts;

for i = 1 : time/ts
    newPose(i,:) = pose + xi*ts;
    ts = ts + Ts;
end

newpose = newPose;
