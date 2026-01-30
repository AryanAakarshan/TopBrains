using System;
using System.Collections.Generic;
using System.Text;

public class Solution
{
    static bool IsVowel(char c)
    {
        c = char.ToLower(c);
        return c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u';
    }

    public static string Process(string first, string second)
    {
        HashSet<char> set = new HashSet<char>();

        for (int i = 0; i < second.Length; i++)
            set.Add(char.ToLower(second[i]));

        StringBuilder sb = new StringBuilder();

        for (int i = 0; i < first.Length; i++)
        {
            char c = first[i];
            char lower = char.ToLower(c);

            if (!IsVowel(c) && set.Contains(lower))
                continue;

            sb.Append(c);
        }

        StringBuilder result = new StringBuilder();

        for (int i = 0; i < sb.Length; i++)
        {
            if (i == 0 || sb[i] != sb[i - 1])
                result.Append(sb[i]);
        }

        return result.ToString();
    }

    public static void Main()
    {
        string first = Console.ReadLine();
        string second = Console.ReadLine();

        Console.WriteLine(Process(first, second));
    }
}
