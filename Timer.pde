public static class Timer{
  static float lastFrameTime;
  
  static float deltaTime;
  
  public static float DeltaTime(float currentTime){
    deltaTime = currentTime - lastFrameTime; 
    return deltaTime;
  }
}
