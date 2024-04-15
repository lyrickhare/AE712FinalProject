% Define arrays for x-axis and y-axis
payload_values = linspace(1, 20, 20); % Example payload values
% disk_loading_values = linspace(100, 300, 20); % Example disk loading values
% rho_energy_density_values = linspace(700000, 900000, 20); % Example energy density values

% Preallocate arrays to store the results
mGTOWConv_results = zeros(size(payload_values));
mBatt_results = zeros(size(payload_values));
mRotor_results = zeros(size(payload_values));
mMotor_results = zeros(size(payload_values));
mAirFrame_results = zeros(size(payload_values));
mPayload_results = zeros(size(payload_values));
R_results = zeros(size(payload_values));
% Generate data using for loops
for i = 1:length(payload_values)
    % Generate data using the provided function
    [mGTOWConv,mBatt,mRotor,mMotor,mAirFrame,eClimb,eCruise,eHover,R] = genForPlot(payload_values(i),250*3600,250,4,10,1000,2.5,1);
    
    % Store the results
    mGTOWConv_results(i) = mGTOWConv;
    mBatt_results(i) = mBatt;
    mRotor_results(i) = mRotor;
    mMotor_results(i) = mMotor;
    mAirFrame_results(i) = mAirFrame;
    mPayload_results(i) = i;
    R_results(i) = R;
end














% Plot 1: mPayload vs mGTOWConv, mBatt, mRotor, mMotor, mAirFrame
figure;
plot(payload_values, mGTOWConv_results, 'r.-', 'DisplayName', 'mGTOWConv');
hold on;
plot(payload_values, mBatt_results, 'b.-', 'DisplayName', 'mBatt');
plot(payload_values, mRotor_results, 'g.-', 'DisplayName', 'mRotor');
plot(payload_values, mMotor_results, 'c.-', 'DisplayName', 'mMotor');
plot(payload_values, mAirFrame_results, 'm.-', 'DisplayName', 'mAirFrame');
plot(payload_values, mPayload_results, 'y.-', 'DisplayName', 'mPayload');

xlabel('Payload (kg)');
ylabel('M-GTOW (kg)');
title('M-GTOW vs Payload');
grid("on");
legend('show');

% % Plot 2: diskLoading vs rhoEnergyDensity vs MGTOW
% figure;
% plot3(disk_loading_values, rho_energy_density_values, mGTOWConv_results, 'r.-');
% xlabel('Disk Loading (N/m^2)');
% ylabel('Energy Density (J/kg)');
% zlabel('MGTOW (kg)');
% title('MGTOW vs Disk Loading and Energy Density');
