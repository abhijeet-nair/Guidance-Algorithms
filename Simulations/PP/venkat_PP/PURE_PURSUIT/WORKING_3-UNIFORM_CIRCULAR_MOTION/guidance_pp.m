function [a_lat] = guidance_pp(t, Vp, theta, Alpha_p, theta_dot, R)
global a_lat_prev
    if R>1
        K = 0.05;
        a_lat = Vp*(theta_dot+K*(theta-Alpha_p));
    else
        a_lat = a_lat_prev;
    end
    a_lat_prev = a_lat;
end

