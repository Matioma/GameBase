class Door extends GameObject {

  PVector InitialPosition = new PVector();


  private float width;
  private float height;

  boolean isActive = true;

  Door() {
    super();
  }
  Door(PVector position) {
    super(position);
    InitialPosition = position;
    width =50;
    height =50;
    collider = new BoxCollider(position.x, position.y, position.x+width, position.y+height);

    name= "Door";
  }
  Door(PVector position, float width, float height) {
    this(position);
    collider = new BoxCollider(position.x, position.y, position.x+width, position.y+height);
    this.width = width;
    this.height = height;
  }
  @Override void update() {
  }
  @Override void draw() {
    MeshData();
  }
  @Override void MeshData() {
    if (isActive) {
      push();
      fill(#817C7C);

      rect(position.x, position.y, width, height);

      translate(position.x+width/2, position.y+height/2);
      rotate(0);
      translate(-position.x-width/2, -position.y-height/2);

      rect(position.x, position.y, width, height);

      pop();
    }
    else{
      println("WTF");
    }
  }

  @Override void CollisionEntered(GameObject objectCollided) {
  }

  public void move(PVector direction, float speed) {
    //velocity.set(direction.normalize().mult(speed));
  }
} 
