public class swap
{
    public static void Swap(ref int x,ref int y)
    {
        x=x+y;
        y=x-y;
        x=x-y;
    }
}
class Program
{
    public static void Main()
    {
        int a=9;
        int b=8;
        swap.Swap(ref a,ref b);
        Console.WriteLine($"a={a},b={b}");
    }
}
