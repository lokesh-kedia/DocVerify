function [vectorImage] = imageTo20x20Gray_1(fc)
%IMAGETO20X20GRAY display reduced image and converts for digit classification
%
% Sample usage: 
%       imageTo20x20Gray('myDigit.jpg', 100, -1);
%
%       First parameter: Image file name
%             Could be bigger than 20 x 20 px, it will
%             be resized to 20 x 20. Better if used with
%             square images but not required.
% 
%       Second parameter: cropPercentage (any number between 0 and 100)
%             0  0% will be cropped (optional, no needed for square images)
%            50  50% of available croping will be cropped
%           100  crop all the way to square image (for rectangular images)
% 
%       Third parameter: rotStep
%            -1  rotate image 90 degrees CCW
%             0  do not rotate (optional)
%             1  rotate image 90 degrees CW
%
% (Thanks to Edwin Frühwirth for parts of this code)
%Image3DmatrixRGB=fileName;
%Image2DmatrixBW = imread(fileName);
%Image3DmatrixYIQ = rgb2ntsc(Image3DmatrixRGB );
%Image2DmatrixBW  = Image3DmatrixYIQ(:,:,1);
%Image2DmatrixBW  = im2bw(Image3DmatrixRGB);

%size(Image2DmatrixBW);


%{
%Image2DmatrixBW=fileName;
oldSize = size(Image2DmatrixBW);
cropDelta = floor((oldSize - min(oldSize)) .* (cropPercentage/100));
finalSize = oldSize - cropDelta;
cropOrigin = floor(cropDelta / 2) + 1;
copySize = cropOrigin + finalSize - 1;
croppedImage = Image2DmatrixBW( ...
                    cropOrigin(1):copySize(1), cropOrigin(2):copySize(2));                   
scale = [20 20] ./ finalSize;
newSize = max(floor(scale .* finalSize),1); 
rowIndex = min(round(((1:newSize(1))-0.5)./scale(1)+0.5), finalSize(1));
colIndex = min(round(((1:newSize(2))-0.5)./scale(2)+0.5), finalSize(2));
newImage = croppedImage(rowIndex,colIndex,:);
%level=graythresh(newImage);
%newImage=im2bw(newImage,level);
Image2DmatrixBW=newImage;




%to center the image
while sum(Image2DmatrixBW(:,1)) == size(Image2DmatrixBW,1)
Image2DmatrixBW(:,1)=[];
end;
while sum(Image2DmatrixBW(1,:)) == size(Image2DmatrixBW,2)
Image2DmatrixBW(1,:)=[];
end;
while sum(Image2DmatrixBW(:,end)) == size(Image2DmatrixBW,1)
Image2DmatrixBW(:,end)=[];
end;
while sum(Image2DmatrixBW(end,:)) == size(Image2DmatrixBW,2)
Image2DmatrixBW(end,:)=[];
end;
%}

%imshow(Image2DmatrixBW)
for k=1:size(fc,1)

Image2DmatrixBW=reshape(fc(k,:),15,15);


[rows cols]=size(Image2DmatrixBW);

size(Image2DmatrixBW);

colsPadding = [(ceil((28-cols)/2.0)),(floor((28-cols)/2.0))];
rowsPadding = [(ceil((28-rows)/2.0)),(floor((28-rows)/2.0))];


for i=1:colsPadding(1)
  Image2DmatrixBW = [zeros(rows,1) Image2DmatrixBW];
endfor
for i=1:colsPadding(2)
  Image2DmatrixBW = [Image2DmatrixBW zeros(rows,1)];
endfor
for i=1:rowsPadding(1)
  Image2DmatrixBW = [zeros(1,28);Image2DmatrixBW];
endfor
for i=1:rowsPadding(2)
  Image2DmatrixBW = [Image2DmatrixBW;zeros(1,28)];
endfor
size(Image2DmatrixBW);


newImage=Image2DmatrixBW;



%invertedImage = newImage;

%maxValue = max(invertedImage(:));
%minValue = min(invertedImage(:));
%delta = maxValue - minValue;
%normImage = (invertedImage - minValue) / delta;
contrastedImage = sigmoid((newImage -0.5) * 5);
%level=graythresh(contrastedImage);
%imshow(im2bw(contrastedImage,level))
%contrastedImage=round((contrastedImage.*100)./100);
%contrastedImage=im2bw(contrastedImage);
minv=min(contrastedImage(:));
contrastedImage(contrastedImage==minv)=0;
%out = min(setdiff(contrastedImage(:),min(contrastedImage(:))));
%contrastedImage(contrastedImage==out)=0;



[R C]=size(contrastedImage);
 props = regionprops(true(size(contrastedImage)), contrastedImage, 'WeightedCentroid');
 rowstoshift=round(R/2-props.WeightedCentroid(2));
 colstoshift=round(C/2-props.WeightedCentroid(1));
 shiftedImage = circshift(contrastedImage, [rowstoshift colstoshift]);
 contrastedImage=shiftedImage;
%imshow(contrastedImage, [-1, 1] );
vectorImage(k,:) = reshape(contrastedImage, 1, 784);
end;
%figure();
%displayData(vectorImage);
end
