%Load Data
cd('/Users/cristinagarcia/DocumeTGs/MATLAB/HLA/');

%Extract data from all graphs
%mean
x = []; 
y = []; 
HLA_mean  = [];
graphz = [{'nonbreeder_month_HLA'},{'breeder_month_HLA'}];  
for iGraphz = 1:length(graphz)
    openfig(graphz{iGraphz});
    a = get(gca);

    for iLine = 1:length(a.Children)
        x = [x; a.Children(iLine).XData(1:20)]; 

        y = [y; a.Children(iLine).YData(1:20)];
        HLA_mean = [HLA_mean {a.Children(iLine).DisplayName}];
    end
end
%standard deviation
X_edges= [];
Y_edges= [];
HLA_Name_edge= [];

h = findall(groot, 'Tag', 'shadedErrorBar_edge');

for iLinez= 1:length(h)
    X_edges = [X_edges; h(iLinez).XData(1:20)];
    Y_edges = [Y_edges; h(iLinez).YData(1:20)];
    HLA_Name_edge= [ HLA_Name_edge; {h(iLinez).DisplayName}]; 
end 
%% 

%Figure 1 (Male HLA TG)

figure;
subplot(2,3,1)
  NB_Male_HLA_TG= plot (x(1,:), y(1,:), X_edges(1:2, :),Y_edges(1:2, :), 'r--o');
  hold on;
  B_Male_HLA_TG = plot (x(3,:), y(3,:), X_edges(5:6, :),Y_edges(5:6, :), 'b--o') ;
 
  
title('Average monthly weight, Nonbreeders vs Breeders Male HLA TG');
xlabel('Age (months)');
ylabel('Weight (g)');
legend('NonBreeder Male HLA TG','Breeder Male HLA TG', ...
    'Location','Southeast');
set(gca,'XLim',[1 20]);
ylim([10 35]);



subplot(2,3,2)

        ylabel(['N Male HLA TG nonbreeding animals = ' num2str(size(unique(NB_Male_HLA)))])
        xlabel(['N Male HLA TG nonbreeding weights = ' num2str(Rows(NB_Male_HLA))])
        set(gca,'XTick',[],'YTick',[])%curreTG axis or x and y
        set(gca,'Color',[.75 .75 .75])
subplot(2,3,3)
        ylabel(['N Male HLA TG breeding animals = ' num2str(size(unique(B_Male_HLA)))])
        xlabel(['N Male HLA TG breeding weights = ' num2str(Rows(B_Male_HLA))])
        set(gca,'XTick',[],'YTick',[])%curreTG axis or x and y
        set(gca,'Color',[.75 .75 .75])
%% 
%Figure 2 (Female HLA TG)

subplot(2,3,4)
  NB_Female_HLA_TG= plot (x(2,:), y(2,:), X_edges(3:4, :),Y_edges(3:4, :), 'r--o');
  hold on;
  B_Female_HLA_TG = plot (x(4,:), y(4,:), X_edges(7:8, :),Y_edges(7:8, :), 'b--o');


title('Average monthly weight, Nonbreeders vs Breeders Female HLA TG');
xlabel('Age (months)');
ylabel('Weight (g)');
legend('NonBreeder Male HLA TG', 'Breeder Male HLA TG', ...
    'Location','Southeast');
set(gca,'XLim',[1 20]);
ylim([10 35]);


subplot(2,3,5)

        ylabel(['N Male HLA TG nonbreeding animals = ' num2str(size(unique(NB_Female_HLA)))])
        xlabel(['N Male HLA TG nonbreeding weights = ' num2str(Rows(NB_Female_HLA))])
        set(gca,'XTick',[],'YTick',[])%curreTG axis or x and y
        set(gca,'Color',[.75 .75 .75])
subplot(2,3,6)
        ylabel(['N Male HLA TG breeding animals = ' num2str(size(unique(B_Female_HLA)))])
        xlabel(['N Male HLA TG breeding weights = ' num2str(Rows(B_Female_HLA))])
        set(gca,'XTick',[],'YTick',[])%curreTG axis or x and y
        set(gca,'Color',[.75 .75 .75])
        
