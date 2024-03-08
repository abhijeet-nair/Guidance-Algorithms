clc; clear; close all;

tspan = 0:0.01:50;

% Initial Conditions
xp0 = 0;
yp0 = 0;
vp0 = 90;
xt0 = 50;
yt0 = 50;
vt0 = 100;
alpt0 = deg2rad(120);
del = deg2rad(10);

R0 = sqrt((yt0 - yp0)^2 + (xt0 - xp0)^2);
tht0 = atan((yt0 - yp0)/(xt0 - xp0));
alpp0 = tht0 + del;
% alpp0 = deg2rad(0);
% VR0 = vt0*cos(alpt0 - tht0) - vp0;
% Vtht0 = vt0*sin(alpt0 - tht0);

X0 = [xp0, yp0, vp0, alpp0, xt0, yt0, vt0, alpt0, R0, tht0]; %, VR0, Vtht0];

vp_d = 0;
vt_d = 0;
alpt_d = deg2rad(10);
% alpt_d = 0;
K = 0.5;
CT = 0;

opt = odeset('Events',@stopInt,'RelTol',1e-12,'AbsTol',1e-12);

[tsol,Xsol] = ode45(@(t,X)modelDPP(t,X,vp_d,vt_d,alpt_d,K,CT,del),tspan,X0,opt);

if isequal(tsol,tspan')
    fprintf('\nIntegration has not stopped\n')
else
    fprintf('\nTime of hit tf = %.4f\n',tsol(end))
end

alpp = Xsol(:,4);
tht = Xsol(:,10);
R = Xsol(:,9);
VR = Xsol(:,7).*cos(Xsol(:,8) - tht) - Xsol(:,3).*cos(Xsol(:,4)- tht);
Vtht = Xsol(:,7).*sin(Xsol(:,8) - tht) - Xsol(:,3).*sin(Xsol(:,4) - tht);
% 
figure(1)
% f1.Position = [500,300,600,600];
for i = 1:40:length(tsol)
    plot(Xsol(1:i,1),Xsol(1:i,2),'LineWidth',1,'Color','blue','DisplayName','P')
    hold on
    plot(Xsol(1:i,5),Xsol(1:i,6),'LineWidth',1,'Color','red','DisplayName','T')
    scatter(Xsol(i,1),Xsol(i,2),15,'b','filled','HandleVisibility','off')
    scatter(Xsol(i,5),Xsol(i,6),15,'r','filled','HandleVisibility','off')
    plot([Xsol(i,1),Xsol(i,5)],[Xsol(i,2),Xsol(i,6)],'LineStyle','-.','Color','k','DisplayName','R','LineWidth',1)
    hold off
    title(['Trajectory in real plane at t = ',num2str(tsol(i),'%.2f'),' s'],'FontSize',14,'FontName','Bookman Old Style')
%     xlim([-20,20])
%     ylim([-5,35])
    pause(0.0001)
end
xlabel('X (in m)','FontSize',14,'FontName','Bookman Old Style')
ylabel('Y (in m)','FontSize',14,'FontName','Bookman Old Style')
%%% THIS IS TO CONFIRM THE CIRCLE
% lim = axis;
% yl = lim(4) - lim(3);
% xl = lim(2) - lim(1);
% a = lim(3) - 0.5*(xl - yl);
% b = lim(4) + 0.5*(xl - yl);
% ylim([a,b])
% axis square
%%% TILL HERE
grid on
grid minor
legend('Location','best','FontSize',14,'FontName','Bookman Old Style')
% 
figure(2)
for i = 1:40:length(tsol)
    plot(Vtht(1:i),VR(1:i),'LineWidth',1,'Color','blue')
    hold on
    scatter(Vtht(i),VR(i),15,'k','filled')
    xline(0,'k-','LineWidth',1)
    yline(0,'k-','LineWidth',1)
    xline(R(i)*alpt_d,'r-','LineWidth',1)
    hold off
    title(['V_R vs V_\theta at t = ',num2str(tsol(i),'%.2f'),' s'],'FontSize',14,'FontName','Bookman Old Style')
%     xlim([-1,10])
%     ylim([-10,10])
    pause(0.0001)
end
xlabel('V_\theta','FontSize',14,'FontName','Bookman Old Style')
ylabel('V_R','FontSize',14,'FontName','Bookman Old Style')
grid on
grid minor



figure(3)
plot(tsol,R,'LineWidth',1,'Color','red')
ylabel('R (in m)','FontSize',14,'FontName','Bookman Old Style')
title('R vs t','FontSize',14,'FontName','Bookman Old Style')
grid on
grid minor

figure(4)
plot(tsol,VR,'LineWidth',1,'Color','red')
ylabel('V_R (in m/s)','FontSize',14,'FontName','Bookman Old Style')
title('V_R vs t','FontSize',14,'FontName','Bookman Old Style')
grid on
grid minor

figure(5)
plot(tsol,Vtht,'LineWidth',1,'Color','red')
hold on
plot(tsol,R*alpt_d,'LineWidth',1,'Color','blue')
ylabel('V_\theta (in m/s)','FontSize',14,'FontName','Bookman Old Style')
title('V_\theta vs t','FontSize',14,'FontName','Bookman Old Style')
grid on
grid minor

% if Xsol(:,4) < 0
%     alpp = 2*pi - rem(Xsol(:,4),2*pi);
% else
%     alpp = rem(Xsol(:,4),2*pi);
% end
% 
% if Xsol(:,10) < 0
%     tht = 2*pi - rem(Xsol(:,10),2*pi);
% else
%     tht = rem(Xsol(:,10),2*pi);
% end

Vp = Xsol(:,3);
% t1 = tht - alpp;
% ap = zeros(size(tsol));
% for i = 1:length(tsol)
%     if tsol(i) < 0.5
%         ap(i) = K*t1(i)*Vp(i);
%     else
%         ap(i) = (K*t1(i) + Vtht(i)/R(i))*Vp(i);
%     end
% end
ap = Vp.*Vtht./R;

figure(6)
plot(tsol,ap,'LineWidth',1,'Color','red')
ylabel('a_p (in m/s^2)','FontSize',14,'FontName','Bookman Old Style')
title('ap vs t','FontSize',14,'FontName','Bookman Old Style')
grid on
grid minor

figure(7)
plot(tsol,rad2deg(alpp - tht),'LineWidth',1,'Color','red')
ylabel('\delta (in deg)','FontSize',14,'FontName','Bookman Old Style')
title('\delta vs t','FontSize',14,'FontName','Bookman Old Style')
grid on
grid minor

figure(8)
plot(tsol,rad2deg(alpp),'LineWidth',1,'Color','red','DisplayName','\alpha')
hold on
plot(tsol,rad2deg(tht),'LineWidth',1,'Color','blue','DisplayName','\theta')
ylabel('Angle (in deg)','FontSize',14,'FontName','Bookman Old Style')
title('\alpha_p & \theta vs t','FontSize',14,'FontName','Bookman Old Style')
grid on
grid minor
legend('Location','best','FontSize',14,'FontName','Bookman Old Style')