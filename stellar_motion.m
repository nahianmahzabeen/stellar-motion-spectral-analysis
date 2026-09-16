%% Stellar Motion Analysis
% MATLAB project analyzing stellar spectra to determine redshift
% and radial velocity for multiple stars.

%% Load Data and Define Measurement Parameters
load starData

nObs = size(spectra,1);
lambdaStart = 630.02;
lambdaDelta = 0.14;

lambdaEnd = lambdaStart + (nObs - 1)*lambdaDelta;
lambda = lambdaStart:lambdaDelta:lambdaEnd;

%% Analyze Stellar Spectrum
% Analyze the second star in the dataset
s = spectra(:,2);

% Plot the stellar spectrum
plot(lambda,s,".-")
xlabel("Wavelength")
ylabel("Intensity")

% Locate the hydrogen-alpha absorption line
[sHa,idx] = min(s);
lambdaHa = lambda(idx);

% Mark the hydrogen-alpha line on the plot
hold on
plot(lambdaHa,sHa,"rs",MarkerSize=8)
hold off

% Calculate redshift and radial velocity
z = lambdaHa/656.28 - 1;
speed = z*299792.458;

%% Compare Stellar Spectra
% Calculate the hydrogen-alpha wavelength, redshift,
% and radial velocity for all seven stars.
[sHa,idx] = min(spectra);
lambdaHa = lambda(idx);
z = lambdaHa/656.28 - 1;
speed = z*299792.458;

%% Plot Spectra for All Seven Stars
figure

for v = 1:7
    s = spectra(:,v);

    % Blueshifted spectra are plotted with dashed lines.
    % Redshifted spectra are plotted with thicker lines.
    if speed(v) <= 0
        plot(lambda,s,"--")
    else
        plot(lambda,s,LineWidth=3)
    end

    hold on
end

hold off
xlabel("Wavelength")
ylabel("Intensity")
legend(starnames)

%% Identify Redshifted Stars
movaway = starnames(speed > 0);
