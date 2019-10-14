class Bullet extends GameObject {
  final World worldRef;

  PVector InitialPosition = new PVector();

  public float Speed=1;

  private PVector previousPosition =new PVector();
  private float width;
  private float height;

  private PVector velocity = new PVector(0, 0);
  private PVector target = new PVector(0, 0);

  private String owner;

  Bullet() {
    super();
    worldRef=null;
  }

  Bullet(PVector position) {
    super(position);
    InitialPosition = position;
    width =50;
    height =50;
    collider = new BoxCollider(position.x, position.y, position.x+width, position.y+height);
    worldRef=null;
    name= "Bullet";
  }
  Bullet(PVector position, World worldRef) {
    super(position);
    InitialPosition = position;
    width =50;
    height =50;
    collider = new BoxCollider(position.x, position.y, position.x+width, position.y+height);
    this.worldRef = worldRef;
    name= "Bullet";
  }
  Bullet(PVector position, float width, float height) {
    this(position);
    collider = new BoxCollider(position.x, position.y, position.x+width, position.y+height);
    this.width = width;
    this.height = height;
  }
  Bullet(PVector position, float width, float height, World worldRef, PVector velocity) {
    this(position, worldRef);
    collider = new BoxCollider(position.x, position.y, position.x+width, position.y+width);
    this.width = width;
    this.height = height;
    this.velocity.set(velocity);
  }
  Bullet(PVector position, float width, float height, World worldRef, PVector velocity, String owner) {
    this(position,width,height,worldRef,velocity);
    this.owner = owner;
  }

  @Override void update() {
    previousPosition.x = position.x;
    previousPosition.y = position.y;



    position.add(velocity);
  }
  @Override void draw() {
    MeshData();
  }
  @Override void MeshData() {
    push();
    fill(#CBB55A);

    translate(position.x+width/2, position.y+height/2);
    //rotate(getRotation());
    translate(-position.x-width/2, -position.y-height/2);

    rectMode(CORNER);
    square(position.x, position.y, width);


    pop();
  }
  
  @Override void CollisionEntered(GameObject objectCollided) {
    if (objectCollided.name =="Obstacle" || objectCollided.name =="BoxObject" || objectCollided.name=="Door" ) {
      worldRef.RemoveBullet(this);
    }
    if(objectCollided.name == "Enemy"){
      worldRef.RemoveBullet(this);
    }
    //velocity.mult(-1);
  }

  float getRotation() {
    PVector mousePos = new PVector(target.x, target.y);
    PVector direction = mousePos.sub(position).normalize();

    float radians = atan(direction.y/direction.x);
    if (direction.x<0) {
      radians-=PI;
    }
    return radians;
  }
}
