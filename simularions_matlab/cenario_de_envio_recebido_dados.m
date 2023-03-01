startTime = datetime(2022,5,1,5,36,0);
stopTime = startTime + days(90);
sampleTime = 60;
sc = satelliteScenario(startTime,stopTime,sampleTime);
% Initialize a vector to store the received data
% Set the duration of the simulation to 90 days
duration = 90*24*60; % Duration of the simulation in minutes

% configuration orbit
semiMajorAxis = 7155000;
eccentricity = 0.0001030;
inclination = 98.5; 
rightAscensionOfAscendingNode = 161.5; 
argumentOfPeriapsis = 0; 
trueAnomaly = 263.19; 

%configuration nanosatellite

sat = satellite(sc,semiMajorAxis,eccentricity,inclination, ...
        rightAscensionOfAscendingNode,argumentOfPeriapsis,trueAnomaly,"Name","SACODE BR-1");

%configuration GS
lat = -3.7484767;
lon = -38.5788343;
gs = groundStation(sc,lat,lon,"Name","UFC-PICI");

% Define the parameters of the satellite link
frequency = 2.4e9; % Operating frequency in Hz
bandwidth = 20e6; % Bandwidth in Hz

received_data = [];
erro_rate_vector = [];

ac = access(sat,gs)
intvls = accessIntervals(ac);

% Loop through the duration of the simulation

num = size(intvls,1);
num;

for t = 1:num


    % Generate random data to be transmitted
    data = randi([0 1], 10, 1);
    % Create a BPSK modulator object
    bpsk_mod = comm.BPSKModulator();
    % Modulate the data using BPSK
    mod_sig = bpsk_mod(data);
    % Create an additive white Gaussian noise (AWGN) channel object
    channel = comm.AWGNChannel(...
        'NoiseMethod', 'Signal to noise ratio (SNR)', ...
       'SNR', 10); % Set the SNR to 10 dB
    % Transmit the signal from the ground station to the satellite
    tx_signal = mod_sig; % Transmit signal from the ground station
    rx_signal = channel(tx_signal); % Signal received at the satellite
    
    % Create a BPSK demodulator object
    bpsk_demod = comm.BPSKDemodulator();
    
    % Demodulate the received signal
    demod_sig = bpsk_demod(rx_signal);
    
    % Extract the data from the demodulated signal
    demod_data = de2bi(demod_sig, 'left-msb');
    
    
    % Calculate the error rate
    error_rate = sum(data ~= demod_data)/length(data);

    % Check if the satellite has contact with the ground station

    % The satellite has contact with the ground station
    % Demodulate the received signal at the satellite
    %demod_data = qpskdemod(rx_signal);
    % Store the received data
    received_data = [rx_signal; demod_data];

end

% resuls


%intvls;
%play(sc)
