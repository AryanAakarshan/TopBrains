public class conversion
{
    public static double feet_to_centimeter(int feet)
    {
        return feet*30.48;
    }
}

class Program
{
    public static void Main()
    {
        int feet=6;
        double cm=conversion.feet_to_centimeter(feet);
        Console.WriteLine(Math.Round((cm),2));
    }
}
