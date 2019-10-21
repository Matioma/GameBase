class PhysicsEngine {
  boolean DEBUG = false;  


  ArrayList<GameObject> SceneObjects;

  PhysicsEngine(ArrayList<GameObject> objects) {
    SceneObjects = objects;
  }

  void AddCollider(GameObject object) {
    SceneObjects.add(object);
  }

  void RemoveCollider(GameObject object) {
    SceneObjects.remove(object);
  }

  void update() {
    UpdateCollidersPos(); 
    CheckCollision();
  }

  public void UpdateCollidersPos() {
    for (int i =0; i<SceneObjects.size(); i++) {
      GameObject object = SceneObjects.get(i);
      if (object.collider !=null) {
        object.collider.updateColliderPos(object.position);
      }
    }
  }

  private void CheckCollision() {
    try {
      for (int i=0; i<SceneObjects.size(); i++) {
        for (int j=i+1; j<SceneObjects.size(); j++) {
          if (SceneObjects.get(i).collider.OverlapsCollider(SceneObjects.get(j).collider)) {

            SceneObjects.get(i).CollisionEntered(SceneObjects.get(j));

            SceneObjects.get(j).CollisionEntered(SceneObjects.get(i));
          }
        }
      }
    }catch(Exception x){
      println("Bugg!");
    }
  }

  //Display all colliders id in Debug mode
  void drawColliders() {
    if (DEBUG) {

      for (int i =0; i<SceneObjects.size(); i++) {
        if (SceneObjects.get(i).collider != null)
          SceneObjects.get(i).collider.ShowCollider();
      }
    }
  }
}
