public class BoxCollider {
  float xTop, yTop;
  float xBottom, yBottom;

  float colWidth, colHeight;

  BoxCollider(float xTop, float yTop, float xBottom, float yBottom) {
    this.xTop = xTop;
    this.yTop = yTop;
    this.xBottom = xBottom;
    this.yBottom = yBottom;

    colWidth = xBottom-xTop;
    colHeight = yBottom - yTop;
  }

  public void updateColliderPos(PVector position) {
    xTop = position.x;
    yTop = position.y;
    xBottom = position.x + colWidth;
    yBottom = position.y +colHeight;
  }

  boolean OverlapsCollider(BoxCollider collideObject) {
      if(xTop> collideObject.xBottom || xBottom < collideObject.xTop)
        return false;
      if(yTop> collideObject.yBottom || yBottom <collideObject.yTop)
        return false;
  
      return true;
  }
  
  
  void ShowCollider() {
    push();
    noFill();
    strokeWeight(3);
    stroke(255, 255, 0);

    rectMode(CORNER);
    rect(xTop, yTop, colWidth, colHeight);
    pop();
  }
}
