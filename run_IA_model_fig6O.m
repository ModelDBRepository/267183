close all; clear all; clc 

global C E_Na E_K E_Ca g_Na g_K g_Ca g_L_Na g_L_K vm_na E_H g_H g_A SF_gA SF_tau_h_A
global vm_H dvm_H tm0_H tm1_H vmt_H dvmt_H vm_A dvm_A vh_A dvh_A tau_h0_A
global dvm_na vh_na dvh_na th0_na th1_na vht_na dvht_na vn_k dvn_k tn0_k
global tn1_k vnt_k dvnt_k vm_ca dvm_ca tm0_ca tm1_ca vmt_ca dvmt_ca vh_ca 
global dvh_ca th0_ca th1_ca vht_ca dvht_ca vht_A dvht_A tau_h1_A I_app

% read in parameter values
filename = 'parameter_table_rhabdomys_10_28_21.xlsx';
PARAM = xlsread(filename);

% extract parameters for Figure 6 model
column = 13; 

PARAM(end-1,column) = -61.68;
PARAM(end-15,column) = 0;
PARAM(end-21,column) = -40;
PARAM(end-27,column) = -48.23;
PARAM(end-33,column) = -58.18;

C = PARAM(1,column); E_Na = PARAM(2,column); E_K = PARAM(3,column); 
E_Ca = PARAM(4,column); E_H = PARAM(5,column); g_Na = PARAM(6,column); 
g_K = PARAM(7,column); g_Ca = PARAM(8,column); g_H= PARAM(9,column); 
g_A= PARAM(10,column); g_L_Na = PARAM(11,column); g_L_K = PARAM(12,column); 
vm_na = PARAM(13,column); dvm_na = PARAM(14,column); vh_na = PARAM(15,column); 
dvh_na = PARAM(16,column);th0_na = PARAM(17,column); th1_na = PARAM(18,column);
vht_na = PARAM(19,column); dvht_na = PARAM(20,column); vn_k = PARAM(21,column);
dvn_k = PARAM(22,column); tn0_k = PARAM(23,column); tn1_k = PARAM(24,column); 
vnt_k = PARAM(25,column); dvnt_k = PARAM(26,column); vm_ca = PARAM(27,column); 
dvm_ca = PARAM(28,column); tm0_ca = PARAM(29,column); tm1_ca = PARAM(30,column);
vmt_ca = PARAM(31,column); dvmt_ca = PARAM(32,column); vh_ca = PARAM(33,column);
dvh_ca = PARAM(34,column);th0_ca = PARAM(35,column); th1_ca = PARAM(36,column); 
vht_ca = PARAM(37,column); dvht_ca = PARAM(38,column); vm_H = PARAM(39,column); 
dvm_H = PARAM(40,column); tm0_H = PARAM(41,column); tm1_H = PARAM(42,column); 
vmt_H = PARAM(43,column); dvmt_H = PARAM(44,column); vm_A = PARAM(45,column); 
dvm_A = PARAM(46,column); vh_A = PARAM(47,column); dvh_A = PARAM(48,column);
tau_h0_A = PARAM(49,column); tau_h1_A = PARAM(50,column); vht_A = PARAM(51,column);
dvht_A = PARAM(52,column); I_app = 0;

% set gA scaling factors
SF_GA = [1 0.7 0];

for kk = 1:length(SF_GA)
    
    SF_gA = SF_GA(kk);
    SF_tau_h_A = 1;

    Tmax = 4000;
    dt = 0.1;
    t = 0:dt:Tmax;
    
    % Initial Condition
    IC = [-48.732534 0.023981244 0.658252937 0.425385629 0.931883062 0.055093231];
    options=odeset('RelTol',1e-6,'AbsTol',1e-6);
    [T,Y]= ode45(@IA_model,t,IC,options);
    
    % plot the voltage traces 
    f=figure(1)
    subplot(3,1,kk)
    hold on 
    plot(T,Y(:,1),'r','linewidth',3)
    xlim([500 Tmax]);
    ylabel('$V$ (mV)','interpreter','latex')
    set(gca,'FontSize',18) 

end

subplot(3,1,1)
title('Figure 6Oi')

subplot(3,1,2)
title('Figure 6Oii')

subplot(3,1,3)
title('Figure 6Oiii')
xlabel('$t$ (ms)','interpreter','latex')

f.Position = [100 100 560 880];






