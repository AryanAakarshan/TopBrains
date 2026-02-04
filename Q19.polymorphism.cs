using System;

interface IArea
{
    double GetArea();
}

abstract class Shape : IArea
{
    public abstract double GetArea();
}

class Circle : Shape
{
    private double radius;

    public Circle(double r)
    {
        radius = r;
    }

    public override double GetArea()
    {
        return Math.PI * radius * radius;
    }
}

class Rectangle : Shape
{
    private double width;
    private double height;

    public Rectangle(double w, double h)
    {
        width = w;
        height = h;
    }

    public override double GetArea()
    {
        return width * height;
    }
}

class Triangle : Shape
{
    private double baseValue;
    private double height;

    public Triangle(double b, double h)
    {
        baseValue = b;
        height = h;
    }

    public override double GetArea()
    {
        return 0.5 * baseValue * height;
    }
}

class ShapeCalculator
{
    public static double ComputeTotalArea(string[] shapes)
    {
        double totalArea = 0;

        foreach (var s in shapes)
        {
            string[] parts = s.Split(' ');
            Shape shape = null;

            if (parts[0] == "C")
            {
                double r = double.Parse(parts[1]);
                shape = new Circle(r);
            }
            else if (parts[0] == "R")
            {
                double w = double.Parse(parts[1]);
                double h = double.Parse(parts[2]);
                shape = new Rectangle(w, h);
            }
            else if (parts[0] == "T")
            {
                double b = double.Parse(parts[1]);
                double h = double.Parse(parts[2]);
                shape = new Triangle(b, h);
            }

            totalArea += shape.GetArea();
        }

        return Math.Round(totalArea, 2, MidpointRounding.AwayFromZero);
    }
}
