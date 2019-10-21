class Enemy extends GameObject implements IUnit {
  //sdsafloat bulletVelocity = 3;
  PVector InitialPosition = new PVector();
  World worldRef;

  public float Speed=1;

  private PVector previousPosition =new PVector();
  private float width;
  private float height;

  private PVector velocity = new PVector(0, 0);
  private PVector target = new PVector(0, 0);
  private GameObject targetObject;

  
  public float shootFrequency =1500;
  public float time = millis();
  Enemy() {
    super();
  }

  Enemy(PVector position) {
    super(position);
    InitialPosition = position;
    width =50;
    height =50;
    collider = new BoxCollider(position.x, position.y, position.x+width, position.y+height);

    name= "Enemy";
  }
  Enemy(PVector position, float width, float height) {
    this(position);
    collider = new BoxCollider(position.x, position.y, position.x+width, position.y+height);
    this.width = width;
    this.height = height;
  }

  void SetTarget(GameObject target) {
    targetObject= target;
  }
  
  void SetWorldRef(World ref){
    worldRef = ref; 
  }


  @Override void update() {
    /*previousPosition.x = position.x;
    previousPosition.y = position.y;



    position.add(velocity);*/
  }
  @Override void draw() {
    MeshData();
  }
  @Override void MeshData() {
    /*push();
    fill(#CBB55A);

    translate(position.x+width/2, position.y+height/2);
    rotate(getRotation());
    translate(-position.x-width/2, -position.y-height/2);

    rectMode(CORNER);
    fill(0);
    rect(position.x+width/2+5, position.y+height-5, 20, 6);//gun

    ellipseMode(CORNER);
    fill(#FF4646);
    ellipse(position.x, position.y, width, height);//Body

    fill(#CBB55A);
    ellipseMode(CENTER);
    circle(position.x+width/2+10, position.y+height/2, 30); //head


    pop();*/
  }

  float getRotation() {

    if (targetObject!=null) {
      PVector targetPos =new PVector(targetObject.position.x, targetObject.position.y);
      PVector direction = targetPos.sub(position).normalize();

      float radians = atan(direction.y/direction.x);
      if (direction.x<0) {
        radians-=PI;
      }
      return radians;
    } else {
      return 0;
    }
  }

  void GoTo(PVector target) {
  }
  
  
  void Shoot() {
    PVector mousePos = new PVector(targetObject.position.x, targetObject.position.y);
    PVector lookDirection =mousePos.sub(position).normalize();



    PVector bulletPos = new PVector();
    bulletPos.set(position);
    bulletPos.add(width/2, height/2).add(lookDirection.mult(50));

    PVector bulletVelocity = lookDirection.normalize().mult(3);
    worldRef.AddBullet( new Bullet(bulletPos, 10, 10, worldRef, bulletVelocity, "Enemy"));
  }
}
