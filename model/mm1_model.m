k = 4;
k_vm = 4;

num_vnfs = 2;
p_sdn = 0.2;
init_prod_rate = 1/4;

prod_rate = init_prod_rate * (num_vnfs - 1);

srv_server = 10;
srv_tor = 10;
srv_agg = 10;
srv_core = 10;
srv_vm = 10;
srv_sdn = 10;

num_core = (k / 2)^2;
num_pods = k;
num_agg  = num_pods * (k/2);
num_edge = num_pods * (k/2);
num_servers = num_edge * (k/2);
num_vms = num_servers * k_vm; 

p_vm = 0;
p_server = (k_vm - 1) / (num_vms - 1);
p_tor = ((k/2) * k_vm - k_vm) / (num_vms - 1);
p_agg = ((k/2)^2 * k_vm - (k/2) * k_vm) / (num_vms - 1);
p_core = (num_vms - (k/2)^2 * k_vm) / (num_vms - 1);

arv_vm = ((num_vms - 1) / (num_vms - 1)) * prod_rate;
arv_server = k_vm * prod_rate ... 
           + (num_vms - k_vm) * (1 / (num_vms - 1)) * k_vm * prod_rate ...
           + k_vm * prod_rate * p_sdn;
arv_tor = ((k/2) * k_vm) * ((num_vms - (k_vm)) / (num_vms - 1)) * prod_rate ... 
        + (num_vms - ((k/2) * k_vm)) * (1 / (num_vms - 1)) * ((k / 2) * k_vm) * prod_rate;   
arv_agg = ((k/2)^2 * k_vm) * ((num_vms - (k_vm * (k/2))) / (num_vms - 1)) * prod_rate * (1/(k/2)) ...
        + (num_vms - ((k/2)^2 * k_vm)) * prod_rate * (((k/2)^2 * k_vm) / (num_vms - 1)) * (1/(k/2));
arv_core = p_core * num_vms * (1 / num_core) * prod_rate;
arv_sdn = num_vms * prod_rate * p_sdn;

proc_vm = MM1(arv_vm, srv_vm);
proc_server = MM1(arv_server, srv_server);
proc_tor = MM1(arv_tor, srv_tor);
proc_agg = MM1(arv_agg, srv_agg);
proc_core = MM1(arv_core, srv_core);
proc_sdn = MM1(arv_sdn, srv_sdn);

proc_sdn_waiting = (proc_sdn + proc_server) * p_sdn;

waiting_time = (proc_server + proc_sdn_waiting + proc_vm) * p_server ...
             + (proc_tor + 2 * proc_server + proc_sdn_waiting + proc_vm) * p_tor ...
             + (proc_agg + 2 * proc_tor + 2 * proc_server + proc_sdn_waiting + proc_vm) * p_agg ...
             + (proc_core + 2 * proc_agg + 2 * proc_tor + 2 * proc_server + proc_sdn_waiting + proc_vm) * p_core;

waiting_time = waiting_time * (num_vnfs - 1);

waiting_time

function time_in_system = MM1(arrival_rate, service_rate)
    time_in_system = 1 / (service_rate - arrival_rate);
end