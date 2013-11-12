img = load('r_image_10.mat');

bit2 = demap(img.r);

img_bit8 = reshape(bit2, 8, [])';
img_uint = uint8(bi2de(img_bit8));
img_m = reshape(img_uint, [], img.image_size(1))';
imshow(img_m);
