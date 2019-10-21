class EnemyKamikaze extends Enemy {
  float kamikazeSpeed = 2;
  PVector previousPosition = new PVector();


  EnemyKamikaze() {
    super();
  }

  EnemyKamikaze(PVector position) {
    super(position);
    InitialPosition = position;
    super.width =50;
    super.height =50;
    collider = new BoxCollider(position.x, position.y, position.x+super.width, position.y+super.height);

    name= "Enemy";
  }
  EnemyKamikaze(PVector position, float width, float height) {
    this(position);
    super.width = width;
    super.height = height;
    collider = new BoxCollider(position.x, position.y, position.x+super.width, position.y+super.height);
  }
  @Override void update() {

    previousPosition.x = position.x;
    previousPosition.y = position.y;

    if (super.target != null)
      ToTarget(super.targetObject.position);
  }

  @Override void draw() {
    MeshData();
  }
  @Override void MeshData() {
    push();
    fill(#CBB55A);

    ellipseMode(CORNER);

    translate(position.x+super.width/2, position.y+super.height/2);
    rotate(getRotation());
    translate(-position.x-super.width/2, -position.y-super.height/2);

    fill(#FFBE08);
    ellipse(position.x, position.y, super.width, super.height);

    fill(#FF0000);
    circle(position.x + super.width/2, position.y + super.width/2, super.width/1.5);


    //square(position.x, position.y, super.width);



    pop();
  }

  void ToTarget(PVector targetPosition) {

    PVector tarPosition = new PVector(targetPosition.x, targetPosition.y); 
    PVector currentPosition = new PVector();
    currentPosition.set(this.position);
    PVector direction =tarPosition.sub(currentPosition);
    PVector unitDirectionVector = direction.normalize();

    currentPosition.add(unitDirectionVector.mult(kamikazeSpeed));
    this.position = currentPosition;
  }

  @Override void CollisionEntered(GameObject objectCollided) {
    if (objectCollided.name =="Obstacle") {
      position.x = previousPosition.x;
      position.y = previousPosition.y;
    }
    if (objectCollided.name =="BoxObject") {
      position.x = previousPosition.x;
      position.y = previousPosition.y;
    }

    if (objectCollided.name =="Door") {
      Door door = (Door)objectCollided;
      if (door.isActive) {
        position.x = previousPosition.x;
        position.y = previousPosition.y;
      }
    }
  }
}
