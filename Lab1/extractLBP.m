function database = extractLBP(img,r,b)

if r == 3
    
    x=zeros(28,1);
    y=zeros(1,30);
    
    %On entoure la matrice img d'une ligne et d'une colonne de 0 
    %->Matrice 30x30
    imglecture=[x,img,x];
    imglecture=[y;imglecture;y]; 
    puiss=[1 2 4;128 0 8;64 32 16];
    
    for i= 2:1:29
        for j=2:1:29
            A=imglecture(i-1:i+1,j-1:j+1);
            img(i-1,j-1)=sum(sum((imglecture(i-1:i+1,j-1:j+1)>imglecture(i,j)).*puiss));
       end 
    end
    
               
elseif r==5
    x=zeros(28,1);
    y=zeros(1,30);
    imglecture=[x,img,x];
    imglecture=[y;imglecture;y];
    x=zeros(30,1);
    y=zeros(1,32);
    imglecture=[x,imglecture,x];
    imglecture=[y;imglecture;y];
    puiss=[1 2 4 8 16;32768 0 0 0 32;16384 0 0 0 64;8192 0 0 0 128;4096 2048 1024 512 256];
    for i= 3:1:29
        for j=3:1:29
            img(i-1,j-1)=sum(sum((imglecture(i-2:i+2,j-2:j+2)>imglecture(i,j)).*puiss));
            
       end 
    end
    
    
end
%display(img);
%colormap( gray );
%imagesc( img );
mzero=zeros(1,((28/b)^2)*128);
indice=0;
%display(max(max(img)));
for i= 1:b:28
        for j=1:b:28
            indice=indice+128;
            m=img(i:i+b-1,j:j+b-1);
            m=m(:);
            mzero(indice-127:indice)=hist(m,128)
        end
        
end

database=mzero;


            
            
end 
