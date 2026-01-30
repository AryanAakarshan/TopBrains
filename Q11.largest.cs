public class Maths{
    public static int largest(int a,int b,int c)
    {
        if (a > b)
        {
            if (c > a)
            {
                return c;
            }
            else {return a;}
        }
        else
        {
            if(b>c)return b;
            else return c;
        }
    }
}
class Program
{
    public static void Main()
    {
        Console.WriteLine(Maths.largest(6,8,3));
        Console.WriteLine(Maths.largest(9,7,5));
        Console.WriteLine(Maths.largest(6,8,19));
    }
}
