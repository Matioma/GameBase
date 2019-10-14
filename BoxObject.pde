class BoxObject extends GameObject {
  PVector InitialPosition = new PVector();

  public float Speed=1;

  private PVector previousPosition =new PVector();
  private float width;
  private float height;

  private PVector velocity = new PVector(0, 0);


  BoxObject() {
    super();
  }
  BoxObject(PVector position) {
    super(position);
    InitialPosition = position;
    width =50;
    height =50;
    collider = new BoxCollider(position.x, position.y, position.x+width, position.y+height);

    name= "BoxObject";
  }
  BoxObject(PVector position, float width, float height) {
    this(position);
    collider = new BoxCollider(position.x, position.y, position.x+width, position.y+height);
    this.width = width;
    this.height = height;
  }
  @Override void update() {
    previousPosition.x = position.x;
    previousPosition.y = position.y;
    //GoTo(new PVector(mouseX,mouseY));

    position.add(velocity);
    velocity.set(new PVector());
  }
  @Override void draw() {
    MeshData();
  }
  @Override void MeshData() {
    push();
    fill(#CBB55A);

    translate(position.x+width/2, position.y+height/2);
    rotate(0);
    
    translate(-position.x-width/2, -position.y-height/2);


    rect(position.x, position.y, width,height);
    
    for(int x = (int)position.x; x<position.x+width; x+=10){
      rect(x,position.y, width/30, height);
    } 
    
    
    //quad lateral wood planks
    
    fill(#7C5A31);
    quad(position.x,position.y, position.x+width, position.y, position.x+width-width/5,position.y+height/6, position.x+width/5,position.y+height/6);
    quad(position.x,position.y, position.x, position.y+height, position.x+width/5,position.y + height-height/6, position.x+width/5,position.y+height/6);
    quad(position.x + width,position.y, position.x+width, position.y+height, position.x+width - width/5,position.y + height-height/6, position.x+width-width/5,position.y+height/6);
    quad(position.x,position.y+height, position.x+width, position.y+height, position.x+width-width/5,position.y+height-height/6, position.x+width/5,position.y+height-height/6);
 

    pop();
  }
  @Override void CollisionEntered(GameObject objectCollided) {
    if (objectCollided.name =="Obstacle" || objectCollided.name =="Door" ||objectCollided.name =="Enemy") {
      position.x = previousPosition.x;
      position.y = previousPosition.y;
    }
    //velocity.mult(-1);
  }
  
  public void move(PVector direction,float speed){
    velocity.set(direction.normalize().mult(speed));
  }
}
