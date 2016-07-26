function write_sdf(sdf_path, heightmap, tree_pos, heightmap_name, arena_size)

fp = fopen(sdf_path, 'w');

fprintf(fp, [ ...
'<?xml version="1.0" ?>\n' ...
'<sdf version="1.5">\n ' ...
'    <model name="heightmap">\n ' ...
'      <static>true</static>\n ' ...
'      <link name="link">\n ' ...
'        <collision name="collision">\n ' ...
'          <geometry>\n ' ...
'            <heightmap>\n ' ...
'              <uri>model://heightmap/materials/textures/%s</uri>\n ' ...
'              <size>%d %d %d</size>\n ' ...
'              <pos>0 0 0</pos>\n ' ...
'            </heightmap>\n ' ...
'          </geometry>\n  ' ...
'        </collision>\n   ' ...
'        <visual name="visual_abcedf">\n ' ...
'          <geometry>\n   ' ...
'            <heightmap>\n ' ...
'              <use_terrain_paging>false</use_terrain_paging>\n ' ...
'              <texture>\n ' ...
'                <diffuse>file://media/materials/textures/dirt_diffusespecular.png</diffuse>\n ' ...
'                <normal>file://media/materials/textures/flat_normal.png</normal>\n ' ...
'                <size>1</size>\n ' ...
'              </texture>\n ' ...
'              <texture>\n ' ...
'                <diffuse>file://media/materials/textures/grass_diffusespecular.png</diffuse>\n ' ...
'                <normal>file://media/materials/textures/flat_normal.png</normal>\n ' ...
'                <size>1</size>\n ' ...
'              </texture>\n ' ...
'              <texture>\n ' ...
'                <diffuse>file://media/materials/textures/fungus_diffusespecular.png</diffuse>\n ' ...
'                <normal>file://media/materials/textures/flat_normal.png</normal>\n ' ...
'                <size>1</size>\n ' ...
'              </texture>\n ' ...
'              <blend>\n ' ...
'                <min_height>2</min_height>\n ' ...
'                <fade_dist>5</fade_dist>\n ' ...
'              </blend>\n ' ...
'              <blend>\n  ' ...
'                <min_height>4</min_height>\n ' ...
'                <fade_dist>5</fade_dist>\n ' ...
'              </blend>\n ' ...
'              <uri>model://heightmap/materials/textures/%s</uri>\n ' ...
'              <size>%d %d %d</size>\n ' ...
'              <pos>0 0 0</pos>\n ' ...
'            </heightmap>\n ' ...
'          </geometry>\n ' ...
'        </visual>\n ' ...
'      </link>\n' ], ...
    heightmap_name, arena_size(1), arena_size(2), arena_size(3), ...
    heightmap_name, arena_size(1), arena_size(2), arena_size(3));

for i=1:size(tree_pos, 1)
%    fprintf(fp, '\t<model name="tree%d">\n', i) ;
   x_pos = (tree_pos(i, 1) - arena_size(1) / 2);
   y_pos = (tree_pos(i, 2) - arena_size(2) / 2);
   radius = 0.33;
   length = 15;
   x_pos_int = min(size(heightmap, 2), max(1, round(tree_pos(i, 1) / arena_size(1) * size(heightmap, 2))));
   y_pos_int = min(size(heightmap, 1), max(1, round(tree_pos(i, 2) / arena_size(2) * size(heightmap, 1))));
   
   fprintf(fp, '\t\t<link name="tree%d">\n', i);
   fprintf(fp, '\t\t<pose> %f %f %f 0 0 0</pose>\n', x_pos, -y_pos, double(heightmap(y_pos_int, x_pos_int)) / 255.0 * arena_size(3));
      fprintf(fp, '\t\t\t<collision name="collision">\n');
   fprintf(fp, '\t\t\t\t<geometry>\n');
   fprintf(fp, '\t\t\t\t\t<cylinder>\n');
   fprintf(fp, '\t\t\t\t\t\t<radius>%f</radius>\n', radius);
   fprintf(fp, '\t\t\t\t\t\t<length>%f</length>\n', length);
   fprintf(fp, '\t\t\t\t\t</cylinder>\n');
   fprintf(fp, '\t\t\t\t</geometry>\n');
   fprintf(fp, '\t\t\t</collision>\n');
   
   fprintf(fp, '\t\t\t<visual name="visual">\n');
   fprintf(fp, '\t\t\t\t<geometry>\n');
   fprintf(fp, '\t\t\t\t\t<cylinder>\n');
   fprintf(fp, '\t\t\t\t\t\t<radius>%f</radius>\n', radius);
   fprintf(fp, '\t\t\t\t\t\t<length>%f</length>\n', length);
   fprintf(fp, '\t\t\t\t\t</cylinder>\n');
   fprintf(fp, '\t\t\t\t</geometry>\n');
   fprintf(fp, '\t\t\t\t<material>\n');
   fprintf(fp, '\t\t\t\t\t<ambient>1 0 0 1</ambient>\n');
   fprintf(fp, '\t\t\t\t\t<diffuse>1 0 0 1</diffuse>\n');
   fprintf(fp, '\t\t\t\t</material>\n');
   fprintf(fp, '\t\t\t</visual>\n');
   fprintf(fp, '\t\t</link>\n');
%    fprintf(fp, '\t</model>\n');
end

fprintf(fp, '\t</model>\n');
fprintf(fp, '</sdf>\n');

fclose(fp);
             
    
    
    