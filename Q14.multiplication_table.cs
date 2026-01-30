class Program
{
    public static void Main()
    {
        int n=3;
        int upto=5;
        for(int i = n; i <= upto; i++)
        {
            Console.WriteLine("Multiplication table of "+i);
            for(int j = 1; j <= 10; j++)
            {
                Console.WriteLine(i*j);
            }
        }
    }
}
