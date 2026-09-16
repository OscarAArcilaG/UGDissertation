function SpecMQ()

global M GP FP TP ZZ TN GG SP

    set(M.fg, 'pointer', 'watch')
    drawnow;

    SP.ResD=zeros;
    SP.ResV=zeros;
    SP.ResA=zeros;
    SP.ResSV=zeros;
    SP.ResSA=zeros;
    for ii=1:length(TN.Tn)
        SP.tn=TN.Tn(ii);
        SP.wn=2*pi/SP.tn;
        SP.c=2*ZZ.Z/100*SP.wn;
        SP.k=SP.wn^2;
        [SP.u,SP.v,SP.a]=interpolation(1,SP.c,SP.k,-TP.mqSN*TP.PGA/GG.gg,0,0,1/GP.fs,length(TP.mqSN));
        SP.D=max(abs(SP.u));
        SP.V=max(abs(SP.v));
        SP.A=max(abs(SP.a));
        SP.SV=SP.wn*SP.D;
        SP.SA=SP.wn*SP.wn*SP.D;
        SP.ResD(ii)=SP.D;
        SP.ResV(ii)=SP.V;
        SP.ResA(ii)=SP.A;
        SP.ResSV(ii)=SP.SV;
        SP.ResSA(ii)=SP.SA;
    end

    set(M.fg, 'pointer', 'arrow');

    function [u,v,a]=interpolation(m,c,k,pt,uo,vo,dt,N)
        u=zeros;
        v=zeros;
        a=zeros;
        wn=sqrt(k/m);
        zita= c/(2*m*wn);
        wd=wn*sqrt(1- zita^2);
        p=pt;
        u(1)=uo;
        v(1)=vo;
        a(1)=(p(1)/m)-(2*zita*wn*v(1))-(wn^2)*u(1);
        A=exp(-zita*wn*dt)*(((zita*sin(wd*dt))/sqrt(1-(zita)^2))+cos(wd*dt));
        B=exp(-zita*wn*dt)*(sin(wd*dt)/wd);
        C=(1/k)* (((2*zita)/ (wn*dt)) + (exp(-zita*wn*dt)*(((((1- 2*(zita^2))/(wn*dt)) - (zita/sqrt(1 -(zita^2))))*sin(wd*dt)) -((1 +((2*zita)/(wn*dt)))*cos(wd*dt)))));
        D=(1/k)* ( (1-(2*zita/(wn*dt))) + (exp(-zita*wn*dt)*(((-1+2*(zita^2))/(wn*dt))*sin(wd*dt) +(2*zita/(wn*dt))*cos(wd*dt))));
        Apr=-exp(-zita*wn*dt)*(wn*sin(wd*dt)/sqrt(1 - zita^2));
        Bpr=exp(-zita*wn*dt)*(-zita*sin(wd*dt)/sqrt(1 - zita^2) + cos(wd*dt));
        Cpr=(1/k)* ((-1/ dt) + exp(-zita*wn*dt)*(((wn/sqrt(1 - zita^2)) + zita/(dt*sqrt(1 - zita^2)))*sin(wd*dt) +(1/dt)*cos(wd*dt)));
        Dpr=(1/(k*dt))*(1-exp(-zita*wn*dt)*((zita/sqrt(1 - zita^2))*sin(wd*dt) +cos(wd*dt)));
        for i=1:N-1
            u(i+1)= A*u(i)+B*v(i)+C*p(i)+D*p(i+1);
            v(i+1)= Apr*u(i)+Bpr*v(i)+Cpr*p(i)+Dpr*p(i+1);
            a(i+1)=(p(i+1)/m)-2*zita*wn*v(i+1)-(wn^2)*u(i+1);
        end
    end
end