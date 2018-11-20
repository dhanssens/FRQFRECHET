%% DAAN HANSSENS
% NOVEMBER, 2016, UGent, Belgium
%
% Read output from FRQFrechet.exe
%
% [output] = read_output_FRQFrechet(filename,A,B)
%

function [output] = read_output_FRQFrechet_3D(filename,A,B)

    fid = fopen(filename);  % filename= 'F3DR0'; n= 101;
    
    % Read first lines and get data info
    fgets(fid); fgets(fid);
    
    % Read layer data
    format_str = '%f';
    for i = 1:B-1 % Num columns
        format_str = [format_str ' %f'];
    end
    C = textscan(fid,format_str);
    fclose(fid);
    
    % Put into array
    output = zeros(A,B);
    for i = 1:size(C,2)
        output(:,i) = C{i};
    end

end

