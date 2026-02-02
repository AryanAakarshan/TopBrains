class Program
{
    public static void Main()
    {
        object[] arr = new object[56];
        int index = 0;

        arr[index++] = 67;
        arr[index++] = 'p';
        arr[index++] = 48.38;
        arr[index++] = "Hello";
        arr[index++] = 8;
        int sum=0;
        foreach (var s in arr)
        {
            if (s != null){
                if (s.GetType() == typeof(int))
                {
                    Console.WriteLine(s);
                    int num=(int) s;
                    sum+=num;
                }
            }
        }
        Console.WriteLine(sum);
    }
}
