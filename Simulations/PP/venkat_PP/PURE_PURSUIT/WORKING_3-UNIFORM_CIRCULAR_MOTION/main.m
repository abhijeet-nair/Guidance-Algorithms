close all; clear;
global dt;
global Alpha_p omega

STATES = [];

init

Vp = Vp_0;

Vt = Vt_0 + R_target*omega;
Alpha_t = psi+pi/2;
Xt_0 = R_target*cos(psi);
Yt_0 = R_target*sin(psi);
Vxt_0 = Vt*cos(Alpha_t);
Vyt_0 = Vt*sin(Alpha_t);

Vxp_0 = Vp*cos(Alpha_p);
Vyp_0 = Vp*sin(Alpha_p);

X = [Xt_0; Yt_0; Vxt_0; Vyt_0; Xp_0; Yp_0; Vxp_0; Vyp_0; psi]; 
R_prev = Inf;
 
for t = t0:dt:tf
    
    R       = sqrt((X(1)-X(5))^2+(X(2)-X(6))^2);
    
    if (R<R_lethal)
        disp("Target Intercepted");
        break;
    end

    theta   = atan2((X(2)-X(6)),(X(1)-X(5)));

    Vr      = Vt*cos(Alpha_t-theta) - Vp*cos(Alpha_p-theta);
    Vtheta  = Vt*sin(Alpha_t-theta) - Vp*sin(Alpha_p-theta);   
    theta_dot = Vtheta/R;

    a_lat = guidance_pp(t, Vp, theta, Alpha_p, theta_dot, R);

    STATES = [STATES; t, R, a_lat, X', theta/CD2R, Alpha_t/CD2R, Alpha_p/CD2R, Vr, Vtheta];
    
    X = rrkk(X, a_lat);
    
    Alpha_p = atan2(X(8),X(7));
    Alpha_t = X(9)+(pi/2);
    R_prev = R;
end

plotit(STATES);
