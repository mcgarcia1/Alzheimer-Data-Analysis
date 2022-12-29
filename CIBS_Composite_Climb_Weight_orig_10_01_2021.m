%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% This script is meant to analyze weight data exported via Climb
% JW 12.15.20

%% Load the data
cd('/Users/cristinagarcia/Documents/MATLAB/AnimalWeights');
% cd contains urrent folder

%% MAKE SURE THIS IS THE MOST RECENT DATASHEET
% This is made by generating a report from Climb
Body_weight_data = 'Body Weight - J_20220824131253.csv';
Breeders = 'Breeder_Animal_List_10.1.21.csv';
% data will be extracted from these files

exclude_breeders = 1;
analyze_breeders = 0;

only_QC = 0;
%names on the left( variables), numbers on the right are outcome of rows
%and cols. For example size(analyze_breeders), ans= 1 1. check table row 1,
%colum 1= 0 is the answer


genotypez = {'APOE'}%{'APOE' 'c9orf' 'HLA' 'GBA'};
for iGenotypez = 1%:length(genotypez)
    single_geno = genotypez{iGenotypez};
    %APOE, c9Orf, HLA, GBA different variants, genes associated with
    %Alzheimer's
    
    %% IMPORTANT:
    Data = readtable(Body_weight_data);
    Breeder_Data = readtable(Breeders);
    Data = Data(contains(Data.TaskStatus,'Complete'),:); % Sort out the incomplete tasks; there are a number of tasks involving data upload
    Data = sortrows(Data,'AnimalID');
    %% Calculate Age at Weight (weeks) and Age at Weight (months)
    %% NOTE: the ages listed on this sheet are the current age of the animal
    DD = datenum(Data.CollectionDate);
    DB = datenum(Data.DateBorn);
    %date time to serial date number(dd-mmm-yyyy)for collection date and
    %born date
    
    Data.AgeAtWeight_weeks_ = round((DD - DB)/7); %rounded so week and month graphs don't look the same
    Data.AgeAtWeight_months_ = round((DD - DB)/30);
    %7 total days in a week, 30 total days in a month
    
    %% Remove data for animals that's below 6 months old...too much weight change is expected here
    Data = Data(Data.AgeAtWeight_months_ >= 1,:);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Quality controls
    % these are only applicable for longitudinal effects; data can still be
    % used for de-identified animals
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %% Double-check for funky data
    if only_QC == 1
        animals = unique(Data.AnimalID);
        QC_duplicate_weights = [];
        QC_multiple_weights = [];
        QC_weight_loss = [];
        QC_weight_errors = [];
        QC_impossible_weights = [];
        for iAnimal = 1:length(animals)
            %Quality control, take out factors, reduce and correct problems
            %to make sure data is up to standards
            %

            sect_data = Data(Data.AnimalID==animals(iAnimal),:);
            sect_data = sortrows(sect_data,'AgeAtWeight_weeks_');
            
            if Rows(sect_data) == 1
                continue
            end
            
            if isnan(animals(iAnimal))
                continue
            end
            %if else end, evaluates expressions and excutes statement when
            %expression is true. It is true when there are non-zero
            %elements
            %== comapre 2 variables, if it's equal 0, if not 
            
            %% This will skip animals whose weights are more than a month apart (this could skew for large changes)
            if sum(diff(sect_data.AgeAtWeight_months_) > 1) > 0
                continue
            end
            % sum of the difference in AgeatWeight is greater than 1
            
            %% This detects if some animals were entered twice?
            if unique(sect_data.AgeAtWeight_weeks_)<length(sect_data.AgeAtWeight_weeks_)
                QC_duplicate_weights = [QC_duplicate_weights; sect_data];
            end
            %check for duplication sumz_wkz, none
            %a{697, 6} = []
            
            %% This detects if some animals had multiple weight entries?
            if diff(sect_data.AgeAtWeight_months_) < 1
                QC_multiple_weights = [QC_multiple_weights; sect_data];
            end
            %find out the diff on animals with multiple entries
            
            %% If animals lost more than -20%
            WeightPercentage = (diff(sect_data.Weight)./sect_data.Weight(1:end-1))*100;
            WeightPercentage = [WeightPercentage; NaN];
            sect_data.WeightChange = WeightPercentage;
            if sum(WeightPercentage<-20)>0 && sum(strcmp(sect_data.AnimalStatus,'Alive')) > 0
                QC_weight_loss = [QC_weight_loss; sect_data];
            end
            % logical short circuiting, returns 0 if expression is false 
            % not a single animal lost more than 20% fo weight ??
          
            
            %% If animals lost or gained more than than -25%
            WeightPercentage = (diff(sect_data.Weight)./sect_data.Weight(1:end-1))*100;
            if sum(WeightPercentage<-25)>0 || sum(WeightPercentage>25)>0
                QC_weight_errors = [QC_weight_errors; sect_data];
            end
            % expression is false 
            %not a single animal lost or gained more than 25%??
            %% Impossible weights
            if sum(sect_data.Weight == 0) > 0 || sum(sect_data.Weight > 60) > 0
                QC_impossible_weights = [QC_impossible_weights; sect_data];
            end
        end
    else
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Settings
        % if you only want to analyze a single group
        %since there is strcmp, are we comparing genotype
        if strcmp(single_geno,'APOE')
            Data = Data(contains(Data.Line,'Apoe'),:);
            Data = Data(~contains(Data.Line_Short_,'Pre-'),:);
            Data = Data(~contains(Data.Genotype,'HOMO'),:);
            Data = Data(~contains(Data.Genotype,'HET'),:);
            genotype = 'Apoe';
            % elseif strcmp(single_geno,'APOE3vs4')
            %     Data = Data(contains(Data.Line,'Apoe'),:);
            %     Data = Data(~contains(Data.Line,'Apoe3/4'),:);
            %     genotype = 'Apoe';
            %only work on APOE add data on pre-, homo, het. add column line_short_ only containing apoe4 
        elseif strcmp(single_geno,'c9orf')
            Data = Data(contains(Data.Line,'C9'),:);
            genotype = 'C9';
            Data = Data(~contains(Data.Genotype,'low'),:);
        elseif strcmp(single_geno,'HLA')
            Data = Data(contains(Data.Line,'HLA'),:);
            Data = Data(~contains(Data.Genotype,'hemi'),:);
            Data = Data(~contains(Data.Genotype,'homo'),:);
            Data = Data(~contains(Data.Genotype,'unclear'),:);
            Data = Data(~contains(Data.Genotype,'NT'),:);
            Data = Data(~contains(Data.Genotype,'HLA TG; HLA NT'),:);
            Data = Data(~contains(Data.Genotype,'HLA NT; HLA TG'),:);
            genotype = 'HLA';
        elseif strcmp(single_geno,'GBA')
            Data = Data(contains(Data.Line,'Gba'),:);
            Data = Data(~contains(Data.Genotype,'Neg'),:);
            Data = Data(~contains(Data.Genotype,'Pos'),:);
            genotype = 'GBA';
        end
        %strcmp compare vectors, tf (true or false statement to check)
        %s1 and s2 assigning celll aray to compare
        % this is what makes the nonbreeders and the breeders distinguished from
        % each other
            Breeder_list = [];
            Non_breeder_list = [];
            if exclude_breeders == 1
                for iRow = 1:size(Data,1)
                    Breeder_Add_on = sum(Breeder_Data.ID == Data.AnimalID(iRow));
                    Breeder_list = [Breeder_list; Breeder_Add_on];
                end
                for iRow = 1:size(Data,1)
                    Non_Breeder_Add_on = sum(Breeder_Data.ID == Data.AnimalID(iRow)) == 0; % if == 1 then the data will be identical to that of the breeders
                    Non_breeder_list = [Non_breeder_list; Non_Breeder_Add_on];
                end
                % these are the new data tables for non breeders and breeders
                Data_nonbreeders = Data(logical(Non_breeder_list),:);
                Data_breeders = Data(logical(Breeder_list),:);
            end
            % Breeders are now excluded from the Data_nonbreeders and are solely in the
            % Data_breeders sheet, which is what the following lines will derive their
            % weight data from


            
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Raw data
        % Plots all weights at once - separates by sex and genotype
        %first figure
        %subplot m(number of grid rows),n(number of grid columns),p(grid
        %position)
        %subplot 'rkgb'-colors. ..(ooo?).  [20,20,8,8]-position (usually 4
        %(width, bottom, width, height), ooo resulting marker circle
        figure;
        subplot(2,3,1)
        if strcmp(single_geno,'APOE')
            g = gscatter(Data.AgeAtWeight_weeks_,Data.Weight,{Data.Line_Short_ Data.Sex},'rkgbcy','...ooo',[20 20 20 8 8 8]);
        else
            g = gscatter(Data.AgeAtWeight_weeks_,Data.Weight,{Data.Genotype Data.Sex},'rkgb','..oo',[20 20 8 8]);
        end
        
        title(['All ' genotype ' Weights']);
        ylabel('Weight (g)');
        xlabel('Age (weeks)');
%         pubify_figure_axis(14,14);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Age in Weeks
        % Non breeders in weeks
        % Creates average lines but they jump all over the place...
        subplot(2,3,2)
        
        if analyze_breeders == 0
            if strcmp(single_geno,'APOE')
                sumz_wks = grpstats(Data_nonbreeders,{'AgeAtWeight_weeks_','Sex','Line_Short_'},{'mean','sem'},'DataVars','Weight');
                g_non = gscatter(sumz_wks.AgeAtWeight_weeks_,sumz_wks.mean_Weight,{sumz_wks.Line_Short_ sumz_wks.Sex},'rkgbcy','...ooo',[20 20 20 8 8 8]);
            else
                sumz_wks = grpstats(Data_nonbreeders,{'AgeAtWeight_weeks_','Sex','Genotype'},{'mean','sem'},'DataVars','Weight');
                g_non = gscatter(sumz_wks.AgeAtWeight_weeks_,sumz_wks.mean_Weight,{sumz_wks.Genotype sumz_wks.Sex},'rkgb','..oo',[20 20 8 8]);
            end
            
            set(g_non, 'linestyle','-');
            title(['Average Weekly (Non-breeding) ' genotype ' Weights']);
            ylabel('Weight (g)');
            xlabel('Age (wks)');
%             pubify_figure_axis(14,14);
            
        elseif analyze_breeders == 1
            % Breeders in weeks
            if strcmp(single_geno,'APOE')
                sumz_wks = grpstats(Data_breeders,{'AgeAtWeight_weeks_','Sex','Line_Short_'},{'mean','sem'},'DataVars','Weight');
                g_breed = gscatter(sumz_wks.AgeAtWeight_weeks_,sumz_wks.mean_Weight,{sumz_wks.Line_Short_ sumz_wks.Sex},'rkgbcy','...ooo',[20 20 20 8 8 8]);
            else
                sumz_wks = grpstats(Data_breeders,{'AgeAtWeight_weeks_','Sex','Genotype'},{'mean','sem'},'DataVars','Weight');
                g_breed = gscatter(sumz_wks.AgeAtWeight_weeks_,sumz_wks.mean_Weight,{sumz_wks.Genotype sumz_wks.Sex},'rkgb','..oo',[20 20 8 8]);
            end
            
            set(g_breed, 'linestyle','-');%solid line
            title(['Average Weekly Breeding ' genotype ' Weights']);
            ylabel('Weight (g)');
            xlabel('Age (wks)');
%             pubify_figure_axis(14,14);

        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Age in Months
        subplot(2,3,3)
        
        % Non breeders in months
        if analyze_breeders == 0
            if strcmp(single_geno,'APOE')
                sumz_mnths = grpstats(Data_nonbreeders,{'AgeAtWeight_months_','Sex','Line_Short_'},{'mean','sem'},'DataVars','Weight');
                g_non = gscatter(sumz_mnths.AgeAtWeight_months_,sumz_mnths.mean_Weight,{sumz_mnths.Line_Short_ sumz_mnths.Sex},'rkgbcy','...ooo',[20 20 20 8 8 8]);
            else
                sumz_mnths = grpstats(Data_nonbreeders,{'AgeAtWeight_months_','Sex','Genotype'},{'mean','sem'},'DataVars','Weight');
                g_non = gscatter(sumz_mnths.AgeAtWeight_months_,sumz_mnths.mean_Weight,{sumz_mnths.Genotype sumz_mnths.Sex},'rkgb','..oo',[20 20 8 8]);
            end
            
            set(g_non, 'linestyle','-');
            title(['Average Monthly (Non-breeding) ' genotype ' Weights']);
            ylabel('Weight (g)');
            xlabel('Age (months)');
            set(gca,'XLim',[0 24]);
%             pubify_figure_axis(14,14);
            
        elseif analyze_breeders == 1
            % Breeders in months
            if strcmp(single_geno,'APOE')
                sumz_mnths = grpstats(Data_breeders,{'AgeAtWeight_months_','Sex','Line_Short_'},{'mean','sem'},'DataVars','Weight');
                g_breed = gscatter(sumz_mnths.AgeAtWeight_months_,sumz_mnths.mean_Weight,{sumz_mnths.Line_Short_ sumz_mnths.Sex},'rkgb','...ooo',[20 20 8 8]);
            else
                sumz_mnths = grpstats(Data_breeders,{'AgeAtWeight_months_','Sex','Genotype'},{'mean','sem'},'DataVars','Weight');
                g_breed = gscatter(sumz_mnths.AgeAtWeight_months_,sumz_mnths.mean_Weight,{sumz_mnths.Genotype sumz_mnths.Sex},'rkgb','..oo',[20 20 8 8]);
            end
            
            set(g_breed, 'linestyle','-');
            title(['Average Monthly Breeding ' genotype ' Weights']);
            ylabel('Weight (g)');
            xlabel('Age (months)');
%             pubify_figure_axis(14,14);
        end
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% List sample sizes
        
        subplot(2,3,4)
        ylabel(['N animals = ' num2str(length(unique(Data_nonbreeders.AnimalID)))])
        xlabel(['N weights = ' num2str(Rows(Data_nonbreeders))])
        set(gca,'XTick',[],'YTick',[])%current axis or x and y
        set(gca,'Color',[.75 .75 .75])
%         pubify_figure_axis(20,20);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Shaded error bars (weeks)
        subplot(2,3,5)
        Sex = unique(sumz_wks.Sex);
        if strcmp(single_geno,'APOE')
            Lines = unique(sumz_mnths.Line_Short_);
        else
            Lines = unique(sumz_mnths.Genotype);
        end
        
        Colors = {'' '-b' '-r' '-g' '-y' '-c' '-k'};
        leg = [];
        for iSex = 1:length(Sex)
            for iLines = 1:length(Lines)
                if iSex == 1
                    iColors = iSex+iLines;
                elseif iSex == 2
                    iColors = iSex+iLines+1;
                end
                
                if strcmp(single_geno,'APOE')
                    grp = sumz_wks((strcmp(sumz_wks.Sex,Sex{iSex})+strcmp(sumz_wks.Line_Short_,Lines{iLines})==2),:);
                    shadedErrorBar(grp.AgeAtWeight_weeks_, grp.mean_Weight, grp.sem_Weight,'lineProps',Colors{iColors});
                else
                    grp = sumz_wks((strcmp(sumz_wks.Sex,Sex{iSex})+strcmp(sumz_wks.Genotype,Lines{iLines})==2),:);
                    shadedErrorBar(grp.AgeAtWeight_weeks_, grp.mean_Weight, grp.sem_Weight,'lineProps',Colors{iColors});
                end
                hold on;
                leg = [leg {[Sex{iSex} '_' Lines{iLines}]}];
            end
        end
        
        xlabel('Age (weeks)');
        ylabel('Weight (g)');
        legend(leg,'Location','Southeast');
        set(gca,'XLim',[1 80]);
        title('Average weekly weight');
        %gca current graph (handle)
        
%         pubify_figure_axis(14,14);
        
        %% Shaded error bars (months)
        subplot(2,3,6)
        
        Sex = unique(sumz_mnths.Sex);
        if strcmp(single_geno,'APOE')
            Lines = unique(sumz_mnths.Line_Short_);
        else
            Lines = unique(sumz_mnths.Genotype);
        end
        Colors = {'' '-b' '-r' '-g' '-y' '-c' '-k'};
        leg = [];
        for iSex = 1:length(Sex)
            for iLines = 1:length(Lines)
                if iSex == 1
                    iColors = iSex+iLines;
                elseif iSex == 2
                    iColors = iSex+iLines+1;
                end
                if strcmp(single_geno,'APOE')
                    grp = sumz_mnths((strcmp(sumz_mnths.Sex,Sex{iSex})+strcmp(sumz_mnths.Line_Short_,Lines{iLines})==2),:);
                    shadedErrorBar(grp.AgeAtWeight_months_, grp.mean_Weight, grp.sem_Weight,'lineProps',Colors{iColors});
                else
                    grp = sumz_mnths((strcmp(sumz_mnths.Sex,Sex{iSex})+strcmp(sumz_mnths.Genotype,Lines{iLines})==2),:);
                    shadedErrorBar(grp.AgeAtWeight_months_, grp.mean_Weight, grp.sem_Weight,'lineProps',Colors{iColors});
                end
                hold on;
                leg = [leg {[Sex{iSex} '_' Lines{iLines}]}];
            end
        end
        
        xlabel('Age (months)');
        ylabel('Weight (g)');
        legend(leg,'Location','Southeast');
        set(gca,'XLim',[1 25]);
        title('Average monthly weight');
        
%         pubify_figure_axis(14,14);
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Save figure
        cd('/Users/cristinagarcia/Documents/MATLAB/figure folder/')
        set(gcf, 'Position', get(0, 'Screensize')); % fullscreens the figure so the text doesn't run
        N = [genotype '_colony_weights'];
        saveas(gcf,N,'epsc'); % saves as an eps color figure
        close
        
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%         %% Plot longitudinally and organize by sex and genotype by percentage weight lost or gained
%         
%         figure;
%         Data = sortrows(Data,'AnimalID');
%         animals = unique(Data.AnimalID)
%         
%         Sex = unique(sumz_mnths.Sex);
%         
%         for iAnimal = 1:length(unique(Data.AnimalID))
%             sect_data = Data(Data.AnimalID==animals(iAnimal),:);
%             sect_data = sortrows(sect_data,'AgeAtWeight_weeks_');
%             
%             if strcmp(single_geno,'APOE')
%                 Data_lines = sect_data.Line_Short_;
%                 Lines = unique(sumz_mnths.Line_Short_);
%             else
%                 Data_lines = sect_data.Genotype;
%                 Lines = unique(sumz_mnths.Genotype);
%             end
%             
%             if Rows(sect_data) == 1
%                 continue
%             end
%             
%             %% need a check here for if the months are more than 1 apart
%             WeightPercentage = (diff(sect_data.Weight)./sect_data.Weight(1:end-1))*100;
%             
%             %% Unique tables
%             Sexes = reshape(ndgrid(Sex,Lines),1,numel(ndgrid(Sex,Lines)));
%             Linez = reshape(ndgrid(Lines,Sex),1,numel(ndgrid(Lines,Sex)));%
%             %ngrid= returns distributed array column vector for one
%             dimensional; grid 
%             %%
%             for iSex = 1:length(Sexes)
%                 for iLine = 1:length(Linez)
%                     if sum(strcmp(Data_lines,Lines{1}))>0 & sum(strcmp(sect_data.Sex,Sex(iSex)))>0
%                         subplot(length(Sex),length(Lines),1) %% STRCMP THIS
%                         title([Sexes{iSex} ' ' Linez{iLine}]);
%                     end
%                 end
%             end
%             
%             plot(sect_data.AgeAtWeight_weeks_(1:end-1),WeightPercentage,'-');
%             hold on;
%         end
%         
%         for iPlot = 1:length(Sex)*length(Lines)
%             subplot(length(Sex),length(Lines),iPlot)
%             xlabel('Age (wks)');
%             ylabel('Weight percent change');
%             set(gca,'XLim',[0 60]);
%             set(gca,'YLim',[-50 100]);
% %             pubify_figure_axis(14,14);
%         end
%         
%         cd('/Users/jplw/Desktop/CIBS/LABS/Brinton Lab/COMPOSITE_DATA/Weight_data/ColonyWeights')
%         set(gcf, 'Position', get(0, 'Screensize')); % fullscreens the figure so the text doesn't run
%         N = [genotype '_longitudinal_weights'];
%         saveas(gcf,N,'epsc'); % saves as an eps color figure
%         close
        
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        %% Next need to average these values for each genotype with SEM
        
        
    end %% QC = 1;
    
end %% Genotypes