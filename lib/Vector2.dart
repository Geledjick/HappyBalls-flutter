class Vector2<T> {
  late T x, y;
  Vector2(T nx, T ny) {
    x = nx;
    y = ny;
  }
  
  Vector2.zero();
}

typedef Vector2i = Vector2<int>;
typedef Vector2d = Vector2<double>;