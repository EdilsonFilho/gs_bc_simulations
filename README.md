
# Simulations do  Decentralized Ground Stations with Blockchain

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
Some of the simulation results are:

<p align="center">
  <img src="/images/simulation-matlab-2gs.png" width="500">
</p>

### BER - Bit Error Rate


<p align="center">
  <img src="/images/BERxOverpass.png" width="500">
</p>


Author: MS.c Jose Edilson Silva Filho
Email: edilsonfilho@lesc.ufc.br



