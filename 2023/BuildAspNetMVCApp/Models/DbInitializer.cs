namespace StudentManagement.Models
{
    public static class DbInitializer
    {
        public static void Initialize(StudentManagementContext context)
        {
            //Dependency Injection

            context.Database.EnsureCreated();

            // Look for any students.
            if (context.Students.Any())
            {
                return;   // DB has been seeded(faked data)
            }

            var students = new Student[]
            {
                new Student {
                    StudentName = "Nguyen Van A",
                    DOB = DateTime.Parse("1993-12-22"),
                    Email = "nguyenvaa@gmail.com",
                    Address = "Nha A, ngo B"
                },
                new Student {
                    StudentName = "Alan",
                    DOB = DateTime.Parse("2000-11-25"),
                    Email = "alanba@gmail.com",
                    Address = "Nhsssa A, nssgo B"
                },
            };
           
            foreach (Student s in students)
            {
                context.Students.Add(s); //insert multiple in SQL
            }
            context.SaveChanges();//commit

            var courses = new Course[]
            {
                new Course { 
                    //init "builder pattern"
                    CourseID = 1111,
                    CourseName = "SQL Server",
                    Duration = 40,
                    Description = "Khoa hoc SQL SErver cho nguoi moi",
                    StartDate = DateTime.Parse("2022-06-05")
                },
                new Course {
                    CourseID = 2222,
                    CourseName = "Unity game C#",
                    Duration = 20,
                    Description = "Lap trinh game",
                    StartDate = DateTime.Parse("2020-05-05")
                },
             };
            foreach (Course c in courses)
            {
                context.Courses.Add(c);
            }
            context.SaveChanges();

            var enrollments = new Enrollment[]
            {
                new Enrollment{ 
                    StudentID = 1,
                    CourseID = 2222,
                    Grade = Grade.A,
                },
                new Enrollment{
                    StudentID = 2,
                    CourseID = 1111,
                    Grade = Grade.C,
                    Remarks = "This is good"
                },         
            };
            foreach (Enrollment e in enrollments)
            {
                context.Enrollments.Add(e);
            }
            context.SaveChanges();//commit
        }
    }
}
