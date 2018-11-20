%% DAAN HANSSENS
% NOVEMBER, 2016, UGent, Belgium
%
% Write input FRQFrechet.inp for the FRQFrechet.exe
%
% [] = write_input_FRQFrechet(input)
%

function [] = write_input_FRQFrechet(input)

    out_fid = fopen('FRQFrechet.inp', 'w');
    fprintf(out_fid, '%s\r\n',input.PROJ);     
    fprintf(out_fid, '%.0f %.0f %.0f\r\n',input.COORFIX,input.ITX,input.IRX);
    fprintf(out_fid, '%.0f %.0f %.0f\r\n',input.IDERIV,input.IDIM,input.IFIELD);
    fprintf(out_fid, '%.4f %.2f %.2f %.2f\r\n',input.SIGMA,input.HTX,input.HRX,input.RRX);
    fprintf(out_fid, '%.0f %.0f\r\n',input.NFREQ,input.FREQ);
    fprintf(out_fid, '%.2f %.2f %.0f\r\n',input.XLO,input.XHI,input.NX);
    fprintf(out_fid, '%.2f %.2f %.0f\r\n',input.YLO,input.YHI,input.NY);
    fprintf(out_fid, '%.2f %.2f %.0f\r\n',input.ZLO,input.ZHI,input.NZ);   
    fclose(out_fid);

end

