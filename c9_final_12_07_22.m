%LOAD DATA
cd('/Users/cristinagarcia/Documents/MATLAB/c9/');

%Extract data from all graphs
%mean
x = []; 
y = []; 
c9_mean  = [];
graphz = [{'nonbreeding_month'},{'breeding_month'}]; 
for iGraphz = 1:length(graphz)
    openfig(graphz{iGraphz});
    a = get(gca);
    for iLine = 1:length(a.Children)
        x = [x; a.Children(iLine).XData(1:19)]; 

        y = [y; a.Children(iLine).YData(1:19)];
        c9_mean = [c9_mean {a.Children(iLine).DisplayName}];
    end
end
%standard deviation
X_edges= [];
Y_edges= [];
c9_Name_edge= [];

h = findall(groot, 'Tag', 'shadedErrorBar_edge');

for iLinez= 1:length(h)
    X_edges = [X_edges; h(iLinez).XData(1:19)];
    Y_edges = [Y_edges; h(iLinez).YData(1:19)];
    c9_Name_edge= [ c9_Name_edge; {h(iLinez).DisplayName}]; 
end 


%% 

%Figure 1 (Male c9orf TG)

figure;
subplot(2,3,1)
  NB_Male_c9_TG= plot (x(1,:), y(1,:), X_edges(9:10, :),Y_edges(9:10, :), 'r--o');
  hold on;
  B_Male_c9_TG = plot (x(5,:), y(5,:), X_edges(1:2, :),Y_edges(1:2, :), 'b--o') ;
 
  
title('Average monthly weight, Nonbreeders vs Breeders Male C9orf TG');
xlabel('Age (months)');
ylabel('Weight (g)');
legend('NonBreeder Male C9orf TG','Breeder Male C9orf TG', ...
    'Location','Southeast');
set(gca,'XLim',[1 19]);
ylim([5 50]);


subplot(2,3,2)

        ylabel(['N Male c9orf TG nonbreeding animals = ' num2str(size(unique(Male_c9_TG_non)))])
        xlabel(['N Male c9orf TG nonbreeding weights = ' num2str(Rows(Male_c9_TG_non))])
        set(gca,'XTick',[],'YTick',[])%current axis or x and y
        set(gca,'Color',[.75 .75 .75])
subplot(2,3,3)
        ylabel(['N Male c9orf TG breeding animals = ' num2str(size(unique(Male_c9_TG_B)))])
        xlabel(['N Male c9orf TG breeding weights = ' num2str(Rows(Male_c9_TG_B))])
        set(gca,'XTick',[],'YTick',[])%current axis or x and y
        set(gca,'Color',[.75 .75 .75])
%% 
%Figure 2 (Male C9orf NT)

subplot(2,3,4)
  NB_Male_c9_NT= plot (x(2,:), y(2,:), X_edges(11:12, :),Y_edges(11:12, :), 'r--o');
  hold on;
  B_Male_c9_NT = plot (x(6,:), y(6,:), X_edges(3:4, :),Y_edges(3:4, :), 'b--o');


title('Average monthly weight, Nonbreeders vs Breeders Male C9orf NT');
xlabel('Age (months)');
ylabel('Weight (g)');
legend('NonBreeder Male C9orf NT', 'Breeder Male C9orf NT', ...
    'Location','Southeast');
set(gca,'XLim',[1 19]);
ylim([5 50]);


subplot(2,3,5)

        ylabel(['N Male c9orf NT nonbreeding animals = ' num2str(size(unique(Male_c9_NT_non)))])
        xlabel(['N Male c9orf NT nonbreeding weights = ' num2str(Rows(Male_c9_NT_non))])
        set(gca,'XTick',[],'YTick',[])%current axis or x and y
        set(gca,'Color',[.75 .75 .75])
subplot(2,3,6)
        ylabel(['N Male c9orf Nt breeding animals = ' num2str(size(unique(Male_c9_NT_B)))])
        xlabel(['N Male c9orf NT breeding weights = ' num2str(Rows(Male_c9_NT_B))])
        set(gca,'XTick',[],'YTick',[])%current axis or x and y
        set(gca,'Color',[.75 .75 .75])
%% 
        
%Figure 3 (Female C9orf TG)
        
figure;
subplot(2,3,1)
  NB_Female_c9_TG= plot (x(3,:), y(3,:), X_edges(13:14, :),Y_edges(13:14, :), 'r--o');
  hold on;
  B_Female_c9_TG = plot (x(7,:), y(7,:), X_edges(5:6, :),Y_edges(5:6, :), 'b--o');


title('Average monthly weight, Nonbreeders vs Breeder Female C9orf TG');
xlabel('Age (months)');
ylabel('Weight (g)');
legend('NonBreeder Female C9orf TG', 'Breeder Female C9orf TG', ...
    'Location','Southeast');
set(gca,'XLim',[1 19]);
ylim([5 50]);


subplot(2,3,2)

        ylabel(['N Female c9orf TG nonbreeding animals = ' num2str(size(unique(Female_c9_TG_non)))])
        xlabel(['N Female c9orf TG nonbreeding weights = ' num2str(Rows(Female_c9_TG_non))])
        set(gca,'XTick',[],'YTick',[])%current axis or x and y
        set(gca,'Color',[.75 .75 .75])
subplot(2,3,3)
        ylabel(['N Female c9orf TG breeding animals = ' num2str(size(unique(Female_c9_TG_B)))])
        xlabel(['N Female c9orf TG breeding weights = ' num2str(Rows(Female_c9_TG_B))])
        set(gca,'XTick',[],'YTick',[])%current axis or x and y
        set(gca,'Color',[.75 .75 .75])
%% 
%Figure 4 ( Female c9orf NT)
               
subplot(2,3,4)

  NB_Female_c9_NT= plot (x(4,:), y(4,:), X_edges(15:16, :),Y_edges(15:16, :), 'r--o');
  hold on;
  B_Female_c9_NT = plot (x(8,:), y(8,:), X_edges(7:8, :),Y_edges(7:8, :), 'b--o');


title('Average monthly weight, Nonbreeders vs Breeder Female C9orf NT');
xlabel('Age (months)');
ylabel('Weight (g)');
legend('NonBreeder Female C9orf NT', 'Breeder Female C9orf NT', ...
    'Location','Southeast');
set(gca,'XLim',[1 19]);
ylim([5 50]);


subplot(2,3,5)

        ylabel(['N Female c9orf NT nonbreeding animals = ' num2str(size(unique(Female_c9_NT_non)))])
        xlabel(['N Female c9orf Nt nonbreeding weights = ' num2str(Rows(Female_c9_NT_non))])
        set(gca,'XTick',[],'YTick',[])%current axis or x and y
        set(gca,'Color',[.75 .75 .75])
subplot(2,3,6)
        ylabel(['N Female c9orf NT breeding animals = ' num2str(size(unique(Female_c9_NT_B)))])
        xlabel(['N Female c9orf NT breeding weights = ' num2str(Rows(Female_c9_NT_B))])
        set(gca,'XTick',[],'YTick',[])%current axis or x and y
        set(gca,'Color',[.75 .75 .75])


