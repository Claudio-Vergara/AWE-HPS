
clear



System_NumberofModules  = 20000:5000:50000;
System_NumberofKites    = 0:2:10;
System_LossofLoad       = 0;

LCoE = zeros(length(System_NumberofModules),length(System_NumberofKites),length(System_LossofLoad));
for i = 1: length(System_NumberofModules)
    for j= 1: length(System_NumberofKites)
        for k = 1: length(System_LossofLoad)
[LCoE(i,j,k)] = HybridPowerPlant_calculations(System_NumberofModules(i), System_NumberofKites(j), System_LossofLoad(k));
        end
    end
end


%%
% figure
% surf(LCoE)
% xlabel('Number of Kites')
% xticks([1 2 3 4])
% xticklabels({'5' '6' '7' '8'})
% ylabel('Number of Modules x1000')
% yticks([0 5 10 15 20])
% yticklabels({'20' '25' '30' '35' '40'})
% zlabel('Normalized LCoE [EUR/MWh]')
% zticks([380 400 420 440])
% zticklabels({'0.86' '0.91' '0.95' '1'})
% title('Normalized LCoE for different number of kites and modules')

[MIN_LCoE, rows]    = min(LCoE);            %#ok<ASGLU> 
[MIN_LCoE, cols]    = min(min(LCoE));       %#ok<ASGLU>
[MIN_LCoE, layer]   = min(min(min(LCoE)));
col = cols(:,:,layer);
row = rows(:,col,layer);



%% This only works if there is a minimum of two entries in each optimization variable

NumberofModules     = min(System_NumberofModules) + (max(System_NumberofModules)-min(System_NumberofModules))/(length(System_NumberofModules)-1) * (row-1);
NumberofKites       = min(System_NumberofKites) + (max(System_NumberofKites)-min(System_NumberofKites))/(length(System_NumberofKites)-1) * (col-1);
LossofLoad          = min(System_LossofLoad) + (max(System_LossofLoad)-min(System_LossofLoad))/(length(System_LossofLoad)-1) * (layer-1);

if isnan(NumberofKites)
        NumberofKites  = System_NumberofKites;
end

if isnan(NumberofModules)
    NumberofModules = System_NumberofModules;
end

if isnan(LossofLoad)
    LossofLoad = System_LossofLoad;
end

clear i 
clear j
clear k
clear row
clear rows
clear col
clear cols
clear layer



