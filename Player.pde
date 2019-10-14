class Player extends GameObject implements IUnit {
  final World worldRef;


  PVector InitialPosition = new PVector();

  public float Speed=1;

  private PVector previousPosition =new PVector();
  private float width;
  private float height;

  private PVector velocity = new PVector(0, 0);


  //movement
  private PVector horizontalMovement= new PVector(0, 0);
  private PVector verticalMovement = new PVector(0, 0);
  private boolean aPressed=false;
  private boolean dPressed=false;
  private boolean wPressed=false;
  private boolean sPressed=false;

  //shooting
  private boolean leftMouseButtonPressed =false;
  int time = millis();


  Player() {
    super();
    worldRef=null;
  }
  Player(PVector position) {
    super(position);
    InitialPosition = position;
    width =50;
    height =50;
    collider = new BoxCollider(position.x, position.y, position.x+width, position.y+height);
    name= "Player";
    worldRef=null;
  }
  Player(PVector position, World worldRef) {
    super(position);
    InitialPosition = position;
    width =50;
    height =50;
    collider = new BoxCollider(position.x, position.y, position.x+width, position.y+height);
    name= "Player";
    this.worldRef=worldRef;
  }
  Player(PVector position, float width, float height) {
    this(position);
    collider = new BoxCollider(position.x, position.y, position.x+width, position.y+height);
    this.width = width;
    this.height = height;
  }
  Player(PVector position, float width, float height, World worldRef) {
    this(position, worldRef);
    collider = new BoxCollider(position.x, position.y, position.x+width, position.y+height);
    this.width = width;
    this.height = height;
  }

  @Override void update() {
    previousPosition.x = position.x;
    previousPosition.y = position.y;
    Input();
    //GoTo(new PVector(mouseX,mouseY));
    if (leftMouseButtonPressed) {
      //if (millis() > time + 1000)
      //{
      Shoot();
      //time = millis();
      //}

      leftMouseButtonPressed = false;
    }

    position.add(velocity);
  }
  @Override void draw() {
    MeshData();
  }
  @Override void MeshData() {
    push();
    fill(#CBB55A);

    translate(position.x+width/2, position.y+height/2);
    rotate(getRotation());
    translate(-position.x-width/2, -position.y-height/2);

    rectMode(CORNER);
    fill(0);
    rect(position.x+width/2+5, position.y+height-5, 20, 6); //gun

    ellipseMode(CORNER);
    fill(#63D85C);
    ellipse(position.x, position.y, width, height);//Body

    fill(#CBB55A);
    ellipseMode(CENTER);
    circle(position.x+width/2+10, position.y+height/2, 30); //head


    pop();
  }
  @Override void CollisionEntered(GameObject objectCollided) {
    if (objectCollided.name =="Obstacle") {
      position.x = previousPosition.x;
      position.y = previousPosition.y;
    }
    if (objectCollided.name =="BoxObject") {
      position.x = previousPosition.x;
      position.y = previousPosition.y;

      BoxObject BoxObject =(BoxObject)objectCollided;
      if (BoxObject !=null) {
        BoxObject.move(velocity, speed/10);
      }
    }

    if (objectCollided.name =="Door") {
      Door door = (Door)objectCollided;
      if (door.isActive) {
        position.x = previousPosition.x;
        position.y = previousPosition.y;
      }else{
        worldRef.victory();
        //println("Victory");
      }
    }

    if (objectCollided.name =="Bullet") {
      Bullet bullet = (Bullet)objectCollided;
      
      if(bullet !=null){
        if(bullet.owner == "Enemy"){
           worldRef.defeat();
        }
      
      }
    }
    if(objectCollided.name =="Enemy"){
      worldRef.defeat();  
    }
    //velocity.mult(-1);
  }

  void Input() {
    //horizontal movement
    if (aPressed) {
      horizontalMovement.x=-speed;
    }
    if (dPressed) {
      horizontalMovement.x= speed;
    }
    if (aPressed && dPressed  || !aPressed && !dPressed) {
      horizontalMovement.x =0;
    }

    //verticalMovement
    if (wPressed) {
      horizontalMovement.y=-speed;
    }
    if (sPressed) {
      horizontalMovement.y= speed;
    }
    if (wPressed && sPressed || !wPressed && !sPressed) {
      horizontalMovement.y =0;
    }

    velocity = horizontalMovement.add(verticalMovement).normalize().mult(speed);
  }

  float getRotation() {
    PVector mousePos = new PVector(mouseX, mouseY);
    PVector direction = mousePos.sub(position).normalize();

    float radians = atan(direction.y/direction.x);
    if (direction.x<0) {
      radians-=PI;
    }
    return radians;
  }


  void KeyPressed(char value) {

    switch (value) {
    case 'a':
      aPressed=true;
      break;
    case 'd':
      dPressed=true;
      break;
    case 'w':
      wPressed=true;
      break;
    case 's':
      sPressed=true;
      break;
    }
  }
  void KeyReleased(char value) {
    switch (value) {
    case 'a':
      aPressed=false;
      break;
    case 'd':
      dPressed=false;
      break;
    case 'w':
      wPressed=false;
      break;
    case 's':
      sPressed=false;
      break;
    }
  }

  void MousePressed() {
    leftMouseButtonPressed = true;
  }

  void MouseReleased() {
    leftMouseButtonPressed = false;
  }

  void Shoot() {
    PVector mousePos = new PVector(mouseX, mouseY);
    PVector lookDirection =mousePos.sub(position).normalize();



    PVector bulletPos = new PVector();
    bulletPos.set(position);
    bulletPos.add(width/2, height/2).add(lookDirection.mult(50));

    PVector bulletVelocity = lookDirection.normalize().mult(10);
    worldRef.AddBullet( new Bullet(bulletPos, 5, 5, worldRef, bulletVelocity, "Player"));
  }


  void GoTo(PVector target) {
    if (dist(target.x, target.y, position.x, position.y) >= 10) {
      PVector movementVector = target.sub(position).normalize();
      position.add(movementVector.mult(speed));
    }
  }
}
