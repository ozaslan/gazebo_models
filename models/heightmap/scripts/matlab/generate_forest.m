% clear all;
close all;
clc;


heightmap_name = 'output00.png';
heightmap_path = ['../../materials/textures/' heightmap_name];

arena_size = [200; 200; 100]; % in meters
num_trees = 100;

heightmap = imread(heightmap_path);
imshow(heightmap);

c = clock;
rng(c(end));
tree_pos = rand(num_trees, 2) .* repmat(arena_size(1:2)', [num_trees, 1]);

hold on;
plot(tree_pos(:, 1) * size(heightmap, 2) / arena_size(1), ...
     tree_pos(:, 2) * size(heightmap, 1) / arena_size(2), ...
     '*');

sdf_path = '../../model.sdf';

write_sdf(sdf_path, heightmap, tree_pos, heightmap_name, arena_size);
