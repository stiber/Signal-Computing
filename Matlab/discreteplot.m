function discreteplot(y)
% DISCRETEPLOT Plot a discrete/digital signal
% Usage:
%   discreteplot(x)
% where:
%   x = discrete or digital signal
%
% This function produces a 1D line plot of the provided discrete or digital
% signal in a "stairstep" fashion. In other words, each value in x (which
% is a y coordinate of the plotted point (n, x)) is connected by a straight
% line to the same y value at the next sample number (n+1, x), and then by
% a vertical line to the next sample value, (n+1, x+1).

py = zeros(1, 2*length(y)-1);
py(1:2:end) = y;
py(2:2:end) = y(1:end-1);
px = zeros(size(py));
px(1) = 1;
px(2:2:end) = [2:length(y)];   % Arriving at a "new" point; increment x
px(3:2:end) = [2:length(y)]; % Repeated point; don't increment (vertical)
plot(px, py)
set(gca, 'Xlim', [1 length(y)])
end
