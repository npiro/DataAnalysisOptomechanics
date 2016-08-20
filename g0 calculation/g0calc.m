%% load noise spectrum
dir = '/Volumes/He3/Measurement Campaigns/2014-07-07 calibrate g0/';

sigFile = [dir,'hom_1.spe'];
LOFile = [dir,'LO_1.spe'];
OffResFile = [dir,'hom_offres_1.spe'];
CalToneHeterFile = [dir,'caltone_heterodynebeaet_1.spe'];
[dataSig,params]=ImportDataAndParseParams(sigFile, {'Input 6%','cernox'});
[dataLO,params]=ImportDataAndParseParams(LOFile, {'Input 6%','cernox'});
[dataOffRes,params]=ImportDataAndParseParams(OffResFile, {'Input 6%','cernox'});
[dataCalToneHeter,params]=ImportDataAndParseParams(CalToneHeterFile, {'Input 6%','cernox'});

%% plot
FreqSig = dataSig(:,1);
AmpSig = dataSig(:,2);
semilogy(FreqSig,AmpSig);
hold on;
FreqLO = dataLO(:,1);
AmpLO = dataLO(:,2);
semilogy(FreqLO,AmpLO,'r');
FreqOff = dataOffRes(:,1);
AmpOff = dataOffRes(:,2);
semilogy(FreqOff,AmpOff,'g');
hold off;

%% Integrate areas
% Fundamental mode
freq1 = 3.6e6;
freq2 = 4.5e6;
range = FreqSig > freq1 & FreqSig < freq2;
plot(FreqSig(range),AmpSig(range));
AreaMode1 = sum(AmpSig(range));
AreaOffRes = sum(AmpOff(range));

AreaMode1Eff = AreaMode1-AreaOffRes;

% cal tone
freq1c = 2.5035e7;
freq2c = 2.506e7;
rangeC = FreqSig > freq1c & FreqSig < freq2c;
AreaCal = sum(AmpSig(rangeC));
AreaOffResC = sum(AmpOff(rangeC));
AreaCalEff = AreaCal-AreaOffResC;

%% Calibrate cal tone
FreqHeter = dataCalToneHeter(:,1);
AmpHeter = dataCalToneHeter(:,2);
semilogy(FreqHeter,AmpHeter);
freq1HetCarr = 8.767e7;
freq2HetCarr = 8.831e7;
freq1HetSB1 = 6.271e7;
freq2HetSB1 = 6.317e7;
freq1HetSB2 = 1.127e8;
freq2HetSB2 = 1.133e8;
rangeCarr = FreqHeter < freq2HetCarr & FreqHeter > freq1HetCarr;
rangeSB1 = FreqHeter < freq2HetSB1 & FreqHeter > freq1HetSB1;
rangeSB2 = FreqHeter < freq2HetSB2 & FreqHeter > freq1HetSB2;
AreaCarr = sum(AmpHeter(rangeCarr));
AreaSB1 = sum(AmpHeter(rangeSB1));
AreaSB2 = sum(AmpHeter(rangeSB2));
NCarr = sum(rangeCarr);
NSB1 = sum(rangeSB1);
NSB2 = sum(rangeSB2);
AreaBGCarr = sum(AmpHeter(circshift(rangeCarr,-NCarr)));
AreaBGSB1 = sum(AmpHeter(circshift(rangeSB1,-NSB1)));
AreaBGSB2 = sum(AmpHeter(circshift(rangeSB2,+NSB2)));

AreaCarrEff = AreaCarr-AreaBGCarr;
AreaSB1Eff = AreaSB1-AreaBGSB1;
AreaSB2Eff = AreaSB2-AreaBGSB2;

AreaSBEff = 0.5*(AreaSB1Eff+AreaSB2Eff);

% Mod depth and Vpi
beta = 2*sqrt(AreaSBEff/AreaCarrEff);
PdBm = -10;
Pmod = 1e-3 * 10^(PdBm/10); % Modulation power in Watts
Vmod = sqrt(Pmod * 50 * 2) % Modulation voltage amplitude: P = 1/2 V^2/R
Vpi = Vmod*pi/beta;

% S_II(\Omega) = 2*K*S_{\phi}(\Omega) + beta^2/2 *K(\Omega_m) (F(\Omega -
% \Omega_m)+F(\Omega +\Omega_m))
% AreaCal = beta^2/2 * K(\Omega_m)
% S_\omega = \Omega^2 S_\phi
% AreaS_\omega = 2*n*g_0^2
% AreaS_\phi = 2*n*g_0^2/Omega_m^2
% AreaS_II(\Omega_m) = 2*2/beta^2*AreaCal*2*n*g0^2/Omega_m^2
% g0 = sqrt(AreaMech*Omega_m^2*beta^2/(8*AreaCal*n))
hbar = 1.05e-34;
kB = 1.38e-23;
OmegaM = 2*pi*4.3e6;
OmegaCal = 2*pi*25e6;
T = 3.08;
n = kB*T/(hbar*OmegaM)
g0 = sqrt(AreaMode1Eff*hbar*OmegaM*OmegaCal^2*beta^2/(4*AreaCalEff*kB*T))/(2*pi)   % In MHz
g02 = OmegaCal/(2*pi) * beta/2 * sqrt(AreaMode1Eff/AreaCalEff * 1/n)
Kappa = 1e9;
GammaM = 6;

C0 = 4*g0^2/(GammaM*Kappa)