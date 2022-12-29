% load data 
cd('/Users/cristinagarcia/Documents/MATLAB/apoes/ ');


%Extract data from all graphs, Mean 
x = []; 
y = []; 
dn = [];
graphz = [{'nonbreeder.fig'},{'breeder.fig'}]; 
for iGraphz = 1:length(graphz)
    openfig(graphz{iGraphz});
    a = get(gca);
    for iLine = 1:length(a.Children)
        x = [x; a.Children(iLine).XData(1:24)]; 
        y = [y; a.Children(iLine).YData(1:24)];
        dn = [dn {a.Children(iLine).DisplayName}];
    end
end

%% 
%Extracting hidden figures to get standard deviation 

X_edges= [];
Y_edges= [];
Apoes_Name_edge= [];

h = findall(groot, 'Tag', 'shadedErrorBar_edge');

for iLinez= 1:length(h)
    X_edges = [X_edges; h(iLinez).XData(1:24)];
    Y_edges = [Y_edges; h(iLinez).YData(1:24)];
    Apoes_Name_edge= [ Apoes_Name_edge; {h(iLinez).DisplayName}]; 
end 
%% 

% Figure 1 (Male Apoe 3)
figure;
%Nonbreeder standard deviation 
x_err_nb3= X_edges(3:4,:);
y_err_nb3= Y_edges(3:4,:);

%mean(x(3,:),y(3,:)

%Breeder standard deviation

%mean(x(8,:),y(8,:)

x_err_b3= X_edges(13:14,:);
y_err_b3= Y_edges(13:14,:);

%plot NB_M4(nonbreeder) x B_M3(breeder)
subplot (2,3,1)

  NB_M3= plot (x(3,:),y(3,:),x_err_nb3,y_err_nb3, 'r--o');
  hold on;
  B_M3 = plot (x(8,:),y(8,:),x_err_b3,y_err_b3 ,'b--o');
 

legend 
title('Average monthly weight, Nonbreeders vs Breeders Male Apoe3');
xlabel('Age (months)');
ylabel('Weight (g)');
legend( 'NonBreeder Female Apoe 3','Breeder Female Apoe 3', ...
    'Location','Southeast');
set(gca,'XLim',[1 25]);
ylim([0 70]);

subplot(2,3,2)

        ylabel(['N Male Apoe3 nonbreeding animals = ' num2str(size(unique(NB_Male_Apoe3)))])
        xlabel(['N Male Apoe3 breeding weights = ' num2str(Rows(NB_Male_Apoe3))])
        xlabel(['N Male Apoe3 nonbreeding weights = ' num2str(Rows(NB_Male_Apoe3))])
        set(gca,'XTick',[],'YTick',[])%current axis or x and y
        set(gca,'Color',[.75 .75 .75])
subplot(2,3,3)
        ylabel(['N Male Apoe3 breeding animals = ' num2str(size(unique(B_Male_Apoe3)))])
        xlabel(['N Male Apoe3 breeding weights = ' num2str(Rows(B_Male_Apoe3))])
        set(gca,'XTick',[],'YTick',[])%current axis or x and y
        set(gca,'Color',[.75 .75 .75])




%%       
       
% Figure 2 (Male Apoe 4)
%NonBreeder standard deviation
x_err_nb4= X_edges(1:2,:); 
y_err_nb4= Y_edges(1:2,:);

%mean= x(1,:),y(1,:);

%Breeder standard deviation 
x_err_b4= X_edges(9:10,:); 
y_err_b4= Y_edges(9:10,:);

%mean (7,:), y(7,:)

%plot NB_M4(nonbreeder) x B_M4(breeder)

subplot(2,3,4)


  NB_M4= plot (x(1,:), y(1,:),x_err_nb4,y_err_nb4, 'r--o');
  hold on;
  B_M4 = plot (x(7,:), y(7,:),x_err_b4,y_err_b4, 'b--o');
 
  title('Average monthly weight, Nonbreeders vs Breeders Male Apoe4');
xlabel('Age (months)');
ylabel('Weight (g)');
legend('NonBreeder Male Apoe4','Breeder Male Apoe4', ...
    'Location','Southeast');
set(gca,'XLim',[1 25]);
ylim([0 70]);


subplot(2,3,5)

        ylabel(['N Male Apoe4 nonbreeding animals = ' num2str(size(unique(NB_Male_Apoe4)))])
        xlabel(['N Male Apoe 4 nonbreeding weights = ' num2str(Rows(NB_Male_Apoe4))])
        set(gca,'XTick',[],'YTick',[])%current axis or x and y
        set(gca,'Color',[.75 .75 .75])
subplot(2,3,6)
        ylabel(['N Male Apoe4 breeding animals = ' num2str(size(unique(B_Male_Apoe4)))])
        xlabel(['N Male Apoe4 breeding weights = ' num2str(Rows(B_Male_Apoe4))])
        set(gca,'XTick',[],'YTick',[])%current axis or x and y
        set(gca,'Color',[.75 .75 .75])

%% 
%Figure 3 (Female Apoe 3 )
figure;

%NonBreeding standard deviation
x_err_nb3f= X_edges(7:8,:);
y_err_nb3f= Y_edges(7:8, :);
%mean= (x(6,:),y(6,:);
%Breeding standard deviation
x_err_b3f= X_edges(19:20, :);
y_err_b3f= Y_edges(19:20, :);
%mean= plot(x(10,:),y(10,:),'b--o');

subplot(2,3,1)
NB_F3= plot (x(6,:), y(6,:),x_err_nb3f,y_err_nb3f, 'r--o');
hold on;
B_F3 = plot (x(10,:), y(10,:),x_err_b3f,y_err_b3f ,'b--o');
title('Average monthly weight, Nonbreeders vs Breeders Female Apoe3');
xlabel('Age (months)');
ylabel('Weight (g)');
legend('NonBreeder Female Apoe3','Breeder Female Apoe3 ', ...
'Location','Southeast');
set(gca,'XLim',[1 25]);
ylim([0 70]);
subplot(2,3,2)
ylabel(['N Female Apoe3 nonbreeding animals = ' num2str(size(unique(NB_Female_Apoe3)))])
xlabel(['N Female Apoe3 nonbreeding weights = ' num2str(Rows(NB_Female_Apoe3))])
set(gca,'XTick',[],'YTick',[])%current axis or x and y
set(gca,'Color',[.75 .75 .75])

subplot(2,3,3)
ylabel(['N Female Apoe3 breeding animals = ' num2str(size(unique(B_Female_Apoe3)))])
xlabel(['N Female Apoe3 breeding weights = ' num2str(Rows(B_Female_Apoe3))])
set(gca,'XTick',[],'YTick',[])%current axis or x and y
set(gca,'Color',[.75 .75 .75])
%% 
%Figure 4 (Female Apoe 4)

%NonBreeding  standard deviation
x_err_nb4f= X_edges(5:6,:);
y_err_nb4f= Y_edges(5:6,:);
%mean= (x(4,:),y(4,:)
%Breeding  standard deviation
x_err_b4f= X_edges(15:16,:);
y_err_b4f= Y_edges(15:16,:);
%mean (9,:), y(9,:)
%plot NB_F4(nonbreeder) x B_F4(breeder)

subplot(2,3,4)
NB_F4= plot (x(4,:), y(4,:),x_err_nb4f,y_err_nb4f, 'r--o');
hold on;
B_F4 = plot (x(9,:), y(9,:),x_err_b4f,y_err_b4f ,'b--o');
title('Average monthly weight, Nonbreeders vs Breeders Female Apoe4');
xlabel('Age (months)');
ylabel('Weight (g)');
legend('NonBreeder Female Apoe4','Breeder Female Apoe4 ', ...
'Location','Southeast');
set(gca,'XLim',[1 25]);
ylim([0 70]);


subplot(2,3,5)
ylabel(['N Female Apoe4 nonbreeding animals = ' num2str(size(unique(NB_Female_Apoe4)))])
xlabel(['N Female Apoe4 nonbreeding weights = ' num2str(Rows(NB_Female_Apoe4))])
set(gca,'XTick',[],'YTick',[])%current axis or x and y
set(gca,'Color',[.75 .75 .75])

subplot(2,3,6)
ylabel(['N Female Apoe4 breeding animals = ' num2str(size(unique(B_Female_Apoe4)))])
xlabel(['N Female Apoe4 breeding weights = ' num2str(Rows(B_Female_Apoe4))])
set(gca,'XTick',[],'YTick',[])%current axis or x and y
set(gca,'Color',[.75 .75 .75])




 
