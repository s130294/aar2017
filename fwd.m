function forward = fwd(distance, wheelspeed)

global pose robotpar ts

% Robot Parameters
w = robotpar(1);
rightWheelRadius = robotpar(2);
leftWheelRadius = robotpar(3);

% Wheel Pose
x = pose(1);
y = pose(2);
theta = pose(3);

% Valid input
K = sign(wheelspeed);
if K == 0
    disp('Not a positive number');
end


b =[(rightWheelRadius*wheelspeed)/2 + (leftWheelRadius*wheelspeed)/2; ...
    0; (rightWheelRadius*wheelspeed)/(2*(w/2)) - (leftWheelRadius*wheelspeed)/(2*(w/2))];
R= [cos(theta), sin(theta), 0; -sin(theta), cos(theta), 0; 0, 0, 1];
xi = R\b;


% Pre-Allocation
time = distance/wheelspeed;
newPose = zeros(time/ts,3);

Ts = ts;
tsUpdate = Ts;

N = (distance/wheelspeed)/ts;


for i = 1 : N
    newPose(i,1:3) = (pose + xi*tsUpdate)';
    tsUpdate = tsUpdate + Ts;
end

% distance/(wheelspeed*ts) --> increments in distance

forward = newPose;