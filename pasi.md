Voi crea un ghid complet pas cu pas pentru aplicația de gestionare articole și categorii.

## GHID COMPLET - Aplicație Articles & Categories

### PASUL 1: Creare Proiect

1. **Visual Studio** → New Project
2. Selectează **ASP.NET Core Web App (Model-View-Controller)**
3. Nume: `ArticlesApp`
4. Framework: **.NET 6.0** (sau mai nou)
5. Authentication type: **None**
6. Create

---

### PASUL 2: Instalare Pachete NuGet

**Tools → NuGet Package Manager → Package Manager Console**

```powershell
Install-Package Microsoft.EntityFrameworkCore.SqlServer
Install-Package Microsoft.EntityFrameworkCore.Tools
```

---

### PASUL 3: Creare Modele

**Models/Category.cs**
```csharp
using System.ComponentModel.DataAnnotations;

namespace ArticlesApp.Models
{
    public class Category
    {
        [Key]
        public int Id { get; set; }

        [Required(ErrorMessage = "Titlul categoriei este obligatoriu")]
        [StringLength(100, ErrorMessage = "Titlul nu poate depăși 100 de caractere")]
        public string Title { get; set; }

        // Relație one-to-many
        public virtual ICollection<Article> Articles { get; set; } = new List<Article>();
    }
}
```

**Models/Article.cs**
```csharp
using System.ComponentModel.DataAnnotations;

namespace ArticlesApp.Models
{
    public class Article
    {
        [Key]
        public int Id { get; set; }

        [Required(ErrorMessage = "Titlul este obligatoriu")]
        [StringLength(200, MinimumLength = 5, ErrorMessage = "Titlul trebuie să aibă între 5 și 200 caractere")]
        public string Title { get; set; }

        [Required(ErrorMessage = "Conținutul este obligatoriu")]
        [MinLength(10, ErrorMessage = "Conținutul trebuie să aibă minim 10 caractere")]
        public string Content { get; set; }

        [Required(ErrorMessage = "Data este obligatorie")]
        public DateTime Date { get; set; }

        [Required(ErrorMessage = "Categoria este obligatorie")]
        public int CategoryId { get; set; }

        // Navigation property
        public virtual Category? Category { get; set; }
    }
}
```

---

### PASUL 4: Creare DbContext

**Data/ApplicationDbContext.cs** (crează folderul Data mai întâi)

```csharp
using ArticlesApp.Models;
using Microsoft.EntityFrameworkCore;

namespace ArticlesApp.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) 
            : base(options)
        {
        }

        public DbSet<Article> Articles { get; set; }
        public DbSet<Category> Categories { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Configurare relație
            modelBuilder.Entity<Article>()
                .HasOne(a => a.Category)
                .WithMany(c => c.Articles)
                .HasForeignKey(a => a.CategoryId)
                .OnDelete(DeleteBehavior.Restrict); // Previne ștergerea categoriei dacă are articole
        }
    }
}
```

---

### PASUL 5: Configurare Connection String

**appsettings.json**
```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=(localdb)\\mssqllocaldb;Database=ArticlesDb;Trusted_Connection=True;MultipleActiveResultSets=true"
  },
  "Logging": {
    "LogLevel": {
      "Default": "Information",
      "Microsoft.AspNetCore": "Warning"
    }
  },
  "AllowedHosts": "*"
}
```

---

### PASUL 6: Configurare Program.cs

**Program.cs**
```csharp
using ArticlesApp.Data;
using Microsoft.EntityFrameworkCore;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container
builder.Services.AddControllersWithViews();

// Configurare DbContext
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));

var app = builder.Build();

// Configure the HTTP request pipeline
if (!app.Environment.IsDevelopment())
{
    app.UseExceptionHandler("/Home/Error");
    app.UseHsts();
}

app.UseHttpsRedirection();
app.UseStaticFiles();

app.UseRouting();

app.UseAuthorization();

app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Articles}/{action=Index}/{id?}");

app.Run();
```

---

### PASUL 7: Creare și Rulare Migrații

**Package Manager Console:**

```powershell
Add-Migration InitialCreate
Update-Database
```

---

### PASUL 8: Adăugare Date de Test

**SQL Server Object Explorer** → ArticlesDb → Tables

**Inserează categorii:**
```sql
INSERT INTO Categories (Title) VALUES ('Tehnologie');
INSERT INTO Categories (Title) VALUES ('Sport');
INSERT INTO Categories (Title) VALUES ('Cultură');
INSERT INTO Categories (Title) VALUES ('Știință');
```

**Inserează articole:**
```sql
INSERT INTO Articles (Title, Content, Date, CategoryId) 
VALUES ('Noua versiune .NET', 'Conținut despre .NET 9...', GETDATE(), 1);

INSERT INTO Articles (Title, Content, Date, CategoryId) 
VALUES ('Campionatul Mondial', 'Rezumat competiție...', GETDATE(), 2);

INSERT INTO Articles (Title, Content, Date, CategoryId) 
VALUES ('Expoziție de artă', 'Vernisaj la muzeu...', GETDATE(), 3);
```

---

### PASUL 9: Controller pentru Articles

**Controllers/ArticlesController.cs** (Add → Controller → MVC Controller - Empty)

```csharp
using ArticlesApp.Data;
using ArticlesApp.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;

namespace ArticlesApp.Controllers
{
    public class ArticlesController : Controller
    {
        private readonly ApplicationDbContext _context;

        public ArticlesController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: Articles
        public IActionResult Index()
        {
            var articles = _context.Articles
                .Include(a => a.Category)
                .OrderByDescending(a => a.Date)
                .ToList();

            return View(articles);
        }

        // GET: Articles/Details/5
        public IActionResult Details(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var article = _context.Articles
                .Include(a => a.Category)
                .FirstOrDefault(a => a.Id == id);

            if (article == null)
            {
                return NotFound();
            }

            return View(article);
        }

        // GET: Articles/Create
        public IActionResult Create()
        {
            ViewBag.Categories = new SelectList(_context.Categories, "Id", "Title");
            return View();
        }

        // POST: Articles/Create
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Create([Bind("Title,Content,Date,CategoryId")] Article article)
        {
            if (ModelState.IsValid)
            {
                _context.Articles.Add(article);
                _context.SaveChanges();
                TempData["SuccessMessage"] = "Articolul a fost creat cu succes!";
                return RedirectToAction(nameof(Index));
            }

            ViewBag.Categories = new SelectList(_context.Categories, "Id", "Title", article.CategoryId);
            return View(article);
        }

        // GET: Articles/Edit/5
        public IActionResult Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var article = _context.Articles.Find(id);
            if (article == null)
            {
                return NotFound();
            }

            ViewBag.Categories = new SelectList(_context.Categories, "Id", "Title", article.CategoryId);
            return View(article);
        }

        // POST: Articles/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Edit(int id, [Bind("Id,Title,Content,Date,CategoryId")] Article article)
        {
            if (id != article.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(article);
                    _context.SaveChanges();
                    TempData["SuccessMessage"] = "Articolul a fost modificat cu succes!";
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!ArticleExists(article.Id))
                    {
                        return NotFound();
                    }
                    else
                    {
                        throw;
                    }
                }
                return RedirectToAction(nameof(Index));
            }

            ViewBag.Categories = new SelectList(_context.Categories, "Id", "Title", article.CategoryId);
            return View(article);
        }

        // GET: Articles/Delete/5
        public IActionResult Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var article = _context.Articles
                .Include(a => a.Category)
                .FirstOrDefault(a => a.Id == id);

            if (article == null)
            {
                return NotFound();
            }

            return View(article);
        }

        // POST: Articles/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public IActionResult DeleteConfirmed(int id)
        {
            var article = _context.Articles.Find(id);
            if (article != null)
            {
                _context.Articles.Remove(article);
                _context.SaveChanges();
                TempData["SuccessMessage"] = "Articolul a fost șters cu succes!";
            }

            return RedirectToAction(nameof(Index));
        }

        private bool ArticleExists(int id)
        {
            return _context.Articles.Any(e => e.Id == id);
        }
    }
}
```

---

### PASUL 10: View-uri pentru Articles

**Views/Articles/Index.cshtml** (Add → View → Razor View - Empty)

```html
@model IEnumerable<ArticlesApp.Models.Article>

@{
    ViewData["Title"] = "Lista Articole";
}

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h1>@ViewData["Title"]</h1>
        <a asp-action="Create" class="btn btn-primary">
            <i class="bi bi-plus-circle"></i> Adaugă Articol Nou
        </a>
    </div>

    @if (TempData["SuccessMessage"] != null)
    {
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            @TempData["SuccessMessage"]
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    }

    <div class="table-responsive">
        <table class="table table-hover table-striped">
            <thead class="table-dark">
                <tr>
                    <th>Titlu</th>
                    <th>Categorie</th>
                    <th>Data Publicării</th>
                    <th style="width: 200px;">Acțiuni</th>
                </tr>
            </thead>
            <tbody>
                @foreach (var article in Model)
                {
                    <tr>
                        <td>@article.Title</td>
                        <td>
                            <span class="badge bg-info">@article.Category?.Title</span>
                        </td>
                        <td>@article.Date.ToString("dd.MM.yyyy HH:mm")</td>
                        <td>
                            <a asp-action="Details" asp-route-id="@article.Id" class="btn btn-sm btn-info">
                                Detalii
                            </a>
                            <a asp-action="Edit" asp-route-id="@article.Id" class="btn btn-sm btn-warning">
                                Editează
                            </a>
                            <a asp-action="Delete" asp-route-id="@article.Id" class="btn btn-sm btn-danger">
                                Șterge
                            </a>
                        </td>
                    </tr>
                }
            </tbody>
        </table>
    </div>

    @if (!Model.Any())
    {
        <div class="alert alert-info">
            Nu există articole. <a asp-action="Create">Creează primul articol!</a>
        </div>
    }
</div>
```

**Views/Articles/Details.cshtml**

```html
@model ArticlesApp.Models.Article

@{
    ViewData["Title"] = "Detalii Articol";
}

<div class="container mt-4">
    <h1>@ViewData["Title"]</h1>
    <hr />

    <div class="card">
        <div class="card-header bg-primary text-white">
            <h3>@Model.Title</h3>
        </div>
        <div class="card-body">
            <dl class="row">
                <dt class="col-sm-3">Categorie</dt>
                <dd class="col-sm-9">
                    <span class="badge bg-info fs-6">@Model.Category?.Title</span>
                </dd>

                <dt class="col-sm-3">Data Publicării</dt>
                <dd class="col-sm-9">@Model.Date.ToString("dd MMMM yyyy, HH:mm")</dd>

                <dt class="col-sm-3">Conținut</dt>
                <dd class="col-sm-9">
                    <div class="border p-3 bg-light rounded">
                        @Model.Content
                    </div>
                </dd>
            </dl>
        </div>
        <div class="card-footer">
            <a asp-action="Edit" asp-route-id="@Model.Id" class="btn btn-warning">Editează</a>
            <a asp-action="Delete" asp-route-id="@Model.Id" class="btn btn-danger">Șterge</a>
            <a asp-action="Index" class="btn btn-secondary">Înapoi la listă</a>
        </div>
    </div>
</div>
```

**Views/Articles/Create.cshtml**

```html
@model ArticlesApp.Models.Article

@{
    ViewData["Title"] = "Adaugă Articol";
}

<div class="container mt-4">
    <h1>@ViewData["Title"]</h1>
    <hr />

    <div class="row">
        <div class="col-md-8">
            <form asp-action="Create" method="post">
                <div asp-validation-summary="ModelOnly" class="alert alert-danger"></div>

                <div class="mb-3">
                    <label asp-for="Title" class="form-label"></label>
                    <input asp-for="Title" class="form-control" />
                    <span asp-validation-for="Title" class="text-danger"></span>
                </div>

                <div class="mb-3">
                    <label asp-for="Content" class="form-label"></label>
                    <textarea asp-for="Content" class="form-control" rows="6"></textarea>
                    <span asp-validation-for="Content" class="text-danger"></span>
                </div>

                <div class="mb-3">
                    <label asp-for="Date" class="form-label"></label>
                    <input asp-for="Date" type="datetime-local" class="form-control" />
                    <span asp-validation-for="Date" class="text-danger"></span>
                </div>

                <div class="mb-3">
                    <label asp-for="CategoryId" class="form-label">Categorie</label>
                    <select asp-for="CategoryId" class="form-select" asp-items="ViewBag.Categories">
                        <option value="">-- Selectează Categoria --</option>
                    </select>
                    <span asp-validation-for="CategoryId" class="text-danger"></span>
                </div>

                <div class="mt-4">
                    <button type="submit" class="btn btn-primary">Salvează</button>
                    <a asp-action="Index" class="btn btn-secondary">Anulează</a>
                </div>
            </form>
        </div>
    </div>
</div>

@section Scripts {
    @{await Html.RenderPartialAsync("_ValidationScriptsPartial");}
}
```

**Views/Articles/Edit.cshtml**

```html
@model ArticlesApp.Models.Article

@{
    ViewData["Title"] = "Editează Articol";
}

<div class="container mt-4">
    <h1>@ViewData["Title"]</h1>
    <hr />

    <div class="row">
        <div class="col-md-8">
            <form asp-action="Edit" method="post">
                <input type="hidden" asp-for="Id" />
                <div asp-validation-summary="ModelOnly" class="alert alert-danger"></div>

                <div class="mb-3">
                    <label asp-for="Title" class="form-label"></label>
                    <input asp-for="Title" class="form-control" />
                    <span asp-validation-for="Title" class="text-danger"></span>
                </div>

                <div class="mb-3">
                    <label asp-for="Content" class="form-label"></label>
                    <textarea asp-for="Content" class="form-control" rows="6"></textarea>
                    <span asp-validation-for="Content" class="text-danger"></span>
                </div>

                <div class="mb-3">
                    <label asp-for="Date" class="form-label"></label>
                    <input asp-for="Date" type="datetime-local" class="form-control" />
                    <span asp-validation-for="Date" class="text-danger"></span>
                </div>

                <div class="mb-3">
                    <label asp-for="CategoryId" class="form-label">Categorie</label>
                    <select asp-for="CategoryId" class="form-select" asp-items="ViewBag.Categories">
                        <option value="">-- Selectează Categoria --</option>
                    </select>
                    <span asp-validation-for="CategoryId" class="text-danger"></span>
                </div>

                <div class="mt-4">
                    <button type="submit" class="btn btn-primary">Salvează Modificările</button>
                    <a asp-action="Index" class="btn btn-secondary">Anulează</a>
                </div>
            </form>
        </div>
    </div>
</div>

@section Scripts {
    @{await Html.RenderPartialAsync("_ValidationScriptsPartial");}
}
```

**Views/Articles/Delete.cshtml**

```html
@model ArticlesApp.Models.Article

@{
    ViewData["Title"] = "Șterge Articol";
}

<div class="container mt-4">
    <h1 class="text-danger">@ViewData["Title"]</h1>
    <hr />

    <div class="alert alert-warning">
        <h4>Ești sigur că vrei să ștergi acest articol?</h4>
    </div>

    <div class="card">
        <div class="card-body">
            <dl class="row">
                <dt class="col-sm-3">Titlu</dt>
                <dd class="col-sm-9">@Model.Title</dd>

                <dt class="col-sm-3">Categorie</dt>
                <dd class="col-sm-9">@Model.Category?.Title</dd>

                <dt class="col-sm-3">Data</dt>
                <dd class="col-sm-9">@Model.Date.ToString("dd.MM.yyyy HH:mm")</dd>

                <dt class="col-sm-3">Conținut</dt>
                <dd class="col-sm-9">@Model.Content</dd>
            </dl>
        </div>
    </div>

    <form asp-action="Delete" method="post" class="mt-3">
        <input type="hidden" asp-for="Id" />
        <button type="submit" class="btn btn-danger">Șterge Definitiv</button>
        <a asp-action="Index" class="btn btn-secondary">Anulează</a>
    </form>
</div>
```

---

### PASUL 11: Controller pentru Categories

**Controllers/CategoriesController.cs**

```csharp
using ArticlesApp.Data;
using ArticlesApp.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ArticlesApp.Controllers
{
    public class CategoriesController : Controller
    {
        private readonly ApplicationDbContext _context;

        public CategoriesController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: Categories
        public IActionResult Index()
        {
            var categories = _context.Categories
                .Include(c => c.Articles)
                .ToList();
            return View(categories);
        }

        // GET: Categories/Delete/5
        public IActionResult Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var category = _context.Categories
                .Include(c => c.Articles)
                .FirstOrDefault(c => c.Id == id);

            if (category == null)
            {
                return NotFound();
            }

            return View(category);
        }

        // POST: Categories/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public IActionResult DeleteConfirmed(int id)
        {
            var category = _context.Categories
                .Include(c => c.Articles)
                .FirstOrDefault(c => c.Id == id);

            if (category == null)
            {
                return NotFound();
            }

            // Verificare dacă categoria are articole
            if (category.Articles.Any())
            {
                TempData["ErrorMessage"] = "Nu poți șterge această categorie deoarece conține articole!";
                return RedirectToAction(nameof(Index));
            }

            _context.Categories.Remove(category);
            _context.SaveChanges();
            TempData["SuccessMessage"] = "Categoria a fost ștearsă cu succes!";

            return RedirectToAction(nameof(Index));
        }
    }
}
```

---

### PASUL 12: View-uri pentru Categories

**Views/Categories/Index.cshtml**

```html
@model IEnumerable<ArticlesApp.Models.Category>

@{
    ViewData["Title"] = "Categorii";
}

<div class="container mt-4">
    <h1>@ViewData["Title"]</h1>
    <hr />

    @if (TempData["SuccessMessage"] != null)
    {
        <div class="alert alert-success alert-dismissible fade show">
            @TempData["SuccessMessage"]
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    }

    @if (TempData["ErrorMessage"] != null)
    {
        <div class="alert alert-danger alert-dismissible fade show">
            @TempData["ErrorMessage"]
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
    }

    <table class="table table-hover">
        <thead class="table-dark">
            <tr>
                <th>Denumire</th>
                <th>Număr Articole</th>
                <th>Acțiuni</th>
            </tr>
        </thead>
        <tbody>
            @foreach (var category in Model)
            {
                <tr>
                    <td>@category.Title</td>
                    <td>
                        <span class="badge bg-primary">@category.Articles.Count articole</span>
                    </td>
                    <td>
                        <a asp-action="Delete" asp-route-id="@category.Id" class="btn btn-sm btn-danger">
                            Șterge
                        </a>
                    </td>
                </tr>
            }
        </tbody>
    </table>

    <a asp-controller="Articles" asp-action="Index" class="btn btn-secondary">
        Înapoi la Articole
    </a>
</div>
```

**Views/Categories/Delete.cshtml**

```html
@model ArticlesApp.Models.Category

@{
    ViewData["Title"] = "Șterge Categorie";
}

<div class="container mt-4">
    <h1 class="text-danger">@ViewData["Title"]</h1>
    <hr />

    @if (Model.Articles.Any())
    {
        <div class="alert alert-danger">
            <h4>⚠️ Această categorie NU poate fi ștearsă!</h4>
            <p>Categoria conține <strong>@Model.Articles.Count articole</strong>. Șterge mai întâi articolele sau mută-le în altă categorie.</p>
        </div>

        <h5>Articole în această categorie:</h5>
        <ul class="list-group mb-3">
            @foreach (var article in Model.Articles)
            {
                <li class="list-group-item">
                    @article.Title
                    <a asp-controller="Articles" asp-action="Details" asp-route-id="@article.Id" class="btn btn-sm btn-info float-end">
                        Vezi
                    </a>
                </li>
            }
        </ul>

        <a asp-action="Index" class="btn btn-secondary">Înapoi</a>
    }
    else
    {
        <div class="alert alert-warning">
            <h4>Ești sigur că vrei să ștergi această categorie?</h4>
        </div>

        <dl class="row">
            <dt class="col-sm-3">Denumire</dt>
            <dd class="col-sm-9">@Model.Title</dd>

            <dt class="col-sm-3">Articole</dt>
            <dd class="col-sm-9">
                <span class="badge bg-success">Niciun articol</span>
            </dd>
        </dl>

        <form asp-action="Delete" method="post">
            <input type="hidden" asp-for="Id" />
            <button type="submit" class="btn btn-danger">Șterge Definitiv</button>
            <a asp-action="Index" class="btn btn-secondary">Anulează</a>
        </form>
    }
</div>
```

---

### PASUL 13: Actualizare Layout

**Views/Shared/_Layout.cshtml** - adaugă în navbar:

```html
<li class="nav-item">
    <a class="nav-link text-dark" asp-controller="Articles" asp-action="Index">Articole</a>
</li>
<li class="nav-item">
    <a class="nav-link text-dark" asp-controller="Categories" asp-action="Index">Categorii</a>
</li>
```

---

### PASUL 14: Rulare și Testare

1. **Apasă F5** sau Run
2. Navigează la **Articles/Index**
3. Testează toate operațiunile CRUD

---

## ✅ CHECKLIST FINAL

- ✅ Modele cu validări
- ✅ DbContext configurat
- ✅ Migrații create și rulate
- ✅ Date de test adăugate
- ✅ CRUD complet Articles
- ✅ Dropdown pentru categorii
- ✅ Ștergere categorii cu validare
- ✅ Afișare relații (Article + Category)
- ✅ Validări și helpere
- ✅ TempData pentru mesaje
- ✅ Design Bootstrap

Aplicația este completă și respectă toate cerințele! 🎉
