void pathlabel(picture pic = currentpicture, Label L, path g,
real position=0.5, align align=NoAlign, bool sloped=false,
pen p=currentpen, filltype filltype=NoFill) {
  Label L2 = Label(L, align, p, filltype,
      position=Relative(position));
  if (sloped) {
    pair direction = dir(g, reltime(g, position));
    real angle = degrees(atan2(direction.y, direction.x));
    L2 = rotate(angle)*L2;
  }
  label(pic, L2, g);
}

path[][] draw_grid(int[] ngrid, real[] canvas_size, pen box_pen,
                   path[] fill_paths, pen fill_pen) {

  path grid_paths[][] = new path[ngrid[0]][ngrid[1]];
  transform my_scale = scale(canvas_size[0] / ngrid[0], canvas_size[1] / ngrid[1]);

  draw(my_scale * box((0.0, 0.0), (ngrid[0], -ngrid[1])), box_pen);

  for (int ni = 0; ni <= ngrid[0]-1; ++ni) {
    for (int nj = 0; nj <= ngrid[1]-1; ++nj) {
      path p = my_scale * shift(1.0*nj, -1.0*ni) * box((0.0, 0.0), (1.0, -1.0));
      draw(p, box_pen);
      grid_paths[ni][nj] = p;
      for (int np = 0; np <= fill_paths.length - 1 ; ++np) {
        real[] positions = intersect(p, fill_paths[np]);
        if (positions.length > 0) {
          fill(p, fill_pen);
        }
      }
    }
  }
  return grid_paths;
}
