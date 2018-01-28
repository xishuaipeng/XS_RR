function [OBDdata,zero_ind] = getOBDdata(targetParams, OBDparams, fid)
    [~, targetIndex]  = ismember(targetParams, OBDparams);
    OBDallData = extractSigCSVdata(fid, OBDparams);
    zero_ind = find(targetIndex == 0);
    targetIndex(zero_ind) = [];
    OBDdata = OBDallData(:, targetIndex);
end
