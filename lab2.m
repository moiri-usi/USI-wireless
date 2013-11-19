lambda = 30;
demap_table = [1 0; 1 1; 0 1; 0 0];
sig = load('r_image_2_10.mat');

start_point = frame_sync(sig.r, lambda);

img_size = sig.image_size;
img = sig.r(start_point:start_point+img_size(1)*img_size(2)*4-1);

bit2 = demap(img, demap_table);

img_bit8 = reshape(bit2, 8, [])';
img_uint = uint8(bi2de(img_bit8));
img_m = reshape(img_uint, [], img_size(1))';
imshow(img_m);
