Img=imread('image.jpg');
cform = makecform('srgb2xyz');
col_img=applycform(Img,cform);
%figure;imshow(col_img);
thresh_img=graythresh(col_img(:,:,1));
bw_img=im2bw(col_img(:,:,2),thresh_img);
figure;imshow(bw_img);
bw4 = bwareaopen(bw_img,1250);
bw4=imclearborder(bw4);
SE = strel('rectangle',[5 20]);
SE1=strel('rectangle',[20 5]);
 bw4 = imdilate(bw4,SE);
% bw4 = imdilate(bw4,SE1);
 figure;imshow(bw4),title('');
cc=bwconncomp(bw4);
num=(cc.NumObjects);
labeledImage = bwlabel(bw4);
str = ['Number of Fishes : ',num2str(num)];
blobMeasurements = regionprops(labeledImage,'all');
numberOfPeople = size(blobMeasurements, 1);
figure
set(gcf, 'Position', get(0, 'ScreenSize'));
subplot(1,2,1),imshow(Img),title('Original');
subplot(1,2,2),imagesc(Img),title(str);
hold on;

for k = 1 : numberOfPeople % Loop through all blobs.

thisBlobsBox = blobMeasurements(k).BoundingBox; 
A = thisBlobsBox(1);
B = thisBlobsBox(2);
C = A + thisBlobsBox(3);
D = B + thisBlobsBox(4);
x = [A C C A A];
y = [B B D D B];
plot(x, y, 'LineWidth', 1);
end