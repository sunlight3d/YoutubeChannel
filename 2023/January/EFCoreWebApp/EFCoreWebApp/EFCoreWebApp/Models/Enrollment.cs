using System.ComponentModel.DataAnnotations;

namespace EFCoreWebApp.Models
{
    public enum Grade
    {
        A, B, C, D, F
    }

    public class Enrollment
    {
        public int EnrollmentID { get; set; }
        public int CourseID { get; set; }
        public Course Course { get; set; } //navigation property


        [DisplayFormat(NullDisplayText = "No grade")]
        public Grade? Grade { get; set; }

        public DateTime StartDate { get; set; } //DateOnly cannot be mapped
        
        public Student Student { get; set; }//navigation property
        public int StudentID { get; set; }
    }
}
