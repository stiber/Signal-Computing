classdef AnalogSignal
    %AnalogSignal Analog signal container for Signal Computing labs
    %   This class defines an "analog signal" for use in labs associated
    %   with _Signal Computing: Digital Signals in the Software Domain_ by
    %   Stiber et al. This software is licensed is licensed under a
    %   Creative Commons Attribution-ShareAlike 4.0 International License.
    %   Please see
    %   <http://faculty.washington.edu/stiber/pubs/Signal-Computing/> for
    %   licensing details.
    %
    %   Obviously, Matlab can't actually represent a true analog signal.
    %   So, we fake it by encapsulating the nasty bits. Since the purpose
    %   of this class is to support the abovementioned text, it only has to
    %   provide limited capabilities: AnalogSignals can be created, added,
    %   plotted, and sampled. That's it! Don't look behind the curtain!
    
    properties (Access = public)
        duration    % in seconds
    end
    
    properties (Access = private)
        timeBase    % Vector of time values (in seconds)
        signal      % Vector of signal values
        
        % Future expansion idea:
        % Structure array with elements type, amplit, freq. Experimental;
        % eventually, may move implementation to only compute analog signal
        % values when asked for, rather than storing an array of values to
        % fake a signal.
%         description
%         numDescriptions % If multiple signals summed together
    end
    
    properties (Constant, Access = private)
        analogTimeStep = 1/100000; % All analog signals are actually
                                   % sampled at this time step (seconds)
        maxFreq = 10000;           % No analog frequencies allowed over
                                   % this frequency, to maintain the
                                   % illusion (Hz)
        legalTypes = {'sine'; 'cosine'; 'square'; 'sawtooth'; 'triangle'};
    end
    
    methods (Access = public)

        function obj = AnalogSignal(type, amplitude, frequency, dur)
        % ANALOGSIGNAL Constructor
        %   AnalogSignal(type, amplitude, frequency, dur)
        %   Where:
        %   type = 'sine', 'cosine', 'square', 'sawtooth', or 'triangle'
        %   amplitude = signal amplitude
        %   frequency = signal frequency
        %   dur = signal duration
            if nargin < 4     % duration not provided
                obj.duration = 1; % default is 1s
            else
                obj.duration = dur;
            end
            if nargin < 3   % frequency not provided
                f = 1;      % default is 1Hz
            else
                f = frequency;
            end
            if nargin < 2   % amplitude not provided
                amp = 1;
            else
                amp = amplitude;
            end
            if nargin == 0   % type not provided
                sigType = 'sine';
            else
                if any(strcmp(type, AnalogSignal.legalTypes)) % Test for legal signal
                    sigType = type;
                else
                    error('Illegal signal type: %s', type);
                end
            end
            if f > AnalogSignal.maxFreq
                error('Maximum analog frequency, %d, exceeded', obj.maxFreq);
            end
%             obj.description.type = sigType;
%             obj.description.amplit = amp;
%             obj.description.freq = f;
%             obj.numDescriptions = 1;
            
            % Compute time base and signal values
            obj.timeBase = [0: AnalogSignal.analogTimeStep: obj.duration];
            switch sigType
                case 'sine'
                    obj.signal = amp * sin(2*pi*f*obj.timeBase);
                case 'cosine'
                    obj.signal = amp * cos(2*pi*f*obj.timeBase);
                case 'square'
                    obj.signal = amp * AnalogSignal.square(f, [obj.timeBase]);
                case 'triangle'
                    obj.signal = amp * AnalogSignal.triangle(f, obj.timeBase);
                case 'sawtooth'
                    obj.signal = amp * AnalogSignal.sawtooth(f, obj.timeBase);
            end
        end
    
        % Operations on analog signals
        function oSig = plus(iSig1, iSig2)
            % PLUS operator to add two analog signals
            %   C = A + B
                        
            if ~isa(iSig1, 'AnalogSignal') || ~isa(iSig2, 'AnalogSignal')
                error('Both inputs to sum must be AnalogSignals')
            end
            oSig = iSig1;
            
            % If inputs are not of same length, pad shorter with zeros
            if iSig2.duration > oSig.duration
                oSig.timeBase = iSig2.timeBase;
                oSig.signal = [oSig.signal, zeros(1, ...
                    length(iSig2.signal) - length(oSig.signal))];
            end
            oSig.signal(1 : length(iSig2.signal)) = ...
                oSig.signal(1 : length(iSig2.signal)) + iSig2.signal;
        end
        
        function oSig = minus(iSig1, iSig2)
            % MINUS operator to subtract two analog signals
            %   C = A - B
                        
            if ~isa(iSig1, 'AnalogSignal') || ~isa(iSig2, 'AnalogSignal')
                error('Both inputs to difference must be AnalogSignals')
            end
            oSig = iSig1;
            
            % If inputs are not of same length, pad shorter with zeros
            if iSig2.duration > oSig.duration
                oSig.timeBase = iSig2.timeBase;
                oSig.signal = [oSig.signal, zeros(1, ...
                    length(iSig2.signal) - length(oSig.signal))];
            end
            oSig.signal(1 : length(iSig2.signal)) = ...
                oSig.signal(1 : length(iSig2.signal)) - iSig2.signal;
        end     
        
        function oSig = mtimes(iSig, n)
            % MTIMES operator to multiply analog signal by a scalar
            %   B = A * N
            
            if ~isscalar(n)
                error('Second input to mtimes must be a scalar')
            end
            if ~isa(iSig, 'AnalogSignal')
                error('First input to mtimes must be an AnalogSignal')
            end
            oSig = iSig;
            oSig.signal = [oSig.signal] * n;
        end
        
        function plot(sig, varargin)
            % PLOT Overloaded plot operation for analog signals
            %   PLOT(A)
            
            plot(sig.timeBase, sig.signal, varargin{:})
        end
        
        function oSig = samplehold(iSig, h)
            % SAMPLEHOLD Perform a sample and hold function on an AnalogSignal
            % Usage:
            %  [t,y] = obj.samplehold(h)
            % where  aSig = AnalogSignal
            %        h = hold time in sec
            
            % Make sure we're working with an AnalogSignal
            if ~isa(iSig, 'AnalogSignal')
                error('First input to samplehold must be an AnalogSignal')
            end
            
            oSig = iSig;
            nn = length(iSig.timeBase);
            T = iSig.timeBase(nn);
            % Create sample values by interpolating input values at the
            % sample times.
            t_sample = [0:h:T];
            y_sample = interp1(oSig.timeBase, oSig.signal, ...
                t_sample, 'linear');
            mm = length(t_sample);
            curOutputNum = 1;
            for m = 1:mm-1     % For each sample value
                % Figure out which values in the output signal should be
                % set to the current sampled value
                outputIndices = find(oSig.timeBase(curOutputNum:end) < t_sample(m+1));
                outputIndices = outputIndices + curOutputNum - 1;
                oSig.signal(outputIndices) = y_sample(m);
                curOutputNum = outputIndices(end) + 1;
            end
            % If the final sample in the sampled signal does not extend beyond
            % the end of the output signal, then set those values in the output
            % signal
            outputIndices = find(oSig.timeBase(curOutputNum:end) <= t_sample(end));
            if ~isempty(outputIndices)
                outputIndices = outputIndices + curOutputNum - 1;
                oSig.signal(outputIndices) = y_sample(m);
            end
        end
    end

    % Private utilities
    methods (Static, Access = private)

        function y = square(f, t)
            % SQUARE Generate a square wave with values in range [0, 1]
            %   Y = SQUARE(F, T)
            %   Where:
            %   F = number of positive/negative waves per second
            %   T = array of times
            [nrows, ncols] = size(t);
            m = max([nrows ncols]);
            y = zeros(1, m);
            for n=1:m
                if rem(t(n),1/f) < 1/(2*f)
                    y(n) = 0;
                else
                    y(n) = 1;
                end
            end
        end
        
        function y = triangle(f, t)
        % TRIANGLE Generate a triangle wave with values in range [0, 1]
        %   Y = TRIANGLE(F, T)
        %   F = number of triangles per second
        %   T = array of times
        y =  min(rem(t,1/f)/(1/(2*f)), ((1/f)-rem(t,1/f))/(1/(2*f)));
        end
        
        function y = sawtooth(f, t)
        % SAWTOOTH Generate a sawtooth wave vith values in range [0, 1]
        %   Y = SAWTOOTH(F, T)
        %   Where:
        %   F = number of sawtooth waves per second
        %   T = array of times
        y = rem(t,1/f)*f;
        end
    end
end

