from __future__ import annotations

class Shape:
    Circle = "Circle"
    Rectangle = "Rectangle"

def area(shape) -> float:
    match shape:
        case {"type": "Circle", "radius": radius}:
            return ((3.14 * radius) * radius)
        case {"type": "Rectangle", "width": width, "height": height}:
            return (width * height)

def main() -> None:
    circle: Shape = {"type": "Circle", "radius": 5}
    rectangle: Shape = {"type": "Rectangle", "width": 4, "height": 6}
    print(f"Circle area: {area(circle)}")
    print(f"Rectangle area: {area(rectangle)}")

main()
