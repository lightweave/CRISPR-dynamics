
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Compute Time Iterations
% Clones with deleted spacers cant go past F1 (accumulate in F1)
% Bacteria that adds more than N spacers is considered old and dies
% Average deleted spacers from clones \mu_{\delta}(i)=S_{L}i
% All bacteria breeds A2=cloning, A1=virus interaction. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clf;
clear all
close all;

N=1000; %Maxumum number of spacers
ii=1:N;
fu=1; 
    

p=0.6;
h=1;
s=0.4; %probability of survival if no spacer 
g=1; %probability of survival with the bad spacer  
SL=1/3;
nu=1/20;
mnu=nu;
ku=100*mnu; 

%Nu_i=1-(ii-1)/N;
qi=1./(1+exp(-0.01*(ii-500)));

for ki=1:5
if (ki==1)
b=300;
end
if (ki==2)
b=200;
end
if (ki==3)
b=300;
end
if (ki==4)
b=400;
end
if (ki==5)
b=500;
end
if (ki==6)
h=0.5;
end
if (ki==7)
h=0.4;
end

Nu_i=exp(-((ii-1).^2)/(2*b^2));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%--------------- Di probability of death-----------------------------------
Di=p*((1-qi)*(1-s)+qi*(1-h)*(1-g)); %D(i) probability of death
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%------------- Q(i,j) probability of gaining j-i spacers-------------------
Q=Qij(qi,p,s,h,g,N,nu,ku,mnu);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

MuD=mu_d(N,fu,SL); % average depends on number od spacers present
L=Lij(MuD,N);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% -------------Si is the fraction of Fi that stays in Fi------------------- 
Si1=Stay1(p,N);
Si2=Stay2(Nu_i,MuD,N);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%----------------------Prob. of clones loosing spacers---------------------
Del=DeLij(Nu_i,N,L);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ---------Iteration Matrix A1---------------------------------------------
% ---Bacteria-Virus Interaction (Spacer Gain)
A1=matrixA1(N,Si1,Q);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% INITIAL CONDITIONS
%F=zeros(N,1);
%F(1:1)=100*ones(800,1);
%F(1)=1000000;
F=1000*ones(N,1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% save movie
%   writerObj=VideoWriter('gaus1.avi');
%   writerObj.FrameRate = 30; % Frames per second
%   open(writerObj);

for n=1:3000
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% First Half-Iteration 
Fh=A1*F; %Spacer gain and distribution to new classes
% Second Half-Iteration
% Ballance death and new cloning 
alph=Alpha(p,s,h,g,nu,ku,mnu,N,qi,Nu_i,F,Fh);
alph
% Scale Nu_i so that population does not die out or explode
Si2=Stay2((alph*Nu_i),MuD,N);
Del=DeLij((alph*Nu_i),N,L);
A2=matrixA2(N,Si2,Del);
F=A2*Fh; 
sum(F)
        
% Plot particuar final cases
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%      hold all
%      if (n==2000)
%         % Get PowerLaw     
%         %[a, b] = my_powerLawFit(F(imin:imax)', ii(imin:imax)); 
%         figure(1)
%         %subplot(2,1,1)
%         plot(ii, F/(sum(F)),'DisplayName', ['\mu_{n}= ' num2str(1/nu) ', S_{L}=' num2str(SL)]); 
%         
%         %plot(ii(start:N), F(start:N)/(sum(F(imin:N))),'DisplayName', ['\mu_{n}= ' num2str(1/nu) ', S_{L}=' num2str(SL) ', g=' num2str(g)]); 
%         %plot(ii(imin:N),(F(imin)/(sum(F(imin:N))*imin^b))*ii(imin:N).^b,'--','DisplayName', ['\alpha= ' num2str(b)] ); %hold on        
%         
%         %plot(ii, F/(sum(F))); 
%         %plot(ii,F/(sum(F)),'o',ii,PLnorm(ii)); 
%         set(gca, 'Xscale', 'log');
%         set(gca, 'Yscale', 'log');
%         grid on
%         title(['p=',num2str(p),', h=',num2str(h),', s=',num2str(s),', g=',num2str(g),', N=1000.']);
%         xlabel('log(i)');
%         ylabel('log(F(i))'); 
%         legend('off'); legend('show');
%      end   
% Plot time evolution %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    if (mod(n,10)==0)
        figure(1);
        subplot(2,1,1)
        plot(ii, F/(sum(F))); 
        set(gca, 'Xscale', 'log');
        set(gca, 'Yscale', 'log');
        grid on
        title(['p=',num2str(p),', h=',num2str(h),', s=',num2str(s),', g=',num2str(g),', N=1000.']);
        xlabel('log(i)');
        ylabel('log(F(i))'); 
        
        subplot(2,1,2)
        plot(ii,F); 
        title(['Histogram. Initial Conditions: F_{1}(0)=10,000, F_{i}(0)=0 for i=2,...,100. Iteration =',num2str(n)]);
        xlabel('i (Number of Spacers)');
        ylabel('F(i)');  
        pause(0.0001);
    end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%         
%         frame=getframe(gcf);
%         writeVideo(writerObj,frame);
%         
end

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record data to array %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            if (ki==1)
 %           F=100*F; 
             fp=fopen('LG1.txt','a');
                 for jj=2:N
                     fprintf(fp,'%d ', jj*ones(1,round(F(jj))));
                 end
             fclose(fp);
             end
% %             
             if (ki==2)
%             F=100*F; 
             fp=fopen('LG2.txt','a');
                for jj=2:N
                     fprintf(fp,'%d ', jj*ones(1,round(F(jj))));
                end
             fclose(fp);
             end

            if (ki==3)
            fp=fopen('LG3.txt','a');
               for jj=2:N
                    fprintf(fp,'%d ', jj*ones(1,round(F(jj))));
               end
            fclose(fp);
            end 
            
            if (ki==4)
            fp=fopen('LG4.txt','a');
               for jj=2:N
                    fprintf(fp,'%d ', jj*ones(1,round(F(jj))));
               end
            fclose(fp);
            end 
            
            if (ki==5)
            fp=fopen('LG5.txt','a');
               for jj=2:N
                    fprintf(fp,'%d ', jj*ones(1,round(F(jj))));
               end
            fclose(fp);
            end 
            
            if (ki==6)
            fp=fopen('VarH6.txt','a');
               for jj=2:N
                    fprintf(fp,'%d ', jj*ones(1,round(F(jj))));
               end
            fclose(fp);
            end
            
            if (ki==7)
            fp=fopen('VarH7.txt','a');
               for jj=2:N
                    fprintf(fp,'%d ', jj*ones(1,round(F(jj))));
               end
            fclose(fp);
            end

 % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   

end
legend(gca,'show')


%        figure(1)
%        subplot(2,1,1)
%        plot(ii,PLnorm1(ii),'--',ii,PLnorm2(ii),'--'); %hold on% Normalised
%        set(gca, 'Xscale', 'log');
%        set(gca, 'Yscale', 'log'); %log log
%        grid on
%        title('N=1000');
%        xlabel('log(i)');
%        ylabel('log(F(i))'); 
%        hold on 
        

        figure(2)
        plot(ii,Nu_i,ii,qi);
       
%         CC=0.2;
%         figure(1)
%         subplot(2,1,1)
%         plot(ii,CC*(ii.^(-alph)).*exp(-ii*lam)); %hold on% Normalised
%         set(gca, 'Xscale', 'log');
%         set(gca, 'Yscale', 'log'); %log log
%         grid on
%         title(['N=100, q=i/N, s=',num2str(s),', p=',num2str(p), ', \mu_{n}= 1/3']);
%         xlabel('log(i)');
%         ylabel('log(F(i))'); 
%         hold on
        
 
% hold off
% close(writerObj);


