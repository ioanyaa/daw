using System.ComponentModel.DataAnnotations;

namespace ArticlesApp.Models
{
    public class Category
    {
        [Key]
        public int Id { get; set; }

        [Required(ErrorMessage = "Titlul categoriei este obligatoriu")]
        [StringLength(100, ErrorMessage = "Titlul nu poate depăși 100 de caractere")]
        [Display(Name = "Denumire Categorie")]
        public string Title { get; set; }

        // Relație one-to-many
        public virtual ICollection<Article> Articles { get; set; } = new List<Article>();
    }
}
