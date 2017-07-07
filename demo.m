% "REST: Reliable estimation and stopping time algorithm for social game experiments"
% ACM/IEEE ICCPS, 2015
% Author: Ming Jin

% Demo: determine how long to run an occupancy detection system in order to
% evaluate its detection accuracy. 
% Here we want to generate a graph to inform the decision

% The occupancy system estimate the number of people in the room based on
% sensing methods, such as CO2 [1], temperature [2], power usage [3], etc.
% More details about the experiment:
% 1. Medium size room, which can hold up to 25 people
% 2. Each occupancy sample is obtained at 15 minutes interval 
% 3a. (McDiarmid's method) the difference between our estimate and the 
%     true occupancy at any given time <= 10persons
% 3b. (Delta method) the standard deviation of the random variable 
%     i.e., (our estimated occupancy - true occupancy) to be normal with 
%     mean 0 and standard deviation 4.
% 4. The performance of our system is given by the mean absolute error:
%    1/n\sum_{i=1}^n abs(estimated_occupancy-true_occupancy)

% Some potential occupancy detection models:
% [1] Sensing by proxy: Occupancy detection based on indoor CO2 concentration
% [2] Occupancy detection via environmental sensing
% [3] Virtual occupancy sensing: Using smart meters to indicate your presence

%% Basic parameters
maxtime = 10000; % 10000/4/24 maximum days of evaluation
epsvec = 0.1:0.01:0.5; % the precision we are interested in
deltavec = 0.98:0.001:0.999; % the confidence we are interested in
err_bound = 10; % McDiarmid: bound on the occupancy system performance 
err_std = 4; % Delta: standard deviation of occupancy estimation error

%% McDiarmid's method
stopmat_mc = zeros(length(epsvec),length(deltavec)); % record the stopping time

for epsind = 1:length(epsvec)
    eps = epsvec(epsind);
    for deltaind = 1:length(deltavec)
        delta = deltavec(deltaind);
        [val_t,~] = REST_McDiarmid(eps,delta,err_bound,maxtime);
        stopmat_mc(epsind,deltaind) = val_t/(24*4); % unit is day
    end
end
imagesc(deltavec,epsvec,stopmat_mc); title('McDiarmid estimation')
colorbar;xlabel('delta: confidence');ylabel('eps: precision');

%% Delta method
stopmat_dt = zeros(length(epsvec),length(deltavec));
for epsind = 1:length(epsvec)
    eps = epsvec(epsind);
    for deltaind = 1:length(deltavec)
        delta = deltavec(deltaind);
        [val_t,~] = REST_Delta(eps,delta,err_std,maxtime);
        stopmat_dt(epsind,deltaind) = val_t/(24*4);
    end
end
imagesc(deltavec,epsvec,stopmat_dt); title('Delta estimation')
colorbar;xlabel('delta: confidence');ylabel('eps: precision');

%% Conclusion
% To achieve an error bound of our estimate of performance to be less than 
% 0.2 (fractional person) with probabily > 99% requires about 60 days, 
% according to both methods, i.e.,
% P(|our estiamted performance - true performance|<eps)>delta, for t>60days
% where eps = 0.2, delta = 0.99
