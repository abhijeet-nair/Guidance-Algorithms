clc; clear;
close all;

tspan = 0:0.1:50;

% Initial Conditions
xp0 = 0;
yp0 = 0;

xt0 = 100;
yt0 = 0;

Vt0 = 10;
nu = 2.5;
Vp0 = nu*Vt0;

alpt0 = deg2rad(0);

R0 = sqrt((yt0 - yp0)^2 + (xt0 - xp0)^2);
tht0 = atan((yt0 - yp0)/(xt0 - xp0));

alpp0 = deg2rad(120);

X0 = [xp0, yp0, Vp0, alpp0, xt0, yt0, Vt0, alpt0, R0, tht0];

vp_d = 0;
vt_d = 0;
% alpt_d = 0;
alpt_d = deg2rad(10);
N = 3;
K = N - 1;
CT = 0;

phi0 = alpp0 - N*tht0;
n = -1:1;
thtn_t = -(phi0 + n*pi)/K;

St_lb = thtn_t - asin(1/nu)/K;
St_ub = thtn_t + asin(1/nu)/K;

Sr_lb = thtn_t - asin(1/nu)/K + 0.5*pi/K;
Sr_ub = thtn_t + asin(1/nu)/K + 0.5*pi/K;

opt = odeset('Events',@stopInt,'RelTol',1e-7,'AbsTol',1e-7);

[tsol,Xsol] = ode45(@(t,X)modelPPN(t,X,vp_d,vt_d,alpt_d,N,CT),tspan,X0,opt);

if isequal(tsol,tspan')
    fprintf('\nIntegration has not stopped\n')
else
    fprintf('\nTime of hit tf = %.4f\n',tsol(end))
end

fprintf('\nParameters\t\tRequired\tFor\n')
fprintf('nu \t\t= %.2f\t  > 1\t\tCapture\n',nu)
fprintf('K*nu \t= %.2f\t  > 1\t\tCapture\n',(N-1)*nu)
fprintf('(K-1)nu = %.2f\t  > 2\t\tLatax\n',(N-2)*nu)

tht = Xsol(:,10);
R = Xsol(:,9);
VR = Xsol(:,7).*cos(Xsol(:,8) - tht) - Xsol(:,3).*cos(Xsol(:,4) - tht);
Vtht = Xsol(:,7).*sin(Xsol(:,8) - tht) - Xsol(:,3).*sin(Xsol(:,4) - tht);
%{
figure(1)
% f1.Position = [500,300,600,600];
for i = 1:10:length(tsol)
    plot(Xsol(1:i,1),Xsol(1:i,2),'LineWidth',1,'Color','blue','DisplayName','P')
    hold on
    plot(Xsol(1:i,5),Xsol(1:i,6),'LineWidth',1,'Color','red','DisplayName','T')
    scatter(Xsol(i,1),Xsol(i,2),15,'b','filled')
    scatter(Xsol(i,5),Xsol(i,6),15,'r','filled')
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
%}
figure(1)
plot(Xsol(:,1),Xsol(:,2),'LineWidth',1,'Color','blue','DisplayName','P')
hold on
plot(Xsol(:,5),Xsol(:,6),'LineWidth',1,'Color','red','DisplayName','T')
scatter(Xsol(1,1),Xsol(1,2),10,'k','filled','HandleVisibility','off')
scatter(Xsol(1,5),Xsol(1,6),10,'g','filled','HandleVisibility','off')
xlabel('X (in m)','FontSize',14,'FontName','Bookman Old Style')
ylabel('Y (in m)','FontSize',14,'FontName','Bookman Old Style')
grid on
grid minor
title('Trajectory in Real Plane','FontSize',14,'FontName','Bookman Old Style')
legend('Location','best','FontSize',14,'FontName','Bookman Old Style')

%{
figure(2)
for i = 1:10:length(tsol)
    plot(Vtht(1:i),VR(1:i),'LineWidth',1,'Color','blue')
    hold on
    scatter(Vtht(i),VR(i),15,'k','filled')
    xline(0,'k-','LineWidth',1)
    yline(0,'k-','LineWidth',1)
    % xline(R(i)*alpt_d,'r-','LineWidth',1)
    hold off
    title(['V_R vs V_\theta at t = ',num2str(tsol(i),'%.2f'),' s'],'FontSize',14,'FontName','Bookman Old Style')
%     xlim([-1,10])
%     ylim([-10,10])
    pause(0.001)
end
xlabel('V_\theta','FontSize',14,'FontName','Bookman Old Style')
ylabel('V_R','FontSize',14,'FontName','Bookman Old Style')
grid on
grid minor
%}

figure(2)
plot(Vtht,VR,'LineWidth',1,'Color','blue')
hold on
xline(0,'k-','LineWidth',1,'HandleVisibility','off')
yline(0,'k-','LineWidth',1,'HandleVisibility','off')
xlabel('V_\theta','FontSize',14,'FontName','Bookman Old Style')
ylabel('V_R','FontSize',14,'FontName','Bookman Old Style')
xlim([-Inf 1])
ylim([-Inf 1])
grid on
grid minor
title('Trajectory in V_\theta - V_R','FontSize',14,'FontName','Bookman Old Style')


figure(3)
plot(tsol,R,'LineWidth',1,'Color','red')
hold on
xlabel('t (in s)','FontSize',14,'FontName','Bookman Old Style')
ylabel('R (in m)','FontSize',14,'FontName','Bookman Old Style')
title('R vs t','FontSize',14,'FontName','Bookman Old Style')
grid on
grid minor

figure(4)
plot(tsol,VR,'LineWidth',1,'Color','red')
hold on
xlabel('t (in s)','FontSize',14,'FontName','Bookman Old Style')
ylabel('V_R (in m/s)','FontSize',14,'FontName','Bookman Old Style')
title('V_R vs t','FontSize',14,'FontName','Bookman Old Style')
grid on
grid minor

figure(5)
plot(tsol,Vtht,'LineWidth',1,'Color','red','DisplayName','V_tht')
hold on
% plot(tsol,R*alpt_d,'LineWidth',1,'Color','blue','DisplayName','R dot(alp_t)')
xlabel('t (in s)','FontSize',14,'FontName','Bookman Old Style')
ylabel('V_\theta (in m/s)','FontSize',14,'FontName','Bookman Old Style')
title('V_\theta vs t','FontSize',14,'FontName','Bookman Old Style')
grid on
grid minor
legend('Location','best','FontSize',12)

% if Xsol(:,4) < 0
%     alpp = 360 - rem(Xsol(:,4),2*pi);
% else
%     alpp = rem(Xsol(:,4),2*pi);
% end
% 
% if Xsol(:,10) < 0
%     tht = 360 - rem(Xsol(:,10),2*pi);
% else
%     tht = rem(Xsol(:,10),2*pi);
% end

Vp = Xsol(:,3);
alpp = Xsol(:,4);
% t1 = tht - alpp;
% ap = zeros(size(tsol));
% for i = 1:length(tsol)
%     if tsol(i) < 0.5
%         ap(i) = K*t1(i)*Vp(i);
%     else
%         ap(i) = (K*t1(i) + Vtht(i)/R(i))*Vp(i);
%     end
% end
ap = Vp.*alpp;

figure(6)
plot(tsol,ap,'LineWidth',1,'Color','red')
hold on
xlabel('t (in s)','FontSize',14,'FontName','Bookman Old Style')
ylabel('a_p (in m/s^2)','FontSize',14,'FontName','Bookman Old Style')
title('ap vs t','FontSize',14,'FontName','Bookman Old Style')
grid on
grid minor


figure(7)
plot(tsol,tht,'k','LineWidth',1)
hold on
yline(St_lb,'r')
yline(St_ub,'r')
yline(Sr_lb,'b')
yline(Sr_ub,'b')
ylim([min(tht)*10, max(tht)*10])
%}