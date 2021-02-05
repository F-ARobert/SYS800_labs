function database = extractLBP(img,r,b)

if r == 3
    
    x=zeros(28,1);
    y=zeros(1,30);
    
    %On entoure la matrice img d'une ligne et d'une colonne de 0 
    %->Matrice 30x30
    imglecture=[x,img,x];
    imglecture=[y;imglecture;y]; 
    puiss=[1 2 4 8 16 32 64 128];
    
    for i= 2:1:29
        for j=2:1:29
            A=imglecture(i-1:i+1,j-1:j+1);
            B=[A(1,1), A(1,2), A(1,3), A(2,3), A(3,3), A(3,2),A(3,1),A(2,1)];
            img(i-1,j-1)=sum(sum((B>imglecture(i,j)).*puiss))
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
    puiss=[1 2 4 8 16 32 64 128 256 512 1024 2048 4096 8192 16384 32768];
    for i= 3:1:29
        for j=3:1:29
            A=imglecture(i-2:i+2,j-2:j+2);
            B=[A(1,1), A(1,2), A(1,3), A(1,4), A(1,5), A(2,5), A(3,5), A(4,5), A(5,5), A(5,4), A(5,3), A(5,2), A(5,1), A(4,1), A(3,1), A(2,1)]
            img(i-1,j-1)=sum(sum((B>imglecture(i,j)).*puiss));
            
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
