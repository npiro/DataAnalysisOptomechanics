clear;
[ data,paramsOut ] = ImportDataAndParseParams('/Users/piromast/Documents/Physics/Quantum optomechanics/Data/2014-04-30 Cooling run with 2uW of probe and 5uW of pump monitoring 43MHz mode/mech_narrow_4.00E-1.spe', 'probe');
Freq = data(:,1);
Amp = data(:,2);
[FWHM, A, C, OmegaM]=GetLogLorentzianFitStartPoint(Freq,Amp);

%x0 = OmegaM-OmegaM/100:OmegaM/1000:OmegaM+OmegaM/100;
am = A-A/1:A/20:A+4*A/1;
L = FWHM-19*FWHM/20:FWHM/20:FWHM+FWHM/1;
for i=1:length(am)
    for j = 1:length(L)
        %sse(i,j) = sum((Lorentzian(Freq,C,A,x0(i),L(j))-Amp).^2);
        sse(i,j) = sum((Lorentzian(Freq,C,am(i),OmegaM,L(j))-Amp).^2);

    end
end
am2 = A-6*A/5:A/10:A+2*A;
c = C-C:C/20:C+2*C/1;
for i=1:length(am2)
    for j = 1:length(c)
        %sse(i,j) = sum((Lorentzian(Freq,C,A,x0(i),L(j))-Amp).^2);
        sse2(i,j) = sum((Lorentzian(Freq,c(j),am2(i),OmegaM,FWHM)-Amp).^2);

    end
end

L2 = FWHM-19*FWHM/20:FWHM/20:FWHM+FWHM/10;
c2 = C-10*C:C/10:C+10*C/1;
for i=1:length(L2)
    for j = 1:length(c2)
        %sse(i,j) = sum((Lorentzian(Freq,C,A,x0(i),L(j))-Amp).^2);
        sse3(i,j) = sum((Lorentzian(Freq,c2(j),A,OmegaM,L2(i))-Amp).^2);

    end
end
FWHM
A
C
OmegaM
[fitresult, gof, output] = LogLorentzianFit2(Freq, Amp, [FWHM, A, C, OmegaM]);
f = @(x,xdata)Lorentzian(xdata,x(4),x(2),x(1),x(3));

options = optimset('Display','iter-detailed','DiffMinChange',1e-7,'DiffMaxChange',1);

FitParams = lsqcurvefit(f,[FWHM, A, C, OmegaM],Freq,Amp,[0 0 0 0.99*OmegaM],[Inf Inf Inf OmegaM*1.01],options)
%contourf(L,x0,sse)
subplot(3,1,1);
contourf(L,am,sse*1e19,50)
hold on;
plot(FWHM,A,'dy')
plot(FitParams(1),FitParams(2),'sy');
fitresult.L
fitresult.a
plot(fitresult.L,fitresult.a,'oy')
hold off;
xlabel('FWHM');
ylabel('Amp');
subplot(3,1,2);
contourf(c,am2,sse2*1e19,50);
hold on;
plot(C,A,'dg');
plot(FitParams(3),FitParams(2),'sg');
plot(fitresult.c,fitresult.a,'og')
fitresult.c
fitresult.a
xlabel('BG');
ylabel('Amp');
hold off;
subplot(3,1,3);
contourf(c2,L2,sse3*1e19,50);
hold on;
plot(C,A,'dg');
plot(FitParams(3),FitParams(2),'sg');
plot(fitresult.c,fitresult.a,'og')
fitresult.c
fitresult.a
xlabel('BG');
ylabel('Amp');
hold off;
figure(2);
plot(Freq,Amp,'.')