function y = quant(x, nb, out)
% QUANT Quantize a sampled (discrete) signal using a prescribed number of
%       bits per point.
% Usage:
%  y = quant(x,nb,out)
% where y = digital signal quantized to 2^(nb) bits resolution
%       x = vertical points of sampled signal
%       nb = number of bits to use per point
%      out = 'raw' means output binary values: 0,...,2^(nb-1)
%      otherwise, set ouput value range = input value range

if (nargin == 3) && strcmp(out, 'raw')
   y=round((x-min(x))/(max(x)-min(x))*(2^nb-1));
else
   y=round((x-min(x))/(max(x)-min(x))*(2^nb-1))*((max(x)-min(x))/(2^nb-1))+min(x);
end
