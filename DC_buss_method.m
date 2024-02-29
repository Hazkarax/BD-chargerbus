% According to Chalmers Researcher David Steen, DC-chargers are most likely
% to have a big breakthrough, as they do not require additional electronics
% onboard the EVs, which means they are more likely to be wider supported.
% This means its more relevent drawing the power straight to the battery,
% rather than converting it to AC and supplying the driveline.

% The code as it is assumes the power_per_car is after the DC/DC conversion
% in the charger.

clc
clear variables

power_per_car = 20*10^3;
cars_per_bus = 10;
busses = 3;
U_buss = 400;

buss_power = power_per_car * cars_per_bus;

eta_dc_dc = 0.98; % Efficiency of the chargers DC/DC converter
eta_dc_dc_bat = 0.95; % Efficiency of the DC/DC converter between the bus and battery charger
parking_lot_length = 5; % Length of parking lot, usually 5 m



rho_copper = 1.724*10^-8; %[Ohm meter]
cable_length = parking_lot_length*cars_per_bus + 15;
cable_crosssection = 243*10^-6; % [mm^2 to m^2 conversion]

R_cable = cable_length*rho_copper/cable_crosssection;

P_bussloss = (buss_power/U_buss)^2*R_cable;
P_buss = buss_power - P_bussloss;

Power_output = busses*P_buss*eta_dc_dc_bat;

disp(['Power Input: ', num2str(buss_power*busses/10^3), ' [kWh], # of DC-Busses: ', num2str(busses)])
disp(['Power Output: ', num2str(Power_output/10^3), ' [kWh], Efficiency: ', num2str(Power_output/(busses*buss_power)*100), ' %'])

