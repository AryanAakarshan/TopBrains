public class methods
{
    public static string stringclean(string input)
    {
        StringBuilder output=new StringBuilder();
        char prev='0';
        foreach(char c in input)
        {
            if (c != prev)
            {
                output.Append(c);
                prev=c;
            }
        }
        TextInfo textInfo = CultureInfo.CurrentCulture.TextInfo;
        return textInfo.ToTitleCase(output.ToString().ToLower());
    }
}

class Program
{
    public static void Main()
    {
        string input="llllaaappptooop baaaaag";
        string output=methods.stringclean(input);
        Console.WriteLine(output);
    }
}
