close all; clear;
global dt;
global Alpha_p 

STATES = [];

init

Vp = Vp_0;
Vt = Vt_0;

Vxt_0 = Vt*cos(Alpha_t);
Vyt_0 = Vt*sin(Alpha_t);
Vxp_0 = Vp*cos(Alpha_p);
Vyp_0 = Vp*sin(Alpha_p);

X = [Xt_0; Yt_0; Vxt_0; Vyt_0; Xp_0; Yp_0; Vxp_0; Vyp_0]; 

R_prev = Inf;
 
for t = t0:dt:tf
    R       = sqrt((X(1)-X(5))^2+(X(2)-X(6))^2);
    if (R>R_prev)
        break;
    end

    Alpha_p = atan2(X(8),X(7));
    theta   = atan2((X(2)-X(6)),(X(1)-X(5)));

    Vr      = Vt*cos(Alpha_t-theta) - Vp*cos(Alpha_p-theta);
    Vtheta  = Vt*sin(Alpha_t-theta) - Vp*sin(Alpha_p-theta);    
    theta_dot = Vtheta/R;

    a_lat = guidance_pp(t, Vp, theta, Alpha_p, theta_dot, R);

    STATES = [STATES; t, R, a_lat, X', theta];
    
    X = rrkk(X, a_lat);
    R_prev = R;
end

figure(1), plot(STATES(:,4), STATES(:,5)), grid on; hold on;
figure(1), plot(STATES(:,8), STATES(:,9)), grid on; hold on;

figure(2), plot(STATES(:,1), STATES(:,2)), grid on; hold on;

figure(3), plot(STATES(:,1), STATES(:,3)), grid on; hold on;

figure(4), plot(STATES(:,1), STATES(:,end)*180/pi), grid on; hold on;
