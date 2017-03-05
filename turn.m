function turn(angle,speed )
%turns the robot a certain angle at a certain speed
%input angle in radians and speed in m/s
%a positive angle turns the robot CCW
% It depends on the global variable ts for sampling time and
% it updates the global variable pose (used for among other things the log)


global ts pose
turntime=round((abs(angle)/speed),2)
initpose=getCurrentPose; 

steps=turntime/ts-1; % Calculates number of steps in turning
newPose=zeros(steps+1,3);% prearrange array for pose
increment=angle/steps; % calculate size of increment in angle pr. sample
newPose(1,:)=initpose; % setting first value of array
for i=2:length(newPose)
    newPose(i,:)=newPose(i-1,:) + [0 0 increment]; % summing the steps
    if newPose(i,3)> pi
        newPose(i,3)=-pi+(newPose(i,3)-pi);
    end
    if newPose(i,3)< -pi
        newPose(i,3)=pi+(newPose(i,3)+pi);
    end
end

pose = vertcat(pose,newPose);


