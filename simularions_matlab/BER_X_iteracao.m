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
berVec = zeros(num, 1); % vetor para armazenar as taxas de BER

for t = 1:num  
      % Parâmetros da simulação
    SNR = 10; % em dB
    fc = 2.4e9; % frequência central em Hz
    fs = 20e6; % frequência de amostragem em Hz
    numBits = 1e6; % número de bits transmitidos
    
    % Criação do objeto de canal com perda de propagação causada por chuvas e cintilação
    rainChannel = comm.RicianChannel(...
        'SampleRate', fs, ...
        'KFactor', 50, ...
        'DirectPathDopplerShift', 0, ...
        'MaximumDopplerShift', 5, ...
        'PathDelays', [0 1.5e-5 3.5e-5], ...
        'AveragePathGains', [0 -2 -10], ...
        'NormalizePathGains', true, ...
        'DopplerSpectrum', doppler('Gaussian', 0.1));
    
    % Criação do objeto de canal AWGN
    awgnChannel = comm.AWGNChannel('NoiseMethod', 'Signal to noise ratio (SNR)', 'SNR', SNR);
    
    % Geração dos dados a serem transmitidos
    txData = randi([0 1], numBits, 1);
    
    bpsk_mod = comm.BPSKModulator();
    % Modulate the data using BPSK
    txSig = bpsk_mod(txData);
    
    % Transmissão do sinal pelo canal
    rxSig = rainChannel(awgnChannel(txSig));
    
    % Create a BPSK demodulator object
    bpsk_demod = comm.BPSKDemodulator();
    
    % Demodulate the received signal
    demod_sig = bpsk_demod(rxSig);
    
    % Extract the data from the demodulated signal
    rxData = de2bi(demod_sig, 'left-msb');
    
    % Cálculo do BER
    [err, ber] = biterr(txData, rxData);
    % fprintf('Bit Error Rate (BER) = %e (SNR = %d dB)\n', ber, SNR);
    
    berVec(t) = ber; % armazena o valor do BER no vetor berVec

end
figure;
plot(1:num, berVec);
xlabel('Iteração');
ylabel('Taxa de BER');
title('Taxa de BER x Iteração');
% resuls


%intvls;
%play(sc)
