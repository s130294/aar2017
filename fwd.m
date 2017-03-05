function forward = fwd(distance, wheelspeed)

global pose robotpar  ts

% Robot Parameters
w = robotpar(1);
rightWheelRadius = robotpar(2);
leftWheelRadius = robotpar(3);

% Wheel Pose
wheelpose=getCurrentPose
x = wheelpose(1);
y = wheelpose(2);
theta = wheelpose(3);

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
abswheelspeed = abs(wheelspeed)
absdistance = abs(distance)
time =round( absdistance/abswheelspeed,2)
newPose = zeros(time/ts,3); % must result in integer

Ts = ts;
tsUpdate = Ts;

%N = (distance/wheelspeed)/ts;
N=length(newPose) % Matching the assigned array...
xi=xi' % match dimensions
for i = 1 : N
    newPose(i,:) = (wheelpose + xi*tsUpdate)
    tsUpdate = tsUpdate + Ts;
end

% distance/(wheelspeed*ts) --> increments in distance

forward = newPose;
pose = vertcat(pose,newPose);