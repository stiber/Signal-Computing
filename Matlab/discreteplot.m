function discreteplot(x)
% DISCRETEPLOT Plot a discrete/digital signal
% Usage:
%   discreteplot(x)
% where:
%   x = discrete or digital signal
%
% This function produces a 1D line plot of the provided descrete or digital
% signal in a "stairstep" fashion. In other words, each value in x (which
% is a y coordinate of the plotted point (n, x)) is connected by a straight
% line to the same y value at the next sample number (n+1, x), and then by
% a vertical line to the next sample value, (n+1, x+1).

px = zeros(1, 2*length(x)-1);
px(1:2:end) = x;
px(2:2:end) = x(1:end-1);
plot(px)

end
