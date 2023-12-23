close all; clear all; clc 

global C E_Na E_K E_Ca g_Na g_K g_Ca g_L_Na g_L_K vm_na 
global dvm_na vh_na dvh_na th0_na th1_na vht_na dvht_na vn_k dvn_k tn0_k
global tn1_k vnt_k dvnt_k vm_ca dvm_ca tm0_ca tm1_ca vmt_ca dvmt_ca vh_ca 
global dvh_ca th0_ca th1_ca vht_ca dvht_ca I_app tm0_na tau_Na1

% Model Paramters
C = 17.04; E_Na = 43.24; E_K = -100; E_Ca = 123.89; g_Na = 88.58;
g_K = 94.71; g_Ca = 5.13; g_L_Na = 0.44; g_L_K = 7.62; vm_na = -24.78;
dvm_na = 17.63; vh_na = -44.46; dvh_na = -12.89; th0_na = 0.47;
th1_na = 72.38; vht_na = -33.64; dvht_na = 17.09; vn_k = -6.51;
dvn_k = 11.08; tn0_k = 0.01; tn1_k = 16.59; vnt_k = -30.62;
dvnt_k = 31.03; vm_ca = -40; dvm_ca = 50;tm0_ca = 0.22;
tm1_ca = 3.11; vmt_ca = -36.62; dvmt_ca = 10.66; vh_ca = -17.72;
dvh_ca = -9.56; th0_ca = 284.73; th1_ca = 3000; vht_ca = -15.99;
dvht_ca = 6.99; I_app = 30; tm0_na = 0.1; tau_Na1 = 0.4;

% Computing the firing rate based for different values of I_app

I_App = [-30:5:30];
dt = 0.01;

options=odeset('RelTol',1e-6,'AbsTol',1e-6);
FiringRate = NaN(1,length(I_App));

for i=1:length(I_App)
    
    I_app = I_App(i);

    % Initial conditions
    IC= [-43.31779785 2.16E-09 0.270745454 0.503237436 0.983443176];
    
    % simulation to remove transient
    Tmax = 400;
    t = 0:dt:Tmax;
    [T,Y]= ode15s(@base_model,t,IC,options);
    
    % simulation to compute firing rate
    IC = Y(end,:);
    Tmax = 1500;
    t = 0:dt:Tmax;
    [T,Y]= ode15s(@base_model,t,IC,options);
    [pks,locs,widths,proms] = findpeaks(Y(:,1));
    
    if length(pks)==0
        FiringRate(i)=0;
    else
        isi = T(locs(end)) - T(locs(end-1));
        FiringRate(i) = 1000/isi;
    end
        
    if i==7
    
    % plot voltage trace with no applied current    
    figure(1)
    subplot(2,2,2)
    hold on 
    title('Figure 4B')
    plot(T,Y(:,1),'r','linewidth',3)
    xlim([0 1500])
    ylim([-45 20])
    xlabel('$t$ (ms)','interpreter','latex')
    ylabel('$V$ (mV)','interpreter','latex')
    set(gca,'FontSize',18) 

    % plot dV/dt versus V with no applied current 
    subplot(2,2,3)
    hold on 
    title('Figure 4C')
    plot(Y(:,1),gradient(Y(:,1))/dt,'r','linewidth',3)
    xlim([-45 20]);
    xlabel('$V$ (mV)','interpreter','latex')
    ylabel('$dv/dt$ (mV/ms)','interpreter','latex')
    set(gca,'FontSize',18) 
    
    end
    
end

% plot the firing rate
subplot(2,2,4)
hold on 
title('Figure 4D')
plot(I_App,FiringRate,'-or','linewidth',3)
xlabel('$I_{app}$ (pA)','interpreter','latex')
ylabel('Firing Rate (Hz)','interpreter','latex')
set(gca,'FontSize',18) 

