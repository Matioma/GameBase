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

      translate(position.x+width/2, position.y+height/2);
      rotate(0);
      translate(-position.x-width/2, -position.y-height/2);

      push();
      strokeWeight(0);
      fill(#AFADAD);
      rect(position.x, position.y, width, height);
      pop();


      push();
      fill(#6F6F6F);
      rect(position.x+10, position.y+10, width-20, height-20);
      pop();

      fill(#4D6364);
      //draw circles top
      for (float  x= position.x+ 5; x< position.x+width; x+=10) {
        circle( x, position.y+5, 5);
      }
      //draw circles bottom
      for (float  x= position.x+ 5; x< position.x+width; x+=10) {
        circle( x, position.y+height-5, 5);
      }

      for (float y = position.y+15; y<= position.y + height-15; y+=10) {
        circle( position.x+5, y, 5);
      }
      for (float y = position.y+15; y<= position.y + height-15; y+=10) {
        circle( position.x+width-5, y, 5);
      }




      //println("gm");
      pop();
    } else {
    }
  }

  @Override void CollisionEntered(GameObject objectCollided) {
  }

  public void move(PVector direction, float speed) {
    //velocity.set(direction.normalize().mult(speed));
  }
} 
