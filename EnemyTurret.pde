class EnemyTurret extends Enemy {

  EnemyTurret() {
    super();
  }

  EnemyTurret(PVector position) {
    super(position);
    InitialPosition = position;
    super.width =50;
    super.height =50;
    collider = new BoxCollider(position.x, position.y, position.x+super.width, position.y+super.height);

    name= "Enemy";
  }
  EnemyTurret(PVector position, float width, float height) {
    this(position);
    collider = new BoxCollider(position.x, position.y, position.x+super.width, position.y+super.height);
    super.width = width;
    super.height = height;
  }
  @Override void update() {
  }

  @Override void draw() {
    MeshData();
  }
  @Override void MeshData() {
    push();
    fill(#CBB55A);
    
    push();
    translate(position.x+super.width/2, position.y+super.height/2);
    rotate(getRotation());
    translate(-position.x-super.width/2, -position.y-super.height/2);
    
    fill(0);
    rect(position.x+super.width/2, position.y+5, 20,5);
    rect(position.x+super.width/2, position.y + super.height -10, 20,5);  
    
    
    pop();
    /*rectMode(CORNER);
     fill(0);
     rect(position.x+super.width/2+5, position.y+super.height-5, 20, 6);//gun
     
     ellipseMode(CORNER);
     fill(#FF4646);
     ellipse(position.x, position.y, super.width, super.height);//Body
     
     fill(#CBB55A);
     ellipseMode(CENTER);
     circle(position.x+super.width/2+10, position.y+super.height/2, 30); //head
     */
    //fill(255);
    push();
    translate(position.x+super.width/2, position.y+super.height/2);
    rotate(getRotation());
    rotate(radians(75));
    translate(-position.x-super.width/2, -position.y-super.height/2);
    fill(#767676);
    arc(position.x +super.width/2, position.y + super.height/2, super.width, super.height, 0, PI + PI/6, PIE);
    pop();


    pop();
  }
}
