function y = IA_model(t,x)

global C E_Na E_K E_Ca g_Na g_K g_Ca g_L_Na g_L_K vm_na g_A
global vm_A dvm_A vh_A dvh_A tau_h0_A SF_gA SF_tau_h_A
global dvm_na vh_na dvh_na th0_na th1_na vht_na dvht_na vn_k dvn_k tn0_k
global tn1_k vnt_k dvnt_k vm_ca dvm_ca tm0_ca tm1_ca vmt_ca dvmt_ca vh_ca 
global dvh_ca th0_ca th1_ca vht_ca dvht_ca vht_A dvht_A tau_h1_A I_app


m_Na_inf = @(v) 0.5 + 0.5*tanh((v - vm_na)/dvm_na);
m_Ca_inf = @(v) 0.5 + 0.5*tanh((v - vm_ca)/dvm_ca);
m_A_inf = @(v) 0.5 + 0.5*tanh((v - vm_A)/dvm_A);

h_Na_inf = @(v) 0.5 + 0.5*tanh((v - vh_na)/dvh_na);
h_Ca_inf = @(v) 0.5 + 0.5*tanh((v - vh_ca)/dvh_ca);
h_A_inf = @(v) 0.5 + 0.5*tanh((v - vh_A)/dvh_A);
n_inf = @(v) 0.5 + 0.5*tanh((v - vn_k)/dvn_k);

tau_m_Ca = @(v) tm0_ca + tm1_ca*(1 - tanh((v-vmt_ca)/dvmt_ca)^2);

tau_h_Na = @(v) th0_na + th1_na*(1 - tanh((v-vht_na)/dvht_na)^2);
tau_h_Ca = @(v) th0_ca + th1_ca*(1 - tanh((v-vht_ca)/dvht_ca)^2);
tau_h_A = @(v) tau_h0_A + tau_h1_A*(1 - tanh((v-vht_A)/dvht_A)^2);

tau_n = @(v) tn0_k + tn1_k*(1 - tanh((v-vnt_k)/dvnt_k)^2);

v= x(1); m_Ca=x(2); n=x(3);  % First initial condition
h_Na=x(4); h_Ca=x(5); h_A = x(6);

% t1=1066; t2=2066;
t1=1500; t2=2500;
Amp=-30;

if t>t1 && t< t2
    y(1)=((I_app+Amp)-g_Na*m_Na_inf(v)^3*h_Na*(v - E_Na) - g_K*n^4*(v-E_K) - g_Ca*m_Ca*h_Ca*(v-E_Ca) - ...
        g_L_Na*(v-E_Na)-g_L_K*(v-E_K) - SF_gA*g_A*m_A_inf(v)^3*h_A*(v-E_K))/C;
else
    y(1)=(I_app-g_Na*m_Na_inf(v)^3*h_Na*(v - E_Na) - g_K*n^4*(v-E_K) - g_Ca*m_Ca*h_Ca*(v-E_Ca) - ...
        g_L_Na*(v-E_Na)-g_L_K*(v-E_K) - SF_gA*g_A*m_A_inf(v)^3*h_A*(v-E_K))/C;
end

y(2)=(m_Ca_inf(v) - m_Ca)/tau_m_Ca(v);
y(3)=(n_inf(v) - n)/tau_n(v);
y(4)=(h_Na_inf(v) - h_Na)/tau_h_Na(v);
y(5)=(h_Ca_inf(v) - h_Ca)/tau_h_Ca(v);
y(6)=(h_A_inf(v) - h_A)/(SF_tau_h_A*tau_h_A(v));




y= y';
end

