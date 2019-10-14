class Platform extends GameObject {
  PVector InitialPosition = new PVector();

  public float Speed=1;

  private float width;
  private float height;

  private boolean platformPressed =false;

  Door doorRef=null;


  Platform() {
    super();
  }
  Platform(PVector position) {
    super(position);
    InitialPosition = position;
    width =50;
    height =50;
    collider = new BoxCollider(position.x, position.y, position.x+width, position.y+height);

    name= "Platform";
  }
  Platform(PVector position, float width, float height) {
    this(position);
    collider = new BoxCollider(position.x, position.y, position.x+width, position.y+height);
    this.width = width;
    this.height = height;
  }

  public void SetDoorObject(Door doorRef) {
    this.doorRef = doorRef;
  }

  @Override void update() {
    
  }
  @Override void draw() {
    MeshData();
  }
  @Override void MeshData() {
    push();
    fill(#CBB55A);

    translate(position.x+width/2, position.y+height/2);
    rotate(PI);
    translate(-position.x-width/2, -position.y-height/2);

    ellipseMode(CORNER);
    strokeWeight(3);
    fill(#905B16);
    circle(position.x, position.y, width);//platform

    strokeWeight(2);
    stroke(0);
    if (platformPressed) {
      fill(#15F202);
    } else {
      fill(#A0A0A0);
    }
    triangle(position.x + width/2 -width/3, position.y+height/2 -height/4, position.x + width/2 + width/3, position.y+height/2 -height/4, position.x + width/2, position.y+height/2+height/3);
    
    if(platformPressed){
      doorRef.isActive = false;
    }else{
      doorRef.isActive = true;
    }
  
    platformPressed =false;
    
    pop();
  }
  @Override void CollisionEntered(GameObject objectCollided) {
    if (objectCollided.name =="Player" || objectCollided.name == "BoxObject") {
      platformPressed = true;
      doorRef.isActive =false;
    }
  }
}
