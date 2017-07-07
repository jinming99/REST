# REST: Reliable estimation and stopping time algorithm

Experiment can be expensive. That’s why we need to determine the duration of the experiment ahead of time. This is MATLAB implementation of the reliable estimation and stopping time (REST) algorithm. Given the precision and confidence requirements, it produces a statistically guaranteed stopping time, so it is easier to manage resources and project budget.

Feel free to use it! Please contact [Ming Jin](http://www.jinming.tech/) for any enquiries.


## Demo: Occupancy detection system evaluation

#### Background

Purpose: determine how long to run an occupancy detection system in order to evaluate its detection accuracy. 
Background: The occupancy system estimate the number of people in the room based on sensing methods, such as CO2, temperature, power usage, etc.

More details about the experiment:
* Medium size room, which can hold up to 25 people
* Each occupancy sample is obtained at 15 minutes interval 
* (McDiarmid's method) the difference between our estimate and the true occupancy at any given time <= 10persons
* (Delta method) the standard deviation of the random variable i.e., (our estimated occupancy - true occupancy) to be normal with  mean 0 and standard deviation 4.
* The performance of our system is given by the mean absolute error: 1/n\sum_{i=1}^n abs(estimated_occupancy-true_occupancy)

#### Conclusion
To achieve an error bound of our estimate of performance to be less than 0.2 (fractional person) with probabily > 99% requires about 60 days, according to both methods, i.e., 

P(|our estiamted performance - true performance|<eps)>delta, for t>60days,

where eps = 0.2, delta = 0.99


## Reference

Ming Jin, Lillian Ratliff, Ioannis Konstantakopoulos, Costas Spanos, and Shankar Sastry, 
"Reliable estimation and stopping time algorithm for social game experiments", ACM/IEEE ICCPS (2015) ([paper](http://www.jinming.tech/papers/rest.pdf))