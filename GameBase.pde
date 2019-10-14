World world;



void setup() {
  size(1000, 800);
  frameRate(60);
  world = new World();
}

void draw() {
  world.update();
  world.draw();
}


void restart() {
  world = new World();
}



void mousePressed() {
  if (mouseButton == LEFT)
    world.player.MousePressed();
}

void mouseReleased() {
  if (mouseButton == LEFT)
    world.player.MouseReleased();
}


void keyPressed() {
  switch(key) {
  case 'a':
    world.player.KeyPressed('a');
    break;
  case 'd':
    world.player.KeyPressed('d');
    break;
  case 'w':
    world.player.KeyPressed('w');
    break;
  case 's':
    world.player.KeyPressed('s');
    break;
  case 'r':
    restart();
    break;
  }
}
void keyReleased() {
  switch(key) {
  case 'a':
    world.player.KeyReleased('a');
    break;
  case 'd':
    world.player.KeyReleased('d');
    break;
  case 'w':
    world.player.KeyReleased('w');
    break;
  case 's':
    world.player.KeyReleased('s');
    break;
  }
}
