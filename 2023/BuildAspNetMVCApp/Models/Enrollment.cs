using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace StudentManagement.Models
{
    public enum Grade { 
        A, B, C, D, E
    }
    public class Enrollment
    {
        public int EnrollmentID { get; set; }
        //[Key, Column(Order = 1)]
        public int StudentID { get; set; }
        //[Key, Column(Order = 2)]
        public int CourseID { get; set; }
        public Grade Grade { get; set; }
        public string? Remarks { get; set; }

        //navigation
        public Course Course { get; set; }
        public Student Student { get; set; }

    }
}
