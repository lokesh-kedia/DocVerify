function sim=spacing(Image2DmatrixBW)

Image2DmatrixBW=imread(Image2DmatrixBW);
level=graythresh(Image2DmatrixBW);
Image2DmatrixBW=im2bw(Image2DmatrixBW,level);

%for i=1:size(Image2DmatrixBW,2)
 %%if(i~=size(Image2DmatrixBW,2) && sum(Image2DmatrixBW(:,i)) == size(Image2DmatrixBW,1) )
 % if(sum(Image2DmatrixBW(:,i+1)) == size(Image2DmatrixBW,1))
%Image2DmatrixBW(:,i)=[];
%size(Image2DmatrixBW)
%i
%i=i-1
%end;
%end;
%size(Image2DmatrixBW,2)--
%end;
%imshow(Image2DmatrixBW)
%while sum(Image2DmatrixBW(1,:)) == size(Image2DmatrixBW,2)
%%Image2DmatrixBW(1,:)=[];
%end;
%while sum(Image2DmatrixBW(:,end)) == size(Image2DmatrixBW,1)
%Image2DmatrixBW(:,end)=[];
%end;
%$while sum(Image2DmatrixBW(end,:)) == size(Image2DmatrixBW,2)
%Image2DmatrixBW(end,:)=[];
%end;
%size(Image2DmatrixBW)
i=1;
while i<size(Image2DmatrixBW,2)
if sum(Image2DmatrixBW(:,i)) == size(Image2DmatrixBW,1)
  if sum(Image2DmatrixBW(:,i+1)) == size(Image2DmatrixBW,1)
Image2DmatrixBW(:,i)=[];
end;
end;
i++;
end;
%imshow(Image2DmatrixBW)
%size(Image2DmatrixBW)

endfunction