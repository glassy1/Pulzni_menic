%% Pulzni menic - Eulerova metoda reseni
% KEV/VEL2
% T. Glasberger, 
% 7. 10. 2021

%% Parametry obvodu
U0 = 100;
R = 1;
L=1e-3;

%% Parametry rizeni
z=0.8; % pomerne sepnuti
fpwm=1000; % spinaci frekvence (Hz)
tpwm=1/fpwm; % spinaci perioda

%% Parametry simulace (cas)
tmax=0.01; % konec simulace (s)
dt=1e-6; % krok simulace, krok vypoctu
t=0; % aktualni cas simulace
tper=0; %aktualni cas v ramci periody spinani

%% Pocatecni podminky
di=0; % derivace proudu (A)
i=0; % proud zatez (A)
uz=0; % napeti na zatezi (V)
iv=0;
%% Ulozeni vysledku
vysl=zeros(round(tmax/dt),4);
ix=0; % index, pomocna promenna pro ukladani vysledku

%% Hlavni casova smycka simulace
while t<tmax
    if(tper<=z*tpwm) % z*tpwm=T1
        V=1;
        V0=0;
    end
    if (tper>z*tpwm && tper<=tpwm)
        V=0;
        V0=1;
    end
    if(tper>tpwm)
        tper=0;
    end
    
    if V==1
        uz=U0;
        iv=i;
    end
    if V0==1
        uz=0;
        iv=0;
    end
    %% vypocet derivace a proudu dle Eulera
    di=1/L*(uz-R*i)*dt;
    i=i+di;
    
    %% Ukladani do pole vysledku
    ix=ix+1;
    vysl(ix,:)=[t,uz, i, iv];
    
    %% Zmena casu simulace
    tper=tper+dt;
    t=t+dt;
end

subplot(3,1,2);plot(vysl(:,1),vysl(:,3)); grid on;
subplot(3,1,1);plot(vysl(:,1),vysl(:,2)); grid on;
subplot(3,1,3);plot(vysl(:,1),vysl(:,4)); grid on;