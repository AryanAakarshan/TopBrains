using System;
using System.Collections.Generic;
using System.Linq;
class Program
{
public class Student
{
    public string Name{get; set;}
    public int Age{get; set;}
    public int Marks{get; set;}
}
public class StudentComparer : IComparer<Student>
{
    public int Compare(Student? x, Student? y)
    {
        if (x == null && y == null) return 0;
        if (x == null) return -1;
        if (y == null) return 1;

        int marksCompare = y.Marks.CompareTo(x.Marks);
        if (marksCompare != 0)
            return marksCompare;
        return x.Age.CompareTo(y.Age);
    }
}
    static void Main()
    {
        List<Student> Students = new List<Student>
        {
            new Student{Name = "Aryan", Age = 21, Marks = 98},
            new Student{Name = "Sanjana", Age = 22, Marks = 98},
            new Student{Name = "Navneet", Age = 22, Marks = 99}
        };
        Students.Sort(new StudentComparer());
        foreach (var s in Students)
        {
            Console.WriteLine($"Name: {s.Name}, Age: {s.Age}, Marks: {s.Marks}");
        }
        Console.WriteLine();
    }
}
