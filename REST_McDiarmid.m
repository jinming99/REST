% "REST: Reliable estimation and stopping time algorithm for social game experiments"
% ACM/IEEE ICCPS, 2015
% Author: Ming Jin

function [stoptime,success] = REST_McDiarmid(eps,delta,err_bound,maxtime)
% REST McDiarmid method, see Equ. (19) in "REST"
% Here we assume the estimate function to be "average value"
% eps: precision, bound the difference between estimate and the "truth"
% delta: probability bound, 0<=delta<1, 1-delta is the probability of the
%        difference  between estimate and the "truth" greater than eps
% err_bound: bound on the error of estimate based on only one sample point
% maxtime: maximum time when the experiment must stop

stoptime = maxtime;
success = 0;
for m = 1:maxtime
    cj = 1/m*err_bound;
    cub = cj^2*m;
    val_t = exp(-2*eps^2/cub)-(1-delta)/2;
    if val_t<=0
        stoptime = m;
        success = 1;
        break
    end
end
end