function U = Control(X_bar)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

persistent oldD;

if(isempty(oldD))
    oldD = 0;
end

dt = 0.01;
controlLine = [1 8; 0 7];



%half plane check
%P_o = [x_b y_b]'
%O_1 = [x_o1 y_o1]'
%n = [1 0]; %normal vector depends on control line boundary
%boundary = (controlLine_1-controlLine_2)-(controlLine(1,2)-controlLine(1,1))
%if (P_o - O_1) * n >= 0:
%controlLine = controlLine_2;
%end

xdiff = controlLine(1,2) - controlLine(1,1);
ydiff = controlLine(2,2) - controlLine(2,1);
angle = atan2d(ydiff, xdiff);

R = [cosd(angle) -sind(angle) controlLine(1,1); sind(angle) cosd(angle) controlLine(2,1); 0, 0, 1];%transform matrix
D = inv(R)*[X_bar(1:2);1];

v=2;
%PID Variables
kp= -0.4;%proportion const
kd=-.3;%derivative const
ki= 0;%integration const
integ = (D(2)-oldD)*dt;
deriv = (D(2)-oldD)/dt;

thetaS = D(2)*kp + kd*deriv + ki*integ;
Acc = 0.5;
U(1) = v;
U(2) = thetaS;
oldD = D(2);

end

