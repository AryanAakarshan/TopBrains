public class height
{
    public static void Category(int height)
    {
        if (height < 150)
        {
            Console.WriteLine("Short");
        }
        else if (height >= 150 && height < 180)
        {
            Console.WriteLine("Average");
        }
        else if(height>180 && height<=300) Console.WriteLine("Tall");
        else Console.WriteLine("Wrong input");
    }
}

class Program
{
    public static void Main()
    {
        height.Category(200);
        height.Category(179);
        height.Category(309);
        height.Category(100);
    }
}
