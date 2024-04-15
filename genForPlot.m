function [mGTOWConv,mBatt,mRotor,mMotor,mAirFrame,eClimb,eCruise,eHover,R] = genForPlot(mPayload,rhoEnergyDensity,diskLoading,NRotors,lbyd,tCruise,vCr,winged)
% Shri Ganeshaya Namah
% @author Lyric Khare

% defining constants
n=10;%number of iterations
% mPayload = 10;
% rhoEnergyDensity = 720000; %watt-sec per kg or joules per kg
g = 9.81;
rho = 1.225;
% diskLoading = 250; % N per m^2
Nb=2;% number of blades
% NRotors = 12;
cBlade = 0.02; % blade of chord
CdBlade = 0.04;
omega = 10*2*pi; %angular velocity, radians per second
kappa = 1.15;


tHover = 20; % second
tClimb = 120; %second
% tCruise = 1500;%second


vC = 2.5; % meter per second
% vCr = 2.5; %meter per second

% lbyd = 10;


mGTOW = zeros(n,1);
mInit = 2*mPayload;
mGTOW(1)=mInit;
% R = zeros(n-1,1);

% eHover = zeros(n,1);
% eClimb = zeros(n,1);
% eCruise = zeros(n,1);
% mBatt = zeros(n,1);
% mRotor = zeros(n,1);
% mMotor = zeros (n,1);


for i = 1:1:(n-1)

    %Hover
    THoverPerRotor = mGTOW(i)*g/NRotors;
    R = sqrt(THoverPerRotor/diskLoading);
    ADisk = pi*(R)^2;
    solidityRatio = Nb*cBlade/(pi*(R)); % assuming rectangular blade
    pHover = NRotors* pClimbPerRotor(THoverPerRotor,0,ADisk,solidityRatio,rho,kappa,CdBlade,omega,(R));
    eHover = pHover*tHover;

    %climb
    pClimb = NRotors * pClimbPerRotor(THoverPerRotor,vC,ADisk,solidityRatio,rho,kappa,CdBlade,omega,(R));
    eClimb = pClimb*tClimb;

    %Cruise
    L = THoverPerRotor*NRotors;
    D = L/lbyd;
    if winged ==1
        TCruisePerRotor = sqrt(L^2+D^2)/NRotors;
        vCrC = vCr*cos(atan(lbyd));
        pCruise = NRotors*pClimbPerRotor(TCruisePerRotor,vCrC,ADisk,solidityRatio,rho,kappa,CdBlade,omega,(R));
        eCruise = pCruise*tCruise;
    else
        pCruise = D*vCr;
        eCruise = pCruise*tCruise;
    end
    pMax = max(pCruise,max(pClimb,pHover));

    mBatt = 1.1*(eCruise +eClimb +2*eHover)/rhoEnergyDensity;

    % mRotor = max(0.6818*R-0.1306,0);
    mRotor = 2*NRotors*0.0082*exp(6.8851*R);

    mAirFrame = 0.1*(mBatt+mPayload);

    mMotor = log(pMax)*0.1;

    mGTOW(i+1)=mPayload+mBatt+mRotor+mAirFrame+mMotor;

    tolerance = 1e-3;

    if(abs(mGTOW(i+1)-mGTOW(i))<tolerance)
        % plot(mGTOW(1:i+1),'r.-')
        % xlabel("no of iterations")
        % ylabel("mGTOW (kg)")
        % title("payload : " + mPayload + " kg")
        disp("Great Conv done")
        mGTOWConv = mGTOW(i+1);
        disp(mGTOWConv)
        break
    elseif (i==n-1)
        mGTOWConv = 0;
        disp("did not Conv")
        disp(mGTOWConv)
    end
end

end

