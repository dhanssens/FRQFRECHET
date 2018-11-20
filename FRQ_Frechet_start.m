%%  DAAN HANSSENS
%   NOVEMBER, 2016, UGent, Belgium
%
%   Matlab start script compatible with frqfrechet.exe (Niels Boie 
%   Christensen), .exe file has to be in the same library. 
%
%   Tølbøll R.J. and Christensen N.B., 2007, The sensitivity functions of 
%   frequency domain magnetic dipole-dipole systems. Geophysics 72, F45–F56.
%

%% INIT ___________________________________________________________________
clc; clear all; close all;


%% PARAMETERS, USER-INPUT _________________________________________________
input.PROJ= 'PAR';                      % Projection, 'PLA', 'PAR' and 'PER' for PLAne projection (perpendicular to the z-axis), 
                                        % projection PARallel to the Tx-Rx line (perpendicular to the y-axis) and projection 
                                        % PERpendicular to the Tx-Rx line (perpendicular to the x-axis)

input.COORFIX= 0;                       % The plane of projection intersects its perpendicular axis at this coordinate
input.ITX= 2;                           % The orientation of the Tx and Rx dipole are given by ITX and IRX, respectively and they
input.IRX= 2;                           % both take the values 1, 2 and 3 for x-, y- and z-orientation

input.IDERIV= 0;                        % 0 gives magnetic field Fréchet kernel, 1 gives induction Fréchet kernel
input.IDIM= 3;                          % Determines the dimension of the Fréchet kernel, 1D, 2D, 3D
input.IFIELD= 1;                        % 0: no fields are written to an output file. IFIELD = 1: Real and imaginary parts of the x- 
                                        % and y-components of the electric field of the transmitter are written to output files.

input.SIGMA= 0.1;                       % Conductivity of halfspace (S/m)
input.HTX= 0.195;                       % T height (m), position T is (0,0,-HTX)
input.HRX= 0.195;                       % R height (m), position R is (-RRX,0,-HRX)
input.RRX= 2.1;                         % T-R distance (m)

input.NFREQ= 1;                         % Number of frequencies
input.FREQ= 9000;                       % Frequencies (Hz)

input.XLO= -10;                         % In case of a plane projection, the 3D sensitivity function is sampled from XLO to XHI in
input.XHI= 10;                          % the x-direction using NX intervals, corresponding to NX+1 samples, and from YLO to YHI in
input.NX= 100;                          % the y-direction using NY intervals, corresponding to NY+1 samples.
input.YLO= -10;                         % In case of a parallel projection, the 3D sensitivity function is sampled from XLO to XHI
input.YHI= 10;                          % in the x-direction using NX intervals, corresponding to NX+1 samples and from YLO to YHI
input.NY= 100;                          % in the z-direction using NY intervals, corresponding to NY+1 samples.
input.ZLO= 0;                           % In case of a perpendicular projection, the 3D sensitivity function is sampled from XLO to
input.ZHI= 10;                          % XHI in the y-direction using NX intervals, corresponding to NX+1 samples and from YLO to
input.NZ= 100;                          % YHI in the z-direction using NY intervals, corresponding to NY+1 samples.

    
%% SET ____________________________________________________________________
% Projection plane options/axis options
if strcmp(input.PROJ,'PLA') == 1
    A= input.NX + 1;
    B= input.NY + 1;
    aa= linspace(input.XLO,input.XHI,A);
    bb= linspace(input.YLO,input.YHI,B);
elseif strcmp(input.PROJ,'PAR') == 1
    A= input.NZ + 1;
    B= input.NX + 1;
    bb= linspace(input.ZLO,input.ZHI,A);
    aa= linspace(input.XLO,input.XHI,B);
else
    A= input.NZ + 1;
    B= input.NY + 1;
    bb= linspace(input.ZLO,input.ZHI,A);
    aa= linspace(input.YLO,input.YHI,B);
end


%% RUN FRQFRECHET _________________________________________________________
% Write input file
write_input_FRQFrechet(input);

% Run
[status,cmdout]= dos('FRQFrechet.exe'); disp(cmdout);

% Get output
if input.IDIM== 3
    % Read output files Normalised sensitivity 3D
    oR= read_output_FRQFrechet_3D('F3DR0',A,B);  % Real (IP)
    oI= read_output_FRQFrechet_3D('F3DI0',A,B);  % Imaginary (QP)
    oA= read_output_FRQFrechet_3D('F3DA0',A,B);  % Amplitude
    % Read output file Electric Field Distribution
    oEyI= read_output_FRQFrechet_3D('EFIELDYI0',A,B);  % Imaginary (QP)
    oExI= read_output_FRQFrechet_3D('EFIELDXI0',A,B);
    oExR= read_output_FRQFrechet_3D('EFIELDXR0',A,B);  % Real (IP)
    oEyR= read_output_FRQFrechet_3D('EFIELDYR0',A,B);
elseif input.IDIM== 2
    % Read output files Normalised sensitivity 3D
    oR= read_output_FRQFrechet_3D('F2DR0',A,B);  % Real (IP)
    oI= read_output_FRQFrechet_3D('F2DI0',A,B);  % Imaginary (QP)
    oA= read_output_FRQFrechet_3D('F2DA0',A,B);  % Amplitude
else
    % Read output files Normalised sensitivity 3D
    oR= read_output_FRQFrechet_1D('F1DHR');  % Real (IP)
    oI= read_output_FRQFrechet_1D('F1DHI');  % Imaginary (QP)
    oA= read_output_FRQFrechet_1D('F1DHA');  % Amplitude
end


%% PLOT ___________________________________________________________________
% Title string
title_str= ['Transmitter location:(-',num2str(input.RRX),',0,-',num2str(input.HTX),...
            '),  Receiver location: (0,0,-',num2str(num2str(input.HRX)),')'...
            ];
               
if input.IDIM == 1
       
    figure();
    A= oI;
    subplot(1,2,1);
    plot(A(:,2),A(:,1));
    axis([get(gca,'xlim') input.XLO input.XHI]);
    set(gca,'ydir','reverse');
    title('QP_s_e_n_s');
    A= oR;
    subplot(1,2,2);
    plot(A(:,2),A(:,1));
    axis([get(gca,'xlim') input.XLO input.XHI]);
    set(gca,'ydir','reverse');
    title('IP_s_e_n_s');
    
else
    
    figure();
    subplot(2,1,1);
    A= oI; lim= max(max(abs(A./9999)));
    imagesc(aa,bb,A./9999,[-lim lim]); hold on;
    contourf(aa,bb,A./9999); % 0 contour
    colormap create_cmap_geo; colorbar; title(colorbar,'QP_s_e_n_s');
    title(title_str);
    subplot(2,1,2);
    A= oR; lim= max(max(abs(A./9999)));
    imagesc(aa,bb,A./9999,[-lim lim]); hold on;
    contourf(aa,bb,A./9999); % 0 contour
    colormap create_cmap_geo; colorbar;  title(colorbar,'IP_s_e_n_s');
    title(title_str);
    
end


















