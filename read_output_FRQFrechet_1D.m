%% DAAN HANSSENS
% NOVEMBER, 2016, UGent, Belgium
%
% Read output from FRQFrechet.exe
%
% [output] = read_output_FRQFrechet(filename,A,B)
%

function [output] = read_output_FRQFrechet_1D(filename)

    fid = fopen(filename);  % filename= 'F3DR0'; n= 101;
    
    % Read first lines and get data info
    ns= fgets(fid);
    
    % Read layer data
    format_str = '%f %f';
    C = textscan(fid,format_str);
    fclose(fid);
    
    % Put into array
    output(:,1) = C{1};
    output(:,2) = C{2};
    
end

