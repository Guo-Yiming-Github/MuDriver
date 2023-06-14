function [info,data] = read_ovf(dir,tn_b,tn_e)
% Process the input parameter
% First read the info：
m = fopen(dir+'000000.ovf','r'); % Assign the fileID for 0 File
i=0;
while i<=28
    fileline=fgetl(m);
    if strncmp(fileline,'# xnodes',8)==1
        xnodes=textscan(fileline,'%s %s %d');
        Nx=xnodes{3};
    end
    if strncmp(fileline,'# ynodes',8)==1
        ynodes=textscan(fileline,'%s %s %d');
        Ny=ynodes{3};
    end
    if strncmp(fileline,'# znodes',8)==1
        znodes=textscan(fileline,'%s %s %d');
        Nz=znodes{3};
    end

    if strncmp(fileline,'# xsteps',8)==1
        xstep=textscan(fileline,'%s %s %f');
        cx=xstep{3};
    end

    if strncmp(fileline,'# ysteps',8)==1
        ystep=textscan(fileline,'%s %s %f');
        cy=ystep{3};
    end

    if strncmp(fileline,'# zsteps',8)==1
        zstep=textscan(fileline,'%s %s %f');
        cz=zstep{3};
    end
    i=i+1;
end

fclose(m);
% Read the data one by one inside the range input, include both the begin
% and end
info=[Nx,Ny,Nz,cx,cy,cz]; %Info contain step number (x,y,z) and step widths (x,y,z)
Length = Nx*Ny*Nz;

t = tn_e-tn_b+1;% total number of t
%set up the container for the data
outputx = zeros(Nx,Ny,Nz,t);
outputy = zeros(Nx,Ny,Nz,t);
outputz = zeros(Nx,Ny,Nz,t);
for i = tn_b:tn_e

    m = fopen(dir+num2str(i,'%06d')+'.ovf','r');
    C = textscan(m,'%f %f %f','CommentStyle','#'); % Read the all number without comment
    status = fclose(m);

    if status == -1;disp('File conflicts!');end
    for jx = 1:Nx
        for jy = 1:Ny
            for jz = 1:Nz
                data(1,jx,jy,jz,i-tn_b+1) = C{1,1}((jz-1)*Nx*Ny+(jy-1)*Nx+jx);
                data(2,jx,jy,jz,i-tn_b+1) = C{1,2}((jz-1)*Nx*Ny+(jy-1)*Nx+jx);
                data(3,jx,jy,jz,i-tn_b+1) = C{1,3}((jz-1)*Nx*Ny+(jy-1)*Nx+jx);
            end
        end
    end
end

end

