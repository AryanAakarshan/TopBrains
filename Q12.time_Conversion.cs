public class Maths{
    public static string timeconversion(int sec)
    {
        StringBuilder st=new StringBuilder();
        int temp=sec/60;
        st.Append(temp+":");
        int temp2=sec%60;
        st.Append(temp2);
        return st.ToString();
    }
}
class Program
{
    public static void Main()
    {
        int sec=80;
        Console.WriteLine(Maths.timeconversion(sec));
    }
}
