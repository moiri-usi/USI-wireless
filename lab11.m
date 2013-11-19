img = load('r_image_10.mat');
demap_table = [1 0; 1 1; 0 1; 0 0];

bit = demap(img.r, demap_table);

img_bit8 = reshape(bit, 8, [])';
img_uint = uint8(bi2de(img_bit8));
img_m = reshape(img_uint, [], img.image_size(1))';

clf;
imageview(img_m);
