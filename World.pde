public class World {
  Player player;
  int number;

  ArrayList<Obstacle> obstacles = new ArrayList<Obstacle>();
  ArrayList<Enemy> enemies = new ArrayList<Enemy>();
  ArrayList<BoxObject> boxes = new ArrayList<BoxObject>();  
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  Platform platform;

  Door door;

  ArrayList<IDisplayable> DisplayableObjects = new ArrayList<IDisplayable>();
  PhysicsEngine physicsEngine;

  boolean paused = false;


  World() {
    player = new Player(new PVector(100, 250), 30, 50, this);
    door = new Door(new PVector(width-50, 150), 50, 100);
    CreateWalls();
    SpawnEnemies();
    CreateBoxes();

    platform = new Platform(new PVector(300, 120), 50, 50);

    platform.SetDoorObject(door); 

    for (Obstacle obstacle : obstacles) 
    { 
      DisplayableObjects.add((IDisplayable)obstacle);
    }

    DisplayableObjects.add((IDisplayable)platform);
    DisplayableObjects.add((IDisplayable)door);

    for (Enemy enemy : enemies) {
      DisplayableObjects.add((IDisplayable)enemy);
      enemy.SetTarget(player);
    }

    for (BoxObject box : boxes) {
      DisplayableObjects.add((IDisplayable)box);
    }

    DisplayableObjects.add(player);

    for (Bullet bullet : bullets) {
      DisplayableObjects.add((IDisplayable)bullet);
    }

    //Populate physicsEngine
    ArrayList<GameObject> objects = new ArrayList<GameObject>();
    for (int i =0; i< DisplayableObjects.size(); i++) {
      objects.add((GameObject)DisplayableObjects.get(i));
    }
    physicsEngine= new PhysicsEngine(objects);
  }

  void update() {

    if (!paused) {
      for (int i=0; i< DisplayableObjects.size(); i++) {
        DisplayableObjects.get(i).update();
      }
      physicsEngine.update();
    }
  }

  void draw() {

    if (!paused) {
      DrawFloor(30);
      for (int i=0; i< DisplayableObjects.size(); i++) {
        DisplayableObjects.get(i).draw();
      }
      physicsEngine.drawColliders();
    }
  }


  void DrawFloor(int brickLength) {
    push();
    int brickDepth =(int)(brickLength/2.1);
    int row=0;
    strokeWeight(2);
    stroke(#504E4D);
    fill(#A09D9B);
    for (int y=0; y<height; y+= brickDepth) {
      for (int x=0; x<=width+brickLength; x+=brickLength) 
      {
        if (row %2!=0) {
          rect(x-brickLength/2, y, brickLength, brickDepth);
        } else {
          rect(x, y, brickLength, brickDepth);
        }
      }
      row++;
    }
    pop();
  }


  void CreateWalls() {
    obstacles.add(new Obstacle(new PVector(0, 0), 50, height));
    obstacles.add(new Obstacle(new PVector(50, 0), width-50*2, 50));
    obstacles.add(new Obstacle(new PVector(width-50, 0), 50, 150));
    obstacles.add(new Obstacle(new PVector(width-50, 250), 50, height-250));
    obstacles.add(new Obstacle(new PVector(50, 0), width-50*2, 50));
    obstacles.add(new Obstacle(new PVector(50, height-50), width-50*2, 50));

    obstacles.add(new Obstacle(new PVector(400, 250), 200, 50));
  }
  void SpawnEnemies() {
    //enemies.add(new Enemy(new PVector(130, 120), 30, 50));
    EnemyTurret turret = new EnemyTurret(new PVector(130, 120), 50, 50);
    enemies.add(turret);
  } 

  void CreateBoxes() {
    boxes.add(new BoxObject(new PVector(500, 450), 50, 50));
  }

  void AddBullet(Bullet newBullet) {
    bullets.add(newBullet);
    DisplayableObjects.add((IDisplayable)newBullet);
    physicsEngine.AddCollider((GameObject)newBullet);
  }

  void RemoveBullet(Bullet bulletToRemove) {
    bullets.remove(bulletToRemove);
    DisplayableObjects.remove((IDisplayable)bulletToRemove);
    physicsEngine.RemoveCollider((GameObject)bulletToRemove);
  }

  void victory() {
    paused = true;
    push();
    String message = "Victory \nPress R to restart ";
    textSize(32);
    rectMode(CENTER); 
    fill(127);
    rect(width/2,height/2, 200,120);
    fill(0, 255, 0);

    textAlign(CENTER);
    text(message, width/2, height/2, 150, 120);
    pop();
  }
  void defeat() {
    paused = true;
    push();
   String message = "Defeat \n Press R to restart ";
    textSize(32);
    rectMode(CENTER);
    fill(127);
    rect(width/2,height/2, 200,120);
    fill(255,0, 0);

    textAlign(CENTER);
    text(message, width/2, height/2, 150, 120);
    pop();
  }
}
