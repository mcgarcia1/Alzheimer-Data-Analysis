%Load Data
cd('/Users/cristinagarcia/Documents/MATLAB/GBA/');

%Extract data from all graphs
%mean
x = []; 
y = []; 
GBA_mean  = [];
graphz = [{'nonbreeder_month'},{'breeder_month'}];  
for iGraphz = 1 :length(graphz)
    openfig(graphz{iGraphz});
    a = get(gca);

    for iLine = 1:length(a.Children)
        x = [x; a.Children(iLine).XData(1:13)]; 

        y = [y; a.Children(iLine).YData(1:13)];
        GBA_mean = [GBA_mean {a.Children(iLine).DisplayName}];
    end
end
%standard deviation
X_edges= [];
Y_edges= [];
GBA_Name_edge= [];

h = findall(groot, 'Tag', 'shadedErrorBar_edge');

for iLinez= 1:length(h)
    X_edges = [X_edges; h(iLinez).XData(1:13)];
    Y_edges = [Y_edges; h(iLinez).YData(1:13)];
    GBA_Name_edge= [ GBA_Name_edge; {h(iLinez).DisplayName}]; 
end 
%% 
%Figure 1 (Male GBA WT)

figure;
subplot(2,3,1)
  NB_Male_GBA_WT= plot (x(1,:), y(1,:),  X_edges(1:2, :),Y_edges(1:2, :), 'r--o');
  hold on;
  B_Male_GBA_WT = plot (x(5,:), y(5,:),  X_edges(9:10, :),Y_edges(9:10, :), 'b--o') ;
 
  
title('Average monthly weight, Nonbreeders vs Breeders Male GBA WT');
xlabel('Age (months)');
ylabel('Weight (g)');
legend('NonBreeder Male GBA WT','Breeder Male GBA WT', ...
    'Location','Southeast');
set(gca,'XLim',[1 13]);
ylim([10 60]);



subplot(2,3,2)

        ylabel(['N Male GBA WT nonbreeding animals = ' num2str(size(unique(NB_Male_WT)))])
        xlabel(['N Male GBA WT nonbreeding weights = ' num2str(Rows(NB_Male_WT))])
        set(gca,'XTick',[],'YTick',[])%curreWT axis or x and y
        set(gca,'Color',[.75 .75 .75])
subplot(2,3,3)
        ylabel(['N Male GBA WT breeding animals = ' num2str(size(unique(B_Male_WT)))])
        xlabel(['N Male GBA WT breeding weights = ' num2str(Rows(B_Male_WT))])
        set(gca,'XTick',[],'YTick',[])%curreWT axis or x and y
        set(gca,'Color',[.75 .75 .75])
%% 
%Figure 2 (Male GBA HET)


subplot(2,3,4)
  NB_Male_GBA_HET= plot (x(2,:), y(2,:), X_edges(3:4, :),Y_edges(3:4, :), 'r--o');
  hold on;
  B_Male_GBA_HET = plot (x(6,:), y(6,:), X_edges(11:12, :),Y_edges(11:12, :), 'b--o');


title('Average monthly weight, Nonbreeders vs Breeders Male GBA HET');
xlabel('Age (months)');
ylabel('Weight (g)');
legend('NonBreeder Male GBA HET', 'Breeder Male GBA HET', ...
    'Location','Southeast');
set(gca,'XLim',[1 13]);
ylim([10 60]);


subplot(2,3,5)

        ylabel(['N Male GBA nonbreeding animals = ' num2str(size(unique(NB_Male_HET)))])
        xlabel(['N Male GBA nonbreeding weights = ' num2str(Rows(NB_Male_HET))])
        set(gca,'XTick',[],'YTick',[])%curreWT axis or x and y
        set(gca,'Color',[.75 .75 .75])
subplot(2,3,6)
        ylabel(['N Male GBA breeding animals = ' num2str(size(unique(B_Male_HET)))])
        xlabel(['N Male GBA breeding weights = ' num2str(Rows(B_Male_HET))])
        set(gca,'XTick',[],'YTick',[])%curreWT axis or x and y
        set(gca,'Color',[.75 .75 .75])%total N of animals 
%% 
%Figure 3 (Female GBA WT)
figure;

subplot(2,3,1)
  NB_Female_GBA_WT= plot (x(3,:), y(3,:), X_edges(5:6, :),Y_edges(5:6, :), 'r--o');
  hold on;
  B_Female_GBA_WT = plot (x(7,:), y(7,:), X_edges(13:14, :),Y_edges(13:14, :), 'b--o');


title('Average monthly weight, Nonbreeders vs Breeders Female GBA WT');
xlabel('Age (months)');
ylabel('Weight (g)');
legend('NonBreeder Female GBA WT', 'Breeder Female GBA WT', ...
    'Location','Southeast');
set(gca,'XLim',[1 13]);
ylim([10 60]);


subplot(2,3,2)

        ylabel(['N Female GBA WT nonbreeding animals = ' num2str(size(unique(NB_Female_WT)))])
        xlabel(['N Female GBA WT nonbreeding weights = ' num2str(Rows(NB_Female_WT))])
        set(gca,'XTick',[],'YTick',[])%curreWT axis or x and y
        set(gca,'Color',[.75 .75 .75])
subplot(2,3,3)
        ylabel(['N Female GBA WT breeding animals = ' num2str(size(unique(B_Female_WT)))])
        xlabel(['N Female GBA WT breeding weights = ' num2str(Rows(B_Female_WT))])
        set(gca,'XTick',[],'YTick',[])%curreWT axis or x and y
        set(gca,'Color',[.75 .75 .75])%total N of animals 
%% 
%Figure 4 (Female GBA HET)


subplot(2,3,4)
  NB_Female_GBA_HET= plot (x(4,:), y(4,:), X_edges(7:8, :),Y_edges(7:8, :), 'r--o');
  hold on;
  B_Female_GBA_HET = plot (x(8,:), y(8,:), X_edges(15:16, :),Y_edges(15:16, :), 'b--o');


title('Average monthly weight, Nonbreeders vs Breeders Female GBA HET');
xlabel('Age (months)');
ylabel('Weight (g)');
legend('NonBreeder Female GBA HET', 'Breeder Female GBA HET', ...
    'Location','Southeast');
set(gca,'XLim',[1 13]);
ylim([10 60]);


subplot(2,3,5)

        ylabel(['N Female GBA HET nonbreeding animals = ' num2str(size(unique(NB_Female_HET)))])
        xlabel(['N Female GBA HET nonbreeding weights = ' num2str(Rows(NB_Female_HET))])
        set(gca,'XTick',[],'YTick',[])%curreWT axis or x and y
        set(gca,'Color',[.75 .75 .75])
subplot(2,3,6)
        ylabel(['N Female GBA HET breeding animals = ' num2str(size(unique(B_Female_HET)))])
        xlabel(['N Female GBA HET breeding weights = ' num2str(Rows(B_Female_HET))])
        set(gca,'XTick',[],'YTick',[])%curreWT axis or x and y
        set(gca,'Color',[.75 .75 .75])%total N of animals 
%% 




% NonBreeders= 5596
% Breeder = 200
% D_B= Data_breeders;
% y= D_B(:, (["Genotype";"Sex"]));
% Ysorted= sortrows(y);
%        
%         B_Female_HET= Ysorted(1:71, :);
%         B_Male_HET= Ysorted(72:112, :);
%         B_Female_WT= Ysorted(113:145, :);
%         B_Male_WT= Ysorted(146:200, :);
% 
%         
% D_NB= Data_nonbreeders;
% Z= D_NB(:, (["Genotype";"Sex"]));
% Zsorted= sortrows(Z);
%        
%         NB_Female_HET= Zsorted(1:1583, :);
%         NB_Male_HET= Zsorted(1584:2780, :);
%         NB_Female_WT= Zsorted(2781:4124, :);
%         NB_Male_WT= Zsorted(4125:5576, :);

