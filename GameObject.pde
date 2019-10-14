class GameObject implements IDisplayable{
  public PVector position;
  public PVector direction = new PVector();
  public BoxCollider collider;
  
  
  public String name;
  
  GameObject(){
    position = new PVector();
  }
  GameObject(PVector position){
    this.position = position; 
  }
  
  void MoveTo(PVector newPosition){
    position = newPosition;
  }

  void update(){ }
  void draw(){ }
  void MeshData(){ }
  
  
  void CollisionEntered(GameObject objectCollided){
    //println(name +"collided with" +objectCollided.name);
  }
  
}
