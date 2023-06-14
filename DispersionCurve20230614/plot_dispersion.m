function plot_dispersion(info,data,T,fmax,dim)
dim=assignN(dim);
dt   = 1/(2*fmax) ;
tn=T/dt;

N=info(dim);
for q = 1:N
    for w = 1:tn
        mx(w,q)=data(dim,q,1,1,w);
    end
end

mkx=fft2(mx(:,1:N));mkx2=fftshift(mkx);amp=abs(mkx2);
 figure(1);
 ran=max(max(amp));
xt=info(4);
  imagesc([-pi/xt,pi/xt],[-fmax,fmax],amp);colorbar;



end