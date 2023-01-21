using System.ComponentModel.DataAnnotations.Schema;

namespace StudentManagement.Models
{
    public class Course
    {
        [DatabaseGenerated(DatabaseGeneratedOption.None)]
        public int CourseID { get; set; }
        public string CourseName { get; set; }
        public string? Description { get; set; }
        public int Duration { get; set; }
        public DateTime StartDate { get; set; }
        
        //navigation property
        public ICollection<Enrollment> Enrollments { get; set; }
    }
}
