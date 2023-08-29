 function [] = plotit(STATES)

figure(1), plot(STATES(:,4), STATES(:,5)), grid on; hold on;
figure(1), plot(STATES(:,8), STATES(:,9)), grid on; hold on;
xlabel("X (m)");
ylabel("Y (m)");
title("Trajectory");
legend("Target", "Pursuer");

figure(2), plot(STATES(:,1), STATES(:,2)), grid on; hold on;
xlabel("Time (s)");
ylabel("Range (m)");
title("Time Vs. Range");

% figure(3), plot(STATES(:,1), STATES(:,3)), grid on; hold on;
% xlabel("Time (s)");
% ylabel("Lateral Acceleration (m/s^2)");
% title("Time Vs. Command");
% 
% figure(4), plot(STATES(:,1), STATES(:,13)), grid on; hold on;
% figure(4), plot(STATES(:,1), STATES(:,14)), grid on; hold on;
% figure(4), plot(STATES(:,1), STATES(:,15)), grid on; hold on;
% xlabel("Time (s)");
% ylabel("Angle (deg)");
% title("Time Vs. Angles");
% legend("\theta", "\alpha_T", "\alpha_P");
% 
% figure(5), plot(STATES(:,16), STATES(:,15)), grid on; hold on;
% xlabel("V_{\theta} (m/s)");
% ylabel("V_R (m/s)");
% title("V_{\theta} Vs. V_R");

% 
% figure(5), plot(STATES(:,1), STATES(:,16)), grid on; hold on;
% figure(5), plot(STATES(:,1), STATES(:,15)), grid on; hold on;
% xlabel("Time (s)");
% ylabel("V_{\theta} (m/s)");

end

