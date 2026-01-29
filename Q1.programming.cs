public class Maths{
    
    static int Sumofdigit(int x)
    {
        int sum=0;
        while (x > 0)
        {
            sum+=x%10;
            x=x/10;
        }
        return sum;

    }
    static bool IsPrime(int x)
    {
        if(x<=1)return false;
        if(x==2)return true;
        for(int i = 2; i <= x/2; i++)
        {
            if(x%i==0) return false;
        }
        return true;
    }
    public static bool IsLucky(int x)
        {
            if(IsPrime(x))return false;
            int s1=Sumofdigit(x);
            int s2=Sumofdigit(x*x);
            return s2==s1*s1;

        }
}
class Program
{
    public static void Main()
    {
        int m = 20;
        int n = 30;
        int count = 0;

        for (int i = m; i <= n; i++)
        {
            if (Maths.IsLucky(i))
            {
                count++;
            }
        }

        Console.WriteLine(count);   
    }
}
