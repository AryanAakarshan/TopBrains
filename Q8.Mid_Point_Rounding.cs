public class Maths
{
    public static double Circle_area(double radius)
    {
        return Math.PI*radius*radius;
    } 
}
class program
{
    public static void Main()
    {
        double radius=3;
        double area=Math.Round(Maths.Circle_area(radius),2);
        Console.WriteLine(area);
    }
}
