class Program
{
    public static void Main()
    {
        Dictionary<int,double> Employees=new Dictionary<int, double>();
          Employees.Add(1,20000);
          Employees.Add(4,40000);
          Employees.Add(5,15000) ;
        
        double sum=0;
        foreach (var person in Employees)
        {
            sum+=person.Value;
        }
        Console.WriteLine(sum);
    }
}
