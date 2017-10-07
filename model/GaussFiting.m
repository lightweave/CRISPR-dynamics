
clf;
clear all


N=1000; %Maxumum number of spacers
ii=1:N;
fu=1; 
f = @(x, mu, sigma) exp(-0.5*((x-mu)/sigma).^2)/sigma/sqrt(2*pi);
%if (ki==1)
%Linear Q Liner Nu
    p=1;
    h=1; %probability of survival if has a spacer 
    s=0.2; %probability of survival if no spacer 
    g=1; %probability of survival with the bad spacer  
    nu=1/5;
    mnu=nu;
    ku=100*mnu;
qi=0.5*ones(1,N);
Nu_i=ones(1,N);
for ki=1:4
   SL=1/(ki*4);

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
%F(1)=100000;
F=1000*ones(N,1);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% save movie
%   writerObj=VideoWriter('gaus1.avi');
%   writerObj.FrameRate = 30; % Frames per second
%   open(writerObj);

for n=1:1000
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
        
  
% Plot time evolution %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%     if (mod(n,10)==0)
%      muG=sum(ii.*F')/sum(F);
%      sigma=0;
%      for i=1:N
%          sigma=sigma+F(i)*(i-muG)^2;
%      end
%      sigma=sqrt(sigma/(sum(F)-1));
%         figure(1);
%         plot(ii,F/sum(F), ii, f(ii,muG,sigma),'-'); 
%         title(['Iterations:',num2str(n)]);
%         xlabel('i (Number of Spacers)');
%         ylabel('F(i)');  
%         pause(0.0001);
%     end
 % Plot particuar final cases
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
      hold all
     if (n==1000)
%         % Get PowerLaw     
%         %[a, b] = my_powerLawFit(F(imin:imax)', ii(imin:imax)); 
     muG=sum(ii.*F')/sum(F);
     sigma=0;
     for i=1:N
         sigma=sigma+F(i)*(i-muG)^2;
     end
     sigma=sqrt(sigma/(sum(F)-1));
% L-inf norm
    %LN=max(abs((F/sum(F))-f(ii,muG,sigma)))

        figure(1);
        plot(ii,F/sum(F),'DisplayName', ['S_{L}= ' num2str(SL) ', \mu_{Gauss}=' num2str(muG) ', \sigma_{Gauss}= ' num2str(sigma)]); 
        plot(ii, f(ii,muG,sigma),'--'); %,'DisplayName', ['\mu_{Gauss}= ' num2str(muG) ', \sigma_{Gauss}=' num2str(sigma)]);
        title(['Iterations:',num2str(n)]);
        xlabel('i (Number of Spacers)');
        ylabel('F(i)');  
        %pause(0.0001);
        grid on
        title(['p=',num2str(p),', h=',num2str(h),', s=',num2str(s),', g=',num2str(g),', N=1000.']);
        xlabel('i');
        ylabel('F(i)'); 
        legend('off'); legend('show');


%subplot(2,1,1)
%        plot(ii(start:N), F(start:N)/(sum(F(imin:N))),'DisplayName', ['\mu_{Gauss}= ' num2str(muG) ', \sigma_{Gauss}=' num2str(sigma)]); 
%         
%         %plot(ii(start:N), F(start:N)/(sum(F(imin:N))),'DisplayName', ['\mu_{n}= ' num2str(1/nu) ', S_{L}=' num2str(SL) ', g=' num2str(g)]); 
%         %plot(ii(imin:N),(F(imin)/(sum(F(imin:N))*imin^b))*ii(imin:N).^b,'--','DisplayName', ['\alpha= ' num2str(b)] ); %hold on        
%         
        %plot(ii, F/(sum(F))); 
        %plot(ii,F/(sum(F)),'o',ii,PLnorm(ii)); 
        %set(gca, 'Xscale', 'log');
        %set(gca, 'Yscale', 'log');

      end    
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%         
%         frame=getframe(gcf);
%         writeVideo(writerObj,frame);
%         

end

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Record data to array %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%             if (ki==1)
%             F=10*F; 
%             fp=fopen('LinLinA7.txt','a');
%                 for jj=2:N
%                     fprintf(fp,'%d ', jj*ones(1,round(F(jj))));
%                 end
%             fclose(fp);
%             end
%             
%             if (ki==2)
%             F=100*F; 
%             fp=fopen('LinExpA4.txt','a');
%                for jj=2:N
%                     fprintf(fp,'%d ', jj*ones(1,round(F(jj))));
%                end
%             fclose(fp);
%             end
%             
%             if (ki==3)
%             F=100*F; 
%             fp=fopen('LinGausA4a.txt','a');
%                for jj=2:N
%                     fprintf(fp,'%d ', jj*ones(1,round(F(jj))));
%                end
%             fclose(fp);
%             end 
%             
%             if (ki==4)
%             F=1000*F; 
%             fp=fopen('GausLogisA4.txt','a');
%                for jj=2:N
%                     fprintf(fp,'%d ', jj*ones(1,round(F(jj))));
%                end
%             fclose(fp);
%             end
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


