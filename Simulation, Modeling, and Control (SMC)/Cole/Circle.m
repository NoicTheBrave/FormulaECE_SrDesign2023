function U = Circle(XBar, resetIntegral)
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
    global Array;
    global Index;
    global velocity;
    global dt;
    persistent oldD;
    persistent integralFactor;
    persistent integralPlot;
    persistent t;

    plotting = false;

    if(plotting)
        if(isempty(t))
            t = 0;
        end
    end

    if(isempty(oldD))
        oldD = 0;
        integralFactor = 0;
    end

    if(resetIntegral == 1)
        integralFactor = 0;
    end

    x = XBar(1);
    y = XBar(2);
    thetaC = XBar(3);

    lam = Array(Index,5);
    Rcirc = Array(Index,4);
    c = [Array(Index,2); Array(Index,3)];
    Rcar = norm(c - [x;y]);

    error = Rcar - Rcirc;

    if(Index == 14)
        ki = 0.0004;
    elseif(Index == 7)
        ki = 0.0002;
    else
        ki = 0.00035;
    end

    if(lam == 0)
        kp = -0.4;
        kd = -0.5;
        ki = -ki;
    else
        kp = 0.4;
        kd = 0.5;
    end

    if(resetIntegral == 1)
        deriv = 0;
    else
        deriv = (error-oldD)/dt;
    end

    %set the steering angle with PD controller to steer towards line
    thetaDot = error*kp + integralFactor * ki + kd*deriv;
    U(1) = velocity;
    U(2) = thetaDot; 
    oldD = error;
    integralFactor = integralFactor + error*dt;

    if(plotting)
        if t == 0
            integralPlot = plot(t, integralFactor, 'k')
            hold on
            xlabel('t (s)')
            ylabel('Integral Component of Controller');
        else
            set(integralPlot, 'Xdata', [get(integralPlot,'Xdata') t], 'Ydata', [get(integralPlot,'Ydata') integralFactor])
        end
        t = t + dt;
    end
end