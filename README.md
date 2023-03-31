
# Simulations do  Decentralized Ground Stations with Blockchain
Author: MS.c Jose Edilson Silva Filho
Email: edilsonfilho@lesc.ufc.br

Note: This repository collects some code that I created. It does not have details of the blockchain usage nor the simulation with all the subsystems, because this code is restricted. The intent of the current repository is to show academically some simulations to colleagues. 

### GS-BC
Our proposal with this project is to provide mission control with greater communication capacity with its satellites through a decentralized infrastructure
of ground stations. We thus provide an environment in which each ground station participating in the consortium communicates with the satellites in the 
network.A consortium is a group of institutions and/or ground stations that own a node running the blockchain. 
In this activity, we promote a firmware update routine, where the satellite is a client of the blockchain that runs on the ground station servers. 

## GS-BC development arquiteture


<p align="center">
  <img src="/images/consorcio_gs.jpeg" width="500">
</p>

## Mission and Simulations

Using the resources of Matlab 2 we create a space mission composed of a nanosatellite that we call SACODE BR-1 and two ground stations, being one called
UFC-PICI with longitude and latitude of the university campus of the Federal University of Ceará at the PICI 3 campus. The objective was to estimate the average communication time between the nanosatellite
and the ground station at this location point and thus use it as a basis for the other experiments. We chose a mission time of 90 days to collect a list of communication windows between the
communication windows between the nanosatellite and the ground station. o Source code 1 Matlab simulation
nanosatellite mission presents an example of how to create a space mission using
space mission using Matlab resources. The orbit chosen was the LEO orbit. 

```
startTime = datetime(2022,5,1,5,36,0);
stopTime = startTime + days(90);
sampleTime = 60;

% configuration orbit
semiMajorAxis = 7155000;
eccentricity = 0.0001030;
inclination = 98.5; 
rightAscensionOfAscendingNode = 161.5; 
argumentOfPeriapsis = 0; 
trueAnomaly = 263.19; 

%configuration GS
lat = -3.7484767;
lon = -38.5788343;
```

 ```
 rainChannel = comm.RicianChannel(...
        'SampleRate', fs, ...
        'KFactor', 50, ...
        'DirectPathDopplerShift', 0, ...
        'MaximumDopplerShift', 5, ...
        'PathDelays', [0 1.5e-5 3.5e-5], ...
        'AveragePathGains', [0 -2 -10], ...
        'NormalizePathGains', true, ...
        'DopplerSpectrum', doppler('Gaussian', 0.1));
 ```
 
 This code snippet creates a rainChannel object of the comm.RicianChannel class to model the communication channel that the signal of interest passes through. The comm.RicianChannel function is used to create a communication channel that simulates the conditions of propagation of the signal of interest over a wireless medium.

The input parameters specified for creating the rainChannel object are:

- SampleRate: specifies the sampling rate in Hz;
- KFactor: specifies the ratio between the direct signal energy and the scattered signal energy. This parameter is used to model the relationship between the direct signal and the reflected or scattered signals in the propagation environment;
DirectPathDopplerShift: specifies the Doppler frequency shift in the direct signal. This is used to model the Doppler effect caused by motion of the transmitter, receiver, or both;
- MaximumDopplerShift: specifies the maximum Doppler frequency shift in the scattered signal. This is used to model the Doppler effect caused by relative motion between the transmitter, receiver, or both;
- PathDelays: specifies a vector of propagation delays in seconds for the different propagation paths of the signal. Each value in the vector corresponds to a different path;
- AveragePathGains: specifies a vector of average path gains (in dB) for the different signal propagation paths. Each value in the vector corresponds to a different path;
- NormalizePathGains: specifies whether the average path gains should be normalized so that the direct path has an average path gain of 0 dB;
- DopplerSpectrum: specifies the Doppler spectrum model used to model the frequency fluctuations caused by signal propagation through the communication channel. In this case the model is "Gaussian" with a bandwidth of 0.1 Hz.
Some of the simulation results are:

### Image Simulation

<p align="center">
  <img src="/images/simulation-matlab-2gs.png" width="700">
</p>


### Overpass or Interations
Each communication window between the satellite and the ground station, in the code and in the graph were called interactions. 

<p align="center">
  <img src="/images/interations.png" width="700">
</p>

### BER - Bit Error Rate
The Y-axis of the graph represents the bit error rate (BER) on a linear scale. In other words, it represents the percentage of bits received incorrectly in relation to the total number of bits transmitted. For example, if the bit error rate is 0.01, this means that 1% of the transmitted bits were received incorrectly. The scale is linear because it is a direct representation of the bit error rate.
If the value on the y-axis is 0.5, this means that half of the transmitted bits were received correctly and the other half were received incorrectly. In other words, the bit error rate (BER) is 0.5, which means that there are too many errors in the transmission and the quality of the channel is very poor. The scale used on the y-axis is from 0 to 1, representing the percentage of bits received correctly, i.e., a scale from 0 to 100%. What does this graph mean? It simply shows us in which iterations, or in which overpass, the errors were greater. Investigating why this happened is another step. 

<p align="center">
  <img src="/images/BerxOverpass.png" width="700">
</p>




References for the codes:
```
[1] https://www.mathworks.com/help/comm/ref/rfprop.rain.html
[2] https://www.mathworks.com/help/aerotbx/ug/matlabshared.satellitescenario.satellite.html
[3] https://www.mathworks.com/help/aerotbx/ug/model-visualize-and-analyze-satellite-scenario.html
[4] https://www.mathworks.com/help/aerotbx/ug/satellite-constellation-access-to-a-ground-station.html
[5] https://www.mathworks.com/help/aerotbx/satellite-scenario.html?s_tid=CRUX_lftnav
```


