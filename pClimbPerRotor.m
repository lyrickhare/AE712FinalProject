function pClimb = pClimbPerRotor(THover,vC,ADisk,solidityRatio,rho,kappa,CdBlade,omega,R)
%PCLIMBPERROTOR Summary of this function goes here
%   Detailed explanation goes here
pClimb = ( kappa* THover * ( vC/2 + sqrt ( (vC/2)^2 + THover/(2*rho*ADisk) ) ) + rho*ADisk*(omega*R)^3* solidityRatio*CdBlade/8) ;

end

