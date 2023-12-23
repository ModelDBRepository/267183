function y = base_model(t,x)

global C E_Na E_K E_Ca g_Na g_K g_Ca g_L_Na g_L_K vm_na 
global dvm_na vh_na dvh_na th0_na th1_na vht_na dvht_na vn_k dvn_k tn0_k
global tn1_k vnt_k dvnt_k vm_ca dvm_ca tm0_ca tm1_ca vmt_ca dvmt_ca vh_ca 
global dvh_ca th0_ca th1_ca vht_ca dvht_ca I_app 

m_Na_inf = @(v) 0.5 + 0.5*tanh((v - vm_na)/dvm_na);
m_Ca_inf = @(v) 0.5 + 0.5*tanh((v - vm_ca)/dvm_ca);
h_Na_inf = @(v) 0.5 + 0.5*tanh((v - vh_na)/dvh_na);
h_Ca_inf = @(v) 0.5 + 0.5*tanh((v - vh_ca)/dvh_ca);
n_inf = @(v) 0.5 + 0.5*tanh((v - vn_k)/dvn_k);

tau_m_Ca = @(v) tm0_ca + tm1_ca*(1 - tanh((v-vmt_ca)/dvmt_ca)^2);
tau_h_Na = @(v) th0_na + th1_na*(1 - tanh((v-vht_na)/dvht_na)^2);
tau_h_Ca = @(v) th0_ca + th1_ca*(1 - tanh((v-vht_ca)/dvht_ca)^2);
tau_n = @(v) tn0_k + tn1_k*(1 - tanh((v-vnt_k)/dvnt_k)^2);

v = x(1); 
m_Ca=x(2); 
n=x(3); 
h_Na=x(4); 
h_Ca=x(5);

y(1)=(I_app-g_Na*m_Na_inf(v)^3*h_Na*(v - E_Na) - g_K*n^4*(v-E_K) - g_Ca*m_Ca*h_Ca*(v-E_Ca) - g_L_Na*(v-E_Na) - g_L_K*(v-E_K)) / C;
y(2)=(m_Ca_inf(v) - m_Ca)/tau_m_Ca(v);
y(3)=(n_inf(v) - n)/tau_n(v);
y(4)=(h_Na_inf(v) - h_Na)/tau_h_Na(v);
y(5)=(h_Ca_inf(v) - h_Ca)/tau_h_Ca(v);

y= y';

end

