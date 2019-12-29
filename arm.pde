class Arm {
  private float newTriangleWidth = 0;
  private float currentTriangleWidth = 0; 
 
  void render(float triangleheight) {
    currentTriangleWidth = (screenWidthFloat/4)/(height/triangleheight); 
    newTriangleWidth = currentTriangleWidth;
   fill(0); 
    triangle(-newTriangleWidth, 0, 0, -triangleheight, newTriangleWidth, 0);
  }
}
