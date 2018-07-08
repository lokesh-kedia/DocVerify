function x=divider(filename)
  rr=imread(filename);
  %rr=double(rr);
 %rr = rgb2ntsc(rr );
%rr  = rr(:,:,1);
%level=graythresh(rr);
%rr=im2bw(rr,level); 
  
  %rr=double(rr);
  
 % imshow(rr)
  
  
  
%{
i=1;
while i<size(rr,2)
if sum(rr(:,i)) == size(rr,1)
  if sum(rr(:,i+1)) == size(rr,1)
rr(:,i)=[];
end;
end;
i++;
end;
  %}
  
  
  
  
  [rows columns numofcolors]=size(rr);
  blockSizeR=floor(rows/1);
  blockSizeC=floor(columns/18);
  wholeBlockRows=floor(rows/blockSizeR);
  blockVectorR=[blockSizeR*ones(1,wholeBlockRows),rem(rows,blockSizeR)];
  wholeBlockCols=floor(columns/blockSizeC);
  blockVectorC=[blockSizeC*ones(1,wholeBlockCols),rem(columns,blockSizeC)];
  ca=mat2cell(rr,blockVectorR,blockVectorC,numofcolors);
  %imshow(ca{1,10});
  for j=1:1
  for i=1:18
  x(end+1,:)=imageTo20x20Gray(ca{j,i});
end;
end;
%{
load('X.mat');
load('y.mat');
for i=1:4
X(end+1,:)=x(i,:);
end;
for i=1:30
  for j=1:10
    if(j==10)
    y(end+1)=0;
    else
    y(end+1)=j;
    end;
  endfor
endfor
save ("C:/Users/Lokesh/Desktop/docverfy/X.mat", "X");
save ("C:/Users/Lokesh/Desktop/docverfy/y.mat", "y");
%}
%displayData(x);

endfunction
