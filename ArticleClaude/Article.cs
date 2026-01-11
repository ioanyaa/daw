using System.ComponentModel.DataAnnotations;

namespace ArticlesApp.Models
{
    public class Article
    {
        [Key]
        public int Id { get; set; }

        [Required(ErrorMessage = "Titlul este obligatoriu")]
        [StringLength(200, MinimumLength = 5, ErrorMessage = "Titlul trebuie să aibă între 5 și 200 caractere")]
        [Display(Name = "Titlu")]
        public string Title { get; set; }

        [Required(ErrorMessage = "Conținutul este obligatoriu")]
        [MinLength(10, ErrorMessage = "Conținutul trebuie să aibă minim 10 caractere")]
        [Display(Name = "Conținut")]
        public string Content { get; set; }

        [Required(ErrorMessage = "Data este obligatorie")]
        [Display(Name = "Data Publicării")]
        public DateTime Date { get; set; }

        [Required(ErrorMessage = "Categoria este obligatorie")]
        [Display(Name = "Categorie")]
        public int CategoryId { get; set; }

        // Navigation property
        public virtual Category? Category { get; set; }
    }
}
