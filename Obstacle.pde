class Obstacle extends GameObject {
  float width, height;

  Obstacle() {
    super();
  }

  Obstacle(PVector position, float width, float height) {
    super(position);
    this.width = width;
    this.height = height;
    collider = new BoxCollider(position.x, position.y, position.x+width, position.y+height);
    name="Obstacle";
  }    


  @Override void draw() {
    MeshData();
  }


  @Override void MeshData() {
    push();

    stroke(0);
    fill(#815526);
    rectMode(CORNER);

    int row =0;
    float brickNumber =0;
    for (float y = position.y; y<position.y+height; y+=10) {
      for (float x=position.x; x<position.x+width; x+=30) {
        if (row%2==0) {
          if (x+30 > position.x+width)
          {
            rect(x, y, position.x+width-x, 10);
          } else {
            rect(x, y, 30, 10);
          }
        }else if(brickNumber==0){
          rect(x,y,15,10);
          x-=15;
        }else{
          if(x+30 > position.x +width){
            rect(x, y, position.x+width-x, 10);
          }else{
            rect(x, y, 30, 10);
          }
        }
        brickNumber++;
       
      }
      row++;
      brickNumber=0;
    }

    //rect(position.x, position.y, width, height);
    pop();
  }
}
