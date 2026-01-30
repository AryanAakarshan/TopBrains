class Program
{
    public static void Main()
    {
        int num=80;
        int sum=0;
        for(int i = num; i >= 0; i--)
        {
            if(i==0)break;
            sum+=i;
        }
        Console.WriteLine(sum);
    }
}
