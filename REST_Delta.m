% "REST: Reliable estimation and stopping time algorithm for social game experiments"
% ACM/IEEE ICCPS, 2015
% Author: Ming Jin

function [stoptime,success] = REST_Delta(eps,delta,err_std,maxtime)
% REST Delta method, see Equ. (21) in "REST"
% Here we assume the estimate function to be "average value"
% eps: precision, bound the difference between estimate and the "truth"
% delta: probability bound, 0<=delta<1, 1-delta is the probability of the
%        difference  between estimate and the "truth" greater than eps
% err_std: std of the estimate error for each sample
% maxtime: maximum time when the experiment must stop
stoptime = maxtime;
success = 0;

for m = 1:maxtime
    p = normcdf(eps,0,err_std/sqrt(m));
    val_t = p-0.5-delta/2;
    if val_t>=0
        stoptime = m;
        success = 1;
        break
    end
end

end
