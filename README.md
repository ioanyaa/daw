# 📚 Rezumat Complet Cursuri 1-12 - Dezvoltarea Aplicațiilor Web

**ASP.NET Core MVC | Ghid complet pentru examen**

---

## 📑 Cuprins

1. [Introducere în Aplicații Web și ASP.NET](#curs-1)
2. [Fundamentele C#](#curs-2)
3. [Arhitectura MVC și Rutare](#curs-3)
4. [Controller - Actions și Parametri](#curs-4)
5. [Model și Entity Framework Core](#curs-5)
6. [Baze de Date și LINQ](#curs-6)
7. [View și Razor - Trimiterea Datelor](#curs-7)
8. [Validări și Layout-uri](#curs-8)
9. [Paginare, Editor Text, Căutare](#curs-10)
10. [REST API și Identity Framework](#curs-11)
11. [Integrare Completă și Best Practices](#integrare)

---

## <a name="curs-1"></a>📖 Curs 1: Introducere în Aplicații Web și ASP.NET

### 🎯 Concepte teoretice

#### Ce este o aplicație Web?
- **Definiție**: Aplicație software care rulează pe un server web și este accesată printr-un browser
- **Comunicare**: Protocol HTTP/HTTPS între client și server
- **Avantaje**:
  - Accesibilă de pe orice dispozitiv cu browser
  - Nu necesită instalare
  - Actualizări centralizate
  - Cross-platform (Windows, Mac, Linux, Mobile)

#### Arhitectura Web (Client-Server)
```
┌──────────┐         HTTP Request          ┌──────────┐
│          │ ───────────────────────────> │          │
│  CLIENT  │                               │  SERVER  │
│ (Browser)│ <─────────────────────────── │   (Web)  │
└──────────┘         HTTP Response         └──────────┘
```

**Componente:**
- **Client (Browser)**: Trimite cereri HTTP, renderizează HTML/CSS/JS
- **Server**: Procesează cererile, interacționează cu BD, returnează răspunsuri
- **Protocol HTTP**: GET, POST, PUT, DELETE, PATCH

#### ASP.NET Core
- **Framework open-source** dezvoltat de Microsoft
- **Cross-platform**: Windows, Linux, macOS
- **Performanță ridicată** și modular
- **Versiuni**: .NET Core 3.1, .NET 5, 6, 7, 8, 9

#### CLR (Common Language Runtime)
**Motor de execuție pentru .NET**:
- **Garbage Collection**: Gestionare automată a memoriei
- **Compilare JIT** (Just-In-Time): Transformă IL în cod nativ
- **Gestionarea excepțiilor**
- **Securitate** și verificare tipuri

#### Ciclul de viață al unei pagini Web
```
1. REQUEST → Browser trimite cerere HTTP
2. ROUTING → Identifică controller și acțiune
3. CONTROLLER → Procesează cererea
4. MODEL → Gestionează datele
5. VIEW → Generează HTML
6. RESPONSE → Server trimite răspunsul
```

### 💻 Practică

**Crearea primului proiect ASP.NET Core MVC:**
```bash
dotnet new mvc -n NumeProiect
cd NumeProiect
dotnet run
```

**Structura de bază:**
- `Program.cs` - Punct de intrare
- `Controllers/` - Logica aplicației
- `Models/` - Structuri de date
- `Views/` - Interfață utilizator
- `wwwroot/` - Fișiere statice (CSS, JS, imagini)

---

## <a name="curs-2"></a>🔤 Curs 2: Fundamentele C#

### 🎯 Concepte teoretice

#### C# - Limbaj compilat
- **Orientat pe obiecte**
- **Type-safe**: Verificare tipuri la compilare
- **Compilare**: C# → IL (Intermediate Language) → CLR → Cod mașină

#### Tipuri de date fundamentale

| Tip | Descriere | Exemple |
|-----|-----------|---------|
| `int` | Numere întregi | 5, -10, 0 |
| `double` | Numere cu virgulă | 3.14, -0.5 |
| `decimal` | Numere precise (bani) | 19.99m |
| `string` | Text | "Hello", "ASP.NET" |
| `bool` | Boolean | true, false |
| `char` | Caracter | 'A', 'z' |
| `DateTime` | Date și timp | DateTime.Now |
| `var` | Inferență automată | var x = 5; |

#### Nullable Types
```csharp
int? numar = null;        // Poate fi null
string? text = null;      // String nullable (C# 8.0+)
DateTime? data = null;    // DateTime nullable
```

### 💻 Practică

#### Structura unui program C#
```csharp
using System;

namespace NumeProiect
{
    public class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Hello World!");
        }
    }
}
```

#### Instrucțiuni de control

**If-Else:**
```csharp
if (varsta >= 18)
{
    Console.WriteLine("Major");
}
else if (varsta >= 14)
{
    Console.WriteLine("Adolescent");
}
else
{
    Console.WriteLine("Minor");
}
```

**Switch:**
```csharp
switch (zi)
{
    case "Luni":
        Console.WriteLine("Începe săptămâna");
        break;
    case "Vineri":
        Console.WriteLine("Weekend aproape!");
        break;
    default:
        Console.WriteLine("Zi normală");
        break;
}
```

**Bucle:**
```csharp
// For loop
for (int i = 0; i < 10; i++)
{
    Console.WriteLine(i);
}

// While loop
int j = 0;
while (j < 5)
{
    Console.WriteLine(j);
    j++;
}

// Foreach loop
string[] names = { "Ana", "Ion", "Maria" };
foreach (var name in names)
{
    Console.WriteLine(name);
}
```

#### Clase și Obiecte (OOP)

**Definire clasă:**
```csharp
public class Student
{
    // Proprietăți (Properties)
    public int Id { get; set; }
    public string Name { get; set; }
    public string Email { get; set; }
    public int? Age { get; set; }  // Nullable
    
    // Constructor
    public Student()
    {
        // Constructor implicit
    }
    
    public Student(string name, string email)
    {
        Name = name;
        Email = email;
    }
    
    // Metodă
    public void DisplayInfo()
    {
        Console.WriteLine($"Nume: {Name}, Email: {Email}");
    }
}
```

**Utilizare clasă:**
```csharp
// Creare instanță
Student student1 = new Student();
student1.Name = "Ion Popescu";
student1.Email = "ion@example.com";

// Cu constructor
Student student2 = new Student("Maria", "maria@example.com");

// Apelare metodă
student1.DisplayInfo();
```

#### Array-uri și Colecții
```csharp
// Array
int[] numbers = new int[5];
string[] names = { "Ana", "Ion", "Maria" };

// List<T>
List<string> studenti = new List<string>();
studenti.Add("Ana");
studenti.Add("Ion");

// Dictionary<TKey, TValue>
Dictionary<int, string> dict = new Dictionary<int, string>();
dict.Add(1, "Unu");
dict.Add(2, "Doi");
```

#### Convenții de nume (IMPORTANT!)

| Tip | Convenție | Exemplu |
|-----|-----------|---------|
| Clase | PascalCase | `Student`, `ArticleController` |
| Metode | PascalCase | `GetStudents()`, `SaveData()` |
| Proprietăți | PascalCase | `Name`, `Email`, `StudentId` |
| Variabile locale | camelCase | `firstName`, `studentCount` |
| Parametri | camelCase | `void Save(string name)` |
| Câmpuri private | _camelCase | `_database`, `_context` |
| Constante | UPPER_CASE | `MAX_SIZE`, `DEFAULT_VALUE` |

---

## <a name="curs-3"></a>🏗️ Curs 3: Arhitectura MVC și Rutare

### 🎯 Concepte teoretice

#### Arhitectura MVC

```
┌─────────────────────────────────────────┐
│              REQUEST                     │
│                  ↓                       │
│  ┌───────────────────────────────────┐  │
│  │         CONTROLLER                │  │
│  │  (Procesează cererea)             │  │
│  └───────────────────────────────────┘  │
│         ↓                    ↓           │
│  ┌──────────┐        ┌─────────────┐    │
│  │  MODEL   │  ←───→ │    VIEW     │    │
│  │ (Date)   │        │ (Interfață) │    │
│  └──────────┘        └─────────────┘    │
│                           ↓              │
│                      RESPONSE            │
└─────────────────────────────────────────┘
```

#### 1. MODEL (Stratul business)
**Responsabilități:**
- Reprezintă datele aplicației
- Conține logica business
- Interacționează cu baza de date (prin EF Core)
- Validează datele
- **Independent** de View și Controller

**Exemplu:**
```csharp
public class Article
{
    public int Id { get; set; }
    public string Title { get; set; }
    public string Content { get; set; }
    public DateTime Date { get; set; }
}
```

#### 2. VIEW (Interfața cu utilizatorul)
**Responsabilități:**
- Afișează datele către utilizator
- Conține HTML + Razor syntax
- Primește date de la Controller
- **NU conține logică business**

**Exemplu:**
```html
@model Article

<h1>@Model.Title</h1>
<p>@Model.Content</p>
<span>@Model.Date.ToString("dd/MM/yyyy")</span>
```

#### 3. CONTROLLER (Logica de control)
**Responsabilități:**
- Procesează cererile HTTP
- Intermediază între Model și View
- Conține Actions (metode)
- Returnează IActionResult

**Exemplu:**
```csharp
public class ArticlesController : Controller
{
    public IActionResult Index()
    {
        // Logică
        return View();
    }
}
```

### 🗂️ Structura unui proiect MVC

```
ProiectMVC/
├── Controllers/
│   ├── HomeController.cs
│   ├── ArticlesController.cs
│   └── StudentsController.cs
├── Models/
│   ├── Article.cs
│   ├── Student.cs
│   └── Category.cs
├── Views/
│   ├── Home/
│   │   ├── Index.cshtml
│   │   └── Privacy.cshtml
│   ├── Articles/
│   │   ├── Index.cshtml
│   │   ├── Show.cshtml
│   │   └── New.cshtml
│   └── Shared/
│       ├── _Layout.cshtml
│       ├── _LoginPartial.cshtml
│       └── Error.cshtml
├── Data/
│   └── ApplicationDbContext.cs
├── wwwroot/
│   ├── css/
│   ├── js/
│   └── lib/
├── appsettings.json
└── Program.cs
```

### 🛣️ Sistemul de Rutare

#### Conventional Routing (în Program.cs)
```csharp
app.MapControllerRoute(
    name: "default",
    pattern: "{controller=Home}/{action=Index}/{id?}"
);
```

**Format URL:** `/Controller/Action/Id`

**Exemple:**
- `/` → `Home/Index`
- `/Articles` → `Articles/Index`
- `/Articles/Show/5` → `Articles/Show(id=5)`

**Parametri:**
- `{controller=Home}` - Controller implicit
- `{action=Index}` - Acțiune implicită
- `{id?}` - Parametru opțional (? = optional)

#### Attribute Routing (în Controller)
```csharp
[Route("articles")]
public class ArticlesController : Controller
{
    [Route("")]  // /articles
    public IActionResult Index()
    {
        return View();
    }
    
    [Route("{id}")]  // /articles/5
    public IActionResult Show(int id)
    {
        return View();
    }
    
    [Route("new")]  // /articles/new
    public IActionResult New()
    {
        return View();
    }
}
```

#### Constrângeri pentru parametri (Route Constraints)
```csharp
// Id trebuie să fie întreg
[Route("articles/{id:int}")]

// Id între 1 și 100
[Route("articles/{id:int:min(1):max(100)}")]

// String cu lungime minimă
[Route("search/{query:minlength(3)}")]

// Multiple constrângeri
[Route("posts/{year:int}/{month:int}/{day:int}")]
```

**Constrângeri comune:**
- `:int` - Număr întreg
- `:bool` - Boolean
- `:datetime` - Dată
- `:decimal` - Decimal
- `:min(value)` - Valoare minimă
- `:max(value)` - Valoare maximă
- `:range(min,max)` - Interval
- `:minlength(value)` - Lungime minimă
- `:maxlength(value)` - Lungime maximă

### 💻 Practică

#### Pipeline Middleware în Program.cs
```csharp
var builder = WebApplication.CreateBuilder(args);

// Adăugare servicii
builder.Services.AddControllersWithViews();

var app = builder.Build();

// Configurare pipeline-ul HTTP
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
    pattern: "{controller=Home}/{action=Index}/{id?}");

app.Run();
```

**Ordinea middleware-ului este IMPORTANTĂ!**

---

## <a name="curs-4"></a>🎮 Curs 4: Controller - Actions și Parametri

### 🎯 Concepte teoretice

#### Ce este Controller-ul?
- **Clasă** care moștenește `Controller`
- Conține **Actions** (metode publice)
- Procesează cereri HTTP
- Returnează **IActionResult**
- Nume: `NUMEController` (ex: `ArticlesController`, `HomeController`)

### 💻 Practică

#### Crearea unui Controller

**Pas 1 - Adăugare Controller:**
```csharp
using Microsoft.AspNetCore.Mvc;

namespace ProiectMVC.Controllers
{
    public class ArticlesController : Controller
    {
        public IActionResult Index()
        {
            return View();
        }
    }
}
```

**Pas 2 - Adăugare View:**
Creare folder: `Views/Articles/Index.cshtml`

#### Tipuri de ActionResult

```csharp
public class ArticlesController : Controller
{
    // 1. Returnează View
    public IActionResult Index()
    {
        return View();
    }
    
    // 2. Redirecționare către altă acțiune
    public IActionResult RedirectToIndex()
    {
        return RedirectToAction("Index");
    }
    
    // 3. Redirecționare către alt controller
    public IActionResult GoToHome()
    {
        return RedirectToAction("Index", "Home");
    }
    
    // 4. JSON (pentru API)
    public IActionResult GetData()
    {
        var data = new { Name = "Ion", Age = 25 };
        return Json(data);
    }
    
    // 5. Content (text simplu)
    public IActionResult GetText()
    {
        return Content("Hello World!");
    }
    
    // 6. NotFound (404)
    public IActionResult CheckArticle(int id)
    {
        if (id > 100)
            return NotFound();
        return View();
    }
    
    // 7. StatusCode
    public IActionResult CustomStatus()
    {
        return StatusCode(500); // Internal Server Error
    }
}
```

#### Parametrii unei acțiuni

**1. Parametri din URL (Route Parameters):**
```csharp
// URL: /Articles/Show/5
[Route("articles/{id}")]
public IActionResult Show(int id)
{
    // id = 5
    return View();
}
```

**2. Query Parameters (din URL după ?):**
```csharp
// URL: /Articles/Search?query=asp.net&page=2
public IActionResult Search(string query, int page = 1)
{
    // query = "asp.net"
    // page = 2
    return View();
}
```

**3. Form Data (din formulare POST):**
```csharp
[HttpPost]
public IActionResult Create(string title, string content)
{
    // Date primite din formular
    return RedirectToAction("Index");
}
```

**4. Model Binding (cu obiecte):**
```csharp
[HttpPost]
public IActionResult Create(Article article)
{
    // article.Title, article.Content, etc.
    return RedirectToAction("Index");
}
```

#### Action Selectors (Atribute importante)

**1. HTTP Verbs:**
```csharp
// Doar pentru cereri GET
[HttpGet]
public IActionResult Index()
{
    return View();
}

// Doar pentru cereri POST
[HttpPost]
public IActionResult Create(Article article)
{
    return RedirectToAction("Index");
}

// Doar pentru cereri PUT
[HttpPut]
public IActionResult Update(int id, Article article)
{
    return Ok();
}

// Doar pentru cereri DELETE
[HttpDelete]
public IActionResult Delete(int id)
{
    return Ok();
}
```

**2. ActionName (schimbare nume):**
```csharp
[ActionName("Display")]
public IActionResult Show(int id)
{
    // Se accesează prin /Articles/Display/5
    // Nu prin /Articles/Show/5
    return View();
}
```

**3. NonAction (exclude din routing):**
```csharp
[NonAction]
public string HelperMethod()
{
    // Această metodă NU poate fi accesată prin URL
    return "Helper";
}
```

#### Exemplu complet CRUD

```csharp
public class ArticlesController : Controller
{
    // Lista articole
    [HttpGet]
    public IActionResult Index()
    {
        return View();
    }
    
    // Afișare articol
    [HttpGet]
    public IActionResult Show(int id)
    {
        return View();
    }
    
    // Formular adăugare (GET)
    [HttpGet]
    public IActionResult New()
    {
        return View();
    }
    
    // Salvare articol (POST)
    [HttpPost]
    public IActionResult New(Article article)
    {
        if (ModelState.IsValid)
        {
            // Salvare în BD
            return RedirectToAction("Index");
        }
        return View(article);
    }
    
    // Formular editare (GET)
    [HttpGet]
    public IActionResult Edit(int id)
    {
        return View();
    }
    
    // Salvare editare (POST)
    [HttpPost]
    public IActionResult Edit(int id, Article article)
    {
        if (ModelState.IsValid)
        {
            // Update în BD
            return RedirectToAction("Index");
        }
        return View(article);
    }
    
    // Ștergere articol (POST)
    [HttpPost]
    public IActionResult Delete(int id)
    {
        // Ștergere din BD
        return RedirectToAction("Index");
    }
}
```

---

## <a name="curs-5"></a>💾 Curs 5: Model și Entity Framework Core

### 🎯 Concepte teoretice

#### Entity Framework Core (EF Core)
- **ORM (Object-Relational Mapper)** pentru .NET
- Mapează clase C# → Tabele în BD
- **Code-First**: Scrii clase → EF generează BD
- **Database-First**: BD există → EF generează clase
- Suportă: SQL Server, MySQL, PostgreSQL, SQLite, etc.

#### Ce sunt migrațiile?
- **Sistem de versionare** pentru schema bazei de date
- Detectează modificări în modele
- Generează cod pentru actualizare BD
- Permite **rollback** la versiuni anterioare

#### LINQ (Language Integrated Query)
- Interogări în C# (nu SQL direct)
- **Type-safe**: Erori detectate la compilare
- Sintaxă expresivă și naturală

### 💻 Practică

#### Instalare Entity Framework Core

**Pas 1 - Instalare pachete NuGet:**
```bash
# Tools pentru comenzi (migrations, etc.)
Install-Package Microsoft.EntityFrameworkCore.Tools

# Provider pentru SQL Server
Install-Package Microsoft.EntityFrameworkCore.SqlServer

# Design (pentru scaffolding)
Install-Package Microsoft.EntityFrameworkCore.Design
```

**SAU prin .NET CLI:**
```bash
dotnet add package Microsoft.EntityFrameworkCore.Tools
dotnet add package Microsoft.EntityFrameworkCore.SqlServer
dotnet add package Microsoft.EntityFrameworkCore.Design
```

#### Crearea unui Model

```csharp
using System.ComponentModel.DataAnnotations;

namespace ProiectMVC.Models
{
    public class Student
    {
        [Key]  // Cheie primară
        public int Id { get; set; }
        
        [Required]  // Câmp obligatoriu
        [MaxLength(100)]
        public string Name { get; set; }
        
        [Required]
        [EmailAddress]
        public string Email { get; set; }
        
        public string? CNP { get; set; }  // Nullable
        
        public DateTime? BirthDate { get; set; }
    }
}
```

#### Crearea DbContext

**Variantă cu Dependency Injection (RECOMANDATĂ):**

```csharp
using Microsoft.EntityFrameworkCore;
using ProiectMVC.Models;

namespace ProiectMVC.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
            : base(options)
        {
        }
        
        // DbSet pentru fiecare tabel
        public DbSet<Student> Students { get; set; }
        public DbSet<Article> Articles { get; set; }
        public DbSet<Category> Categories { get; set; }
    }
}
```

#### Configurare Connection String

**appsettings.json:**
```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=(localdb)\\mssqllocaldb;Database=NumeBazaDate;Trusted_Connection=True;MultipleActiveResultSets=true"
  },
  "Logging": {
    "LogLevel": {
      "Default": "Information"
    }
  }
}
```

#### Configurare în Program.cs

```csharp
using Microsoft.EntityFrameworkCore;
using ProiectMVC.Data;

var builder = WebApplication.CreateBuilder(args);

// Adăugare DbContext cu connection string
var connectionString = builder.Configuration.GetConnectionString("DefaultConnection");
builder.Services.AddDbContext<ApplicationDbContext>(options =>
    options.UseSqlServer(connectionString));

builder.Services.AddControllersWithViews();

var app = builder.Build();

// ... restul configurării
```

#### Utilizare DbContext în Controller

```csharp
public class StudentsController : Controller
{
    private readonly ApplicationDbContext db;
    
    // Dependency Injection
    public StudentsController(ApplicationDbContext context)
    {
        db = context;
    }
    
    public IActionResult Index()
    {
        var students = db.Students.ToList();
        return View(students);
    }
}
```

#### Migrații - Comenzi esențiale

**1. Creare migrație:**
```bash
# Package Manager Console (Windows)
Add-Migration InitialCreate

# .NET CLI (cross-platform)
dotnet ef migrations add InitialCreate
```

**2. Aplicare migrație (creează/actualizează BD):**
```bash
# Package Manager Console
Update-Database

# .NET CLI
dotnet ef database update
```

**3. Eliminare ultimei migrații:**
```bash
# Package Manager Console
Remove-Migration

# .NET CLI
dotnet ef migrations remove
```

**4. Listare migrații:**
```bash
# .NET CLI
dotnet ef migrations list
```

**5. Revenire la o migrație anterioară:**
```bash
# Package Manager Console
Update-Database NumeMigratie

# .NET CLI
dotnet ef database update NumeMigratie
```

#### Operații CRUD cu EF Core

```csharp
public class StudentsController : Controller
{
    private readonly ApplicationDbContext db;
    
    public StudentsController(ApplicationDbContext context)
    {
        db = context;
    }
    
    // CREATE (INSERT)
    [HttpPost]
    public IActionResult Create(Student student)
    {
        if (ModelState.IsValid)
        {
            db.Students.Add(student);
            db.SaveChanges();  // Salvează în BD
            return RedirectToAction("Index");
        }
        return View(student);
    }
    
    // READ (SELECT)
    public IActionResult Index()
    {
        var students = db.Students.ToList();
        return View(students);
    }
    
    public IActionResult Show(int id)
    {
        var student = db.Students.Find(id);
        if (student == null)
            return NotFound();
        return View(student);
    }
    
    // UPDATE
    [HttpPost]
    public IActionResult Edit(int id, Student student)
    {
        if (ModelState.IsValid)
        {
            var existingStudent = db.Students.Find(id);
            if (existingStudent != null)
            {
                existingStudent.Name = student.Name;
                existingStudent.Email = student.Email;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
        }
        return View(student);
    }
    
    // DELETE
    [HttpPost]
    public IActionResult Delete(int id)
    {
        var student = db.Students.Find(id);
        if (student != null)
        {
            db.Students.Remove(student);
            db.SaveChanges();
        }
        return RedirectToAction("Index");
    }
}
```

---

## <a name="curs-6"></a>🗄️ Curs 6: Baze de Date și LINQ

### 🎯 Concepte teoretice - Baze de Date

#### Terminologie esențială

| Termen | Definiție |
|--------|-----------|
| **Entitate** | Obiect din lumea reală (Student, Article, Category) |
| **Atribut** | Caracteristică a unei entități (Name, Email, Age) |
| **Cheie primară** | Identificator unic pentru fiecare înregistrare (Id) |
| **Cheie externă** | Referință către cheia primară din alt tabel |
| **Relație** | Legătură între două entități |

#### Tipuri de relații

**1. One-to-One (1:1)**
```
User ──────── Profile
1 utilizator are 1 profil
1 profil aparține 1 utilizator
```

**2. One-to-Many (1:N)**
```
Category ──────< Articles
1 categorie are MULTE articole
1 articol aparține 1 categorie
```

**3. Many-to-Many (M:N)**
```
Students >──────< Courses
MULȚI studenți la MULTE cursuri
Necesită tabel asociativ!
```

### 💻 Practică - Implementare relații

#### Relația One-to-Many

**Exemplu: Category → Articles**

```csharp
// Model Category
public class Category
{
    [Key]
    public int Id { get; set; }
    
    [Required]
    public string CategoryName { get; set; }
    
    // Navigație: O categorie are multe articole
    public virtual ICollection<Article>? Articles { get; set; }
}

// Model Article
public class Article
{
    [Key]
    public int Id { get; set; }
    
    [Required]
    public string Title { get; set; }
    
    public string Content { get; set; }
    
    // Cheie externă
    public int CategoryId { get; set; }
    
    // Navigație: Un articol aparține unei categorii
    public virtual Category? Category { get; set; }
}
```

#### Relația Many-to-Many - Varianta 1 (Manuală)

**Cu tabel asociativ explicit:**

```csharp
// Model Article
public class Article
{
    [Key]
    public int Id { get; set; }
    public string Title { get; set; }
    
    // Colecție către tabelul asociativ
    public virtual ICollection<ArticleCategory>? ArticleCategories { get; set; }
}

// Model Category
public class Category
{
    [Key]
    public int Id { get; set; }
    public string CategoryName { get; set; }
    
    // Colecție către tabelul asociativ
    public virtual ICollection<ArticleCategory>? ArticleCategories { get; set; }
}

// Tabel asociativ (junction table)
public class ArticleCategory
{
    public int ArticleId { get; set; }
    public Article? Article { get; set; }
    
    public int CategoryId { get; set; }
    public Category? Category { get; set; }
}
```

**Configurare în DbContext:**
```csharp
public class ApplicationDbContext : DbContext
{
    public DbSet<Article> Articles { get; set; }
    public DbSet<Category> Categories { get; set; }
    public DbSet<ArticleCategory> ArticleCategories { get; set; }
    
    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        base.OnModelCreating(modelBuilder);
        
        // Cheie primară compusă
        modelBuilder.Entity<ArticleCategory>()
            .HasKey(ac => new { ac.ArticleId, ac.CategoryId });
        
        // Relații
        modelBuilder.Entity<ArticleCategory>()
            .HasOne(ac => ac.Article)
            .WithMany(a => a.ArticleCategories)
            .HasForeignKey(ac => ac.ArticleId);
        
        modelBuilder.Entity<ArticleCategory>()
            .HasOne(ac => ac.Category)
            .WithMany(c => c.ArticleCategories)
            .HasForeignKey(ac => ac.CategoryId);
    }
}
```

#### Relația Many-to-Many - Varianta 2 (Automată)

**EF Core generează tabelul asociativ automat:**

```csharp
public class Article
{
    public int Id { get; set; }
    public string Title { get; set; }
    
    // Colecție directă (fără tabel asociativ explicit)
    public virtual ICollection<Category>? Categories { get; set; }
}

public class Category
{
    public int Id { get; set; }
    public string CategoryName { get; set; }
    
    // Colecție directă
    public virtual ICollection<Article>? Articles { get; set; }
}
```

### 🔍 LINQ - Interogări

#### Sintaxă LINQ

**Două variante:**
1. **Query Syntax** (SQL-like)
2. **Method Syntax** (cu lambda expressions)

#### Exemple LINQ Practice

**1. SELECT simple:**
```csharp
// Toți studenții
var students = db.Students.ToList();

// Cu condiție (WHERE)
var adults = db.Students.Where(s => s.Age >= 18).ToList();

// Un singur element
var student = db.Students.Find(id);  // Caută după PK
var student = db.Students.FirstOrDefault(s => s.Id == id);
```

**2. ORDER BY (sortare):**
```csharp
// Crescător
var studentsAsc = db.Students.OrderBy(s => s.Name).ToList();

// Descrescător
var studentsDesc = db.Students.OrderByDescending(s => s.Age).ToList();

// Multiple criterii
var sorted = db.Students
    .OrderBy(s => s.Age)
    .ThenBy(s => s.Name)
    .ToList();
```

**3. JOIN (Include):**
```csharp
// Articole cu categoria lor
var articles = db.Articles.Include("Category").ToList();

// SAU cu lambda
var articles = db.Articles.Include(a => a.Category).ToList();

// Multiple Include
var articles = db.Articles
    .Include(a => a.Category)
    .Include(a => a.Comments)
    .ToList();
```

**Codul SQL generat:**
```sql
SELECT [a].[Id], [a].[Title], [c].[Id], [c].[CategoryName]
FROM [Articles] AS [a]
INNER JOIN [Categories] AS [c] ON [a].[CategoryId] = [c].[Id]
```

**4. SELECT custom (proiecție):**
```csharp
var articleTitles = db.Articles
    .Select(a => new {
        Id = a.Id,
        Title = a.Title,
        CategoryName = a.Category.CategoryName
    })
    .ToList();
```

**5. GROUP BY și COUNT:**
```csharp
// Număr articole per categorie
var counts = from category in db.Categories
             join article in db.Articles on category.Id equals article.CategoryId
             group category by category.Id into groupedCategories
             select new
             {
                 CategoryId = groupedCategories.Key,
                 ArticlesCount = groupedCategories.Count()
             };
```

**6. Lazy Loading vs Eager Loading:**

```csharp
// Lazy Loading (încărcare întârziată)
// Include() nu e folosit - datele se încarcă când sunt accesate
var article = db.Articles.Find(id);
var categoryName = article.Category.CategoryName;  // Query BD aici!

// Eager Loading (încărcare imediată) - RECOMANDAT
var article = db.Articles.Include(a => a.Category).Find(id);
var categoryName = article.Category.CategoryName;  // Deja încărcat!
```

#### Exemple LINQ complexe

**Căutare și filtrare:**
```csharp
public IActionResult Search(string query)
{
    var results = db.Articles
        .Include(a => a.Category)
        .Where(a => a.Title.Contains(query) || a.Content.Contains(query))
        .OrderByDescending(a => a.Date)
        .ToList();
    
    return View(results);
}
```

**Paginare:**
```csharp
public IActionResult Index(int page = 1, int pageSize = 10)
{
    var articles = db.Articles
        .Include(a => a.Category)
        .OrderByDescending(a => a.Date)
        .Skip((page - 1) * pageSize)
        .Take(pageSize)
        .ToList();
    
    return View(articles);
}
```

### 🔐 Identity Framework (Autentificare)

#### Configurare Identity

**Pas 1 - Instalare pachet:**
```bash
Install-Package Microsoft.AspNetCore.Identity.EntityFrameworkCore
```

**Pas 2 - Actualizare DbContext:**
```csharp
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;

public class ApplicationDbContext : IdentityDbContext<ApplicationUser>
{
    public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options)
        : base(options)
    {
    }
    
    public DbSet<Article> Articles { get; set; }
    // ... alte DbSet-uri
}
```

**Pas 3 - Model utilizator:**
```csharp
using Microsoft.AspNetCore.Identity;

public class ApplicationUser : IdentityUser
{
    // Proprietăți adiționale
    public string? FirstName { get; set; }
    public string? LastName { get; set; }
}
```

**Pas 4 - Configurare în Program.cs:**
```csharp
// Adăugare Identity
builder.Services.AddIdentity<ApplicationUser, IdentityRole>()
    .AddEntityFrameworkStores<ApplicationDbContext>()
    .AddDefaultTokenProviders();

// Configurare opțiuni parolă
builder.Services.Configure<IdentityOptions>(options =>
{
    options.Password.RequireDigit = true;
    options.Password.RequireLowercase = true;
    options.Password.RequireUppercase = true;
    options.Password.RequireNonAlphanumeric = false;
    options.Password.RequiredLength = 6;
});

// ... în pipeline
app.UseAuthentication();  // ÎNAINTE de UseAuthorization!
app.UseAuthorization();
```

**Pas 5 - Migrare:**
```bash
Add-Migration AddIdentity
Update-Database
```

#### Roluri (Roles)

**Creare roluri:**
```csharp
public class SeedData
{
    public static async Task Initialize(IServiceProvider serviceProvider)
    {
        var roleManager = serviceProvider.GetRequiredService<RoleManager<IdentityRole>>();
        var userManager = serviceProvider.GetRequiredService<UserManager<ApplicationUser>>();
        
        // Creare roluri
        string[] roles = { "Admin", "Editor", "User" };
        foreach (var role in roles)
        {
            if (!await roleManager.RoleExistsAsync(role))
            {
                await roleManager.CreateAsync(new IdentityRole(role));
            }
        }
        
        // Creare admin
        var adminEmail = "admin@example.com";
        var adminUser = await userManager.FindByEmailAsync(adminEmail);
        if (adminUser == null)
        {
            adminUser = new ApplicationUser
            {
                UserName = adminEmail,
                Email = adminEmail,
                EmailConfirmed = true
            };
            await userManager.CreateAsync(adminUser, "Admin123!");
            await userManager.AddToRoleAsync(adminUser, "Admin");
        }
    }
}
```

**Apelare în Program.cs:**
```csharp
// După app.Build()
using (var scope = app.Services.CreateScope())
{
    var services = scope.ServiceProvider;
    await SeedData.Initialize(services);
}
```

#### Autorizare în Controller

```csharp
using Microsoft.AspNetCore.Authorization;

// Doar utilizatori autentificați
[Authorize]
public class ArticlesController : Controller
{
    public IActionResult Index()
    {
        return View();
    }
}

// Doar pentru roluri specifice
[Authorize(Roles = "Admin")]
public IActionResult AdminPanel()
{
    return View();
}

// Multiple roluri (oricare)
[Authorize(Roles = "Admin,Editor")]
public IActionResult Edit(int id)
{
    return View();
}

// Permite acces anonim (override)
[AllowAnonymous]
public IActionResult PublicPage()
{
    return View();
}
```

---

## <a name="curs-7"></a>🎨 Curs 7: View și Razor - Trimiterea Datelor

### 🎯 Concepte teoretice

#### Ce este View-ul?
- Fișiere `.cshtml` (C# + HTML)
- Conțin **Razor syntax** pentru cod dinamic
- Locație: `Views/[Controller]/[Action].cshtml`
- **NU conține logică business** (doar prezentare)

#### Razor Syntax
- **`@`** - Începe expresie C#
- **`@{ }`** - Bloc de cod C#
- **`@model`** - Declară tipul modelului
- **`@Model`** - Accesează modelul

### 💻 Practică - Trimitere date către View

#### 1. MODEL (Cel mai recomandat)

**Controller:**
```csharp
public IActionResult Show(int id)
{
    var student = db.Students.Find(id);
    return View(student);  // Trimite obiectul
}
```

**View (Show.cshtml):**
```html
@model ProiectMVC.Models.Student

<h1>@Model.Name</h1>
<p>Email: @Model.Email</p>
<p>CNP: @Model.CNP</p>
```

**Pentru liste:**
```html
@model List<ProiectMVC.Models.Student>

@foreach (var student in Model)
{
    <div>
        <h3>@student.Name</h3>
        <p>@student.Email</p>
    </div>
}
```

#### 2. ViewBag (Obiect dinamic)

**Controller:**
```csharp
public IActionResult Index()
{
    ViewBag.Title = "Lista studenților";
    ViewBag.Count = 10;
    ViewBag.Students = db.Students.ToList();
    return View();
}
```

**View:**
```html
<h1>@ViewBag.Title</h1>
<p>Număr studenți: @ViewBag.Count</p>

@foreach (var student in ViewBag.Students)
{
    <p>@student.Name</p>
}
```

#### 3. ViewData (Dicționar)

**Controller:**
```csharp
public IActionResult Index()
{
    ViewData["Title"] = "Lista studenților";
    ViewData["Count"] = 10;
    return View();
}
```

**View:**
```html
<h1>@ViewData["Title"]</h1>
<p>Număr: @ViewData["Count"]</p>
```

#### 4. TempData (Persistă între redirect-uri)

**Controller:**
```csharp
[HttpPost]
public IActionResult Create(Student student)
{
    db.Students.Add(student);
    db.SaveChanges();
    
    TempData["Message"] = "Student adăugat cu succes!";
    TempData["MessageType"] = "success";
    
    return RedirectToAction("Index");
}

public IActionResult Index()
{
    // TempData este disponibil și aici după redirect
    return View();
}
```

**View:**
```html
@if (TempData["Message"] != null)
{
    <div class="alert alert-@TempData["MessageType"]">
        @TempData["Message"]
    </div>
}
```

### 🛠️ Helpere pentru View (Tag Helpers)

#### Formulare (Form Tag Helpers)

```html
<!-- Formular de creare -->
<form asp-controller="Articles" asp-action="Create" method="post">
    
    <!-- Input pentru text -->
    <div class="form-group">
        <label asp-for="Title"></label>
        <input asp-for="Title" class="form-control" />
        <span asp-validation-for="Title" class="text-danger"></span>
    </div>
    
    <!-- Textarea -->
    <div class="form-group">
        <label asp-for="Content"></label>
        <textarea asp-for="Content" class="form-control"></textarea>
        <span asp-validation-for="Content" class="text-danger"></span>
    </div>
    
    <!-- Dropdown (select) -->
    <div class="form-group">
        <label asp-for="CategoryId"></label>
        <select asp-for="CategoryId" asp-items="Model.Categories" class="form-control">
            <option value="">Selectați categoria</option>
        </select>
        <span asp-validation-for="CategoryId" class="text-danger"></span>
    </div>
    
    <!-- Checkbox -->
    <div class="form-check">
        <input asp-for="IsPublished" class="form-check-input" type="checkbox" />
        <label asp-for="IsPublished" class="form-check-label"></label>
    </div>
    
    <!-- Submit button -->
    <button type="submit" class="btn btn-primary">Salvează</button>
</form>
```

#### Link-uri (Anchor Tag Helper)

```html
<!-- Link către Index -->
<a asp-controller="Articles" asp-action="Index">Lista articole</a>

<!-- Link cu parametru -->
<a asp-controller="Articles" asp-action="Show" asp-route-id="@article.Id">
    Detalii
</a>

<!-- Link către Home/Privacy -->
<a asp-controller="Home" asp-action="Privacy">Privacy Policy</a>

<!-- Link cu mai mulți parametri -->
<a asp-controller="Search" 
   asp-action="Results" 
   asp-route-query="@searchTerm" 
   asp-route-page="1">
    Căutare
</a>
```

#### Imagini și fișiere statice

```html
<!-- Imagini din wwwroot -->
<img src="~/images/logo.png" alt="Logo" />

<!-- CSS -->
<link rel="stylesheet" href="~/css/site.css" />

<!-- JavaScript -->
<script src="~/js/site.js"></script>

<!-- Bootstrap (din wwwroot/lib) -->
<link rel="stylesheet" href="~/lib/bootstrap/dist/css/bootstrap.min.css" />
```

#### DisplayFor și EditorFor

```html
@model Student

<!-- DisplayFor (doar afișare) -->
<dl>
    <dt>@Html.DisplayNameFor(m => m.Name)</dt>
    <dd>@Html.DisplayFor(m => m.Name)</dd>
    
    <dt>@Html.DisplayNameFor(m => m.Email)</dt>
    <dd>@Html.DisplayFor(m => m.Email)</dd>
</dl>

<!-- EditorFor (pentru formulare) -->
<div class="form-group">
    @Html.LabelFor(m => m.Name)
    @Html.EditorFor(m => m.Name, new { htmlAttributes = new { @class = "form-control" } })
    @Html.ValidationMessageFor(m => m.Name, "", new { @class = "text-danger" })
</div>
```

### 📝 Exemple practice Razor

#### Condiții în Razor

```html
@model Article

@if (Model.IsPublished)
{
    <span class="badge badge-success">Publicat</span>
}
else
{
    <span class="badge badge-warning">Draft</span>
}

@* Operatorul ternar *@
<p class="@(Model.IsPublished ? "text-success" : "text-muted")">
    Status: @(Model.IsPublished ? "Activ" : "Inactiv")
</p>

@* Switch *@
@switch (Model.Status)
{
    case "Published":
        <span class="badge badge-success">Publicat</span>
        break;
    case "Draft":
        <span class="badge badge-secondary">Draft</span>
        break;
    default:
        <span class="badge badge-warning">Necunoscut</span>
        break;
}
```

#### Bucle în Razor

```html
@model List<Student>

<table class="table">
    <thead>
        <tr>
            <th>Nume</th>
            <th>Email</th>
            <th>Acțiuni</th>
        </tr>
    </thead>
    <tbody>
        @foreach (var student in Model)
        {
            <tr>
                <td>@student.Name</td>
                <td>@student.Email</td>
                <td>
                    <a asp-action="Edit" asp-route-id="@student.Id">Edit</a>
                    <a asp-action="Delete" asp-route-id="@student.Id">Delete</a>
                </td>
            </tr>
        }
    </tbody>
</table>

@* For cu index *@
@for (int i = 0; i < Model.Count; i++)
{
    <div>
        <strong>#@(i + 1)</strong> - @Model[i].Name
    </div>
}
```

#### Formatare date

```html
@model Article

<!-- Data în format românesc -->
<p>Data: @Model.Date.ToString("dd.MM.yyyy")</p>

<!-- Data și ora -->
<p>Publicat: @Model.Date.ToString("dd MMMM yyyy HH:mm")</p>

<!-- Relative time -->
<p>Acum @((DateTime.Now - Model.Date).Days) zile</p>

<!-- Formatare numere -->
<p>Preț: @Model.Price.ToString("C2")</p> <!-- Currency -->
<p>Procent: @Model.Discount.ToString("P")</p> <!-- Percentage -->
```

---

## <a name="curs-8"></a>✅ Curs 8: Validări și Layout-uri

### 🎯 Concepte teoretice - Validări

#### Data Annotations (Atribute de validare)

Validările se aplică la nivel de **Model** și sunt verificate automat în Controller prin `ModelState.IsValid`.

### 💻 Practică - Validări

#### Atribute de validare în Model

```csharp
using System.ComponentModel.DataAnnotations;

public class Article
{
    [Key]
    public int Id { get; set; }
    
    // Required - câmp obligatoriu
    [Required(ErrorMessage = "Titlul este obligatoriu")]
    [StringLength(200, MinimumLength = 5, 
        ErrorMessage = "Titlul trebuie să aibă între 5 și 200 caractere")]
    [Display(Name = "Titlu articol")]
    public string Title { get; set; }
    
    // Content
    [Required(ErrorMessage = "Conținutul este obligatoriu")]
    [MinLength(10, ErrorMessage = "Conținutul trebuie să aibă minim 10 caractere")]
    public string Content { get; set; }
    
    // Email validation
    [Required]
    [EmailAddress(ErrorMessage = "Email invalid")]
    public string AuthorEmail { get; set; }
    
    // Range validation
    [Range(1, 5, ErrorMessage = "Rating-ul trebuie să fie între 1 și 5")]
    public int Rating { get; set; }
    
    // URL validation
    [Url(ErrorMessage = "URL invalid")]
    public string? WebsiteUrl { get; set; }
    
    // Regular Expression
    [RegularExpression(@"^[0-9]{13}$", ErrorMessage = "CNP invalid (13 cifre)")]
    public string? CNP { get; set; }
    
    // Phone number
    [Phone(ErrorMessage = "Număr de telefon invalid")]
    public string? PhoneNumber { get; set; }
    
    // Credit card
    [CreditCard(ErrorMessage = "Număr card invalid")]
    public string? CardNumber { get; set; }
    
    // Compare (pentru confirmare parolă)
    [Required]
    [DataType(DataType.Password)]
    public string Password { get; set; }
    
    [Compare("Password", ErrorMessage = "Parolele nu coincid")]
    [DataType(DataType.Password)]
    [Display(Name = "Confirmă parola")]
    public string ConfirmPassword { get; set; }
}
```

#### Diferența între StringLength și MaxLength

```csharp
// StringLength - pentru validare în aplicație
[StringLength(100, MinimumLength = 3)]
public string Title { get; set; }

// MaxLength - pentru migrare în bază de date
[MaxLength(100)]
public string Title { get; set; }

// Best practice: folosește ambele
[Required]
[StringLength(100, MinimumLength = 3)]
[MaxLength(100)]
public string Title { get; set; }
```

#### Validare în Controller

```csharp
[HttpPost]
public IActionResult Create(Article article)
{
    // Validare automată
    if (ModelState.IsValid)
    {
        article.Date = DateTime.Now;
        db.Articles.Add(article);
        db.SaveChanges();
        
        TempData["message"] = "Articol adăugat cu succes!";
        TempData["messageType"] = "success";
        return RedirectToAction("Index");
    }
    
    // Dacă validarea eșuează, re-afișează formularul cu erori
    return View(article);
}
```

#### Validare manuală în Controller

```csharp
[HttpPost]
public IActionResult Create(Article article)
{
    // Validări custom
    if (string.IsNullOrWhiteSpace(article.Title))
    {
        ModelState.AddModelError("Title", "Titlul nu poate fi gol");
    }
    
    if (db.Articles.Any(a => a.Title == article.Title))
    {
        ModelState.AddModelError("Title", "Există deja un articol cu acest titlu");
    }
    
    // Validare generală (nu pentru un câmp specific)
    if (article.Date > DateTime.Now)
    {
        ModelState.AddModelError(string.Empty, "Data nu poate fi în viitor");
    }
    
    if (ModelState.IsValid)
    {
        db.Articles.Add(article);
        db.SaveChanges();
        return RedirectToAction("Index");
    }
    
    return View(article);
}
```

### 🎨 Validare în View

#### asp-validation-for (pentru fiecare câmp)

```html
@model Article

<form asp-action="Create" method="post">
    
    <div class="form-group">
        <label asp-for="Title"></label>
        <input asp-for="Title" class="form-control" />
        <!-- Mesaj de eroare pentru Title -->
        <span asp-validation-for="Title" class="text-danger"></span>
    </div>
    
    <div class="form-group">
        <label asp-for="Content"></label>
        <textarea asp-for="Content" class="form-control"></textarea>
        <!-- Mesaj de eroare pentru Content -->
        <span asp-validation-for="Content" class="text-danger"></span>
    </div>
    
    <button type="submit" class="btn btn-primary">Salvează</button>
</form>
```

#### asp-validation-summary (toate erorile)

```html
@model Article

<form asp-action="Create" method="post">
    
    <!-- Afișează TOATE erorile de validare -->
    <div asp-validation-summary="All" class="text-danger"></div>
    
    <!-- SAU doar erorile de model (nu pentru câmpuri individuale) -->
    <div asp-validation-summary="ModelOnly" class="text-danger"></div>
    
    <!-- Formularul aici -->
    
</form>
```

**Diferența:**
- `All`: Toate erorile (inclusiv cele pentru câmpuri individuale)
- `ModelOnly`: Doar erorile generale (fără cele pentru câmpuri)
- Recommended: `ModelOnly` + `asp-validation-for` pentru fiecare câmp

#### Librării JavaScript pentru validare client-side

```html
@* La finalul paginii sau în _Layout.cshtml *@
@section Scripts {
    <partial name="_ValidationScriptsPartial" />
}
```

**_ValidationScriptsPartial.cshtml:**
```html
<script src="~/lib/jquery-validation/dist/jquery.validate.min.js"></script>
<script src="~/lib/jquery-validation-unobtrusive/jquery.validate.unobtrusive.min.js"></script>
```

### 🎨 Layout-uri și View-uri partajate

#### Layout View (_Layout.cshtml)

**Locație:** `Views/Shared/_Layout.cshtml`

```html
<!DOCTYPE html>
<html lang="ro">
<head>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>@ViewData["Title"] - Nume Aplicație</title>
    
    <!-- CSS -->
    <link rel="stylesheet" href="~/lib/bootstrap/dist/css/bootstrap.min.css" />
    <link rel="stylesheet" href="~/css/site.css" />
</head>
<body>
    <header>
        <nav class="navbar navbar-expand-sm navbar-light bg-white border-bottom">
            <div class="container">
                <a class="navbar-brand" asp-controller="Home" asp-action="Index">
                    Logo
                </a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" 
                        data-bs-target="#navbarNav">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarNav">
                    <ul class="navbar-nav ms-auto">
                        <li class="nav-item">
                            <a class="nav-link" asp-controller="Home" asp-action="Index">
                                Acasă
                            </a>
                        </li>
                        <li class="nav-item">
                            <a class="nav-link" asp-controller="Articles" asp-action="Index">
                                Articole
                            </a>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
    </header>
    
    <div class="container">
        <main role="main" class="pb-3">
            @RenderBody() <!-- Conținutul paginii curente -->
        </main>
    </div>
    
    <footer class="border-top footer text-muted">
        <div class="container">
            &copy; 2024 - Nume Aplicație
        </div>
    </footer>
    
    <!-- Scripts -->
    <script src="~/lib/jquery/dist/jquery.min.js"></script>
    <script src="~/lib/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
    <script src="~/js/site.js"></script>
    
    @await RenderSectionAsync("Scripts", required: false)
</body>
</html>
```

#### Utilizare Layout în View

**_ViewStart.cshtml** (în Views/):
```csharp
@{
    Layout = "_Layout";
}
```

**SAU direct în fiecare View:**
```csharp
@{
    ViewData["Title"] = "Lista articole";
    Layout = "_Layout";
}

<h1>@ViewData["Title"]</h1>
<!-- Conținutul paginii -->
```

#### Partial View (_LoginPartial.cshtml)

**Locație:** `Views/Shared/_LoginPartial.cshtml`

```html
@using Microsoft.AspNetCore.Identity
@inject SignInManager<ApplicationUser> SignInManager
@inject UserManager<ApplicationUser> UserManager

<ul class="navbar-nav">
    @if (SignInManager.IsSignedIn(User))
    {
        <li class="nav-item">
            <a class="nav-link" asp-controller="Users" asp-action="Profile">
                Salut, @User.Identity.Name!
            </a>
        </li>
        <li class="nav-item">
            <form asp-controller="Account" asp-action="Logout" method="post">
                <button type="submit" class="nav-link btn btn-link">Logout</button>
            </form>
        </li>
    }
    else
    {
        <li class="nav-item">
            <a class="nav-link" asp-controller="Account" asp-action="Register">
                Register
            </a>
        </li>
        <li class="nav-item">
            <a class="nav-link" asp-controller="Account" asp-action="Login">
                Login
            </a>
        </li>
    }
</ul>
```

**Includere în _Layout.cshtml:**
```html
<nav class="navbar">
    <!-- ... -->
    <partial name="_LoginPartial" />
</nav>
```

#### Sections (Secțiuni)

**În _Layout.cshtml:**
```html
<head>
    <!-- CSS global -->
    <link rel="stylesheet" href="~/css/site.css" />
    
    <!-- Secțiune pentru CSS specific -->
    @await RenderSectionAsync("Styles", required: false)
</head>
<body>
    @RenderBody()
    
    <!-- Scripts globale -->
    <script src="~/js/site.js"></script>
    
    <!-- Secțiune pentru Scripts specifice -->
    @await RenderSectionAsync("Scripts", required: false)
</body>
```

**În View (de ex. Articles/Index.cshtml):**
```html
@{
    ViewData["Title"] = "Articole";
}

<!-- Conținut pagină -->
<h1>Lista articole</h1>

@section Styles {
    <link rel="stylesheet" href="~/css/articles.css" />
}

@section Scripts {
    <script src="~/js/articles.js"></script>
    <script>
        // Cod JavaScript specific acestei pagini
        $(document).ready(function() {
            console.log("Pagina articole încărcată");
        });
    </script>
}
```

#### Validări Custom

**1. Atribut de validare custom:**
```csharp
public class MinimumAgeAttribute : ValidationAttribute
{
    private readonly int _minimumAge;
    
    public MinimumAgeAttribute(int minimumAge)
    {
        _minimumAge = minimumAge;
    }
    
    protected override ValidationResult IsValid(object value, ValidationContext validationContext)
    {
        if (value is DateTime birthDate)
        {
            var age = DateTime.Today.Year - birthDate.Year;
            if (birthDate.Date > DateTime.Today.AddYears(-age))
                age--;
            
            if (age >= _minimumAge)
            {
                return ValidationResult.Success;
            }
            
            return new ValidationResult($"Vârsta minimă este {_minimumAge} ani");
        }
        
        return new ValidationResult("Dată invalidă");
    }
}

// Utilizare
public class Student
{
    [Required]
    [MinimumAge(18, ErrorMessage = "Trebuie să ai minim 18 ani")]
    public DateTime BirthDate { get; set; }
}
```

**2. IValidatableObject (validare la nivel de model):**
```csharp
public class Article : IValidatableObject
{
    public string Title { get; set; }
    public DateTime PublishDate { get; set; }
    public DateTime? ExpiryDate { get; set; }
    
    public IEnumerable<ValidationResult> Validate(ValidationContext validationContext)
    {
        if (PublishDate < DateTime.Today)
        {
            yield return new ValidationResult(
                "Data de publicare nu poate fi în trecut",
                new[] { nameof(PublishDate) }
            );
        }
        
        if (ExpiryDate.HasValue && ExpiryDate < PublishDate)
        {
            yield return new ValidationResult(
                "Data de expirare trebuie să fie după data de publicare",
                new[] { nameof(ExpiryDate) }
            );
        }
    }
}
```

---

## <a name="curs-10"></a>📄 Curs 10: Paginare, Editor Text, Căutare

### 💻 Implementare Paginare

#### 1. ViewModel pentru paginare

```csharp
public class PaginatedList<T>
{
    public List<T> Items { get; set; }
    public int PageIndex { get; set; }
    public int TotalPages { get; set; }
    public int TotalItems { get; set; }
    
    public bool HasPreviousPage => PageIndex > 1;
    public bool HasNextPage => PageIndex < TotalPages;
    
    public PaginatedList(List<T> items, int count, int pageIndex, int pageSize)
    {
        PageIndex = pageIndex;
        TotalPages = (int)Math.Ceiling(count / (double)pageSize);
        TotalItems = count;
        Items = items;
    }
}
```

#### 2. Controller cu paginare

```csharp
public class ArticlesController : Controller
{
    private readonly ApplicationDbContext db;
    private const int PageSize = 10;
    
    public ArticlesController(ApplicationDbContext context)
    {
        db = context;
    }
    
    public IActionResult Index(int page = 1)
    {
        var totalItems = db.Articles.Count();
        
        var articles = db.Articles
            .Include(a => a.Category)
            .Include(a => a.User)
            .OrderByDescending(a => a.Date)
            .Skip((page - 1) * PageSize)
            .Take(PageSize)
            .ToList();
        
        var paginatedList = new PaginatedList<Article>(
            articles, 
            totalItems, 
            page, 
            PageSize
        );
        
        return View(paginatedList);
    }
}
```

#### 3. View cu paginare

```html
@model PaginatedList<Article>

<h1>Articole (Pagina @Model.PageIndex din @Model.TotalPages)</h1>

<!-- Lista articole -->
@foreach (var article in Model.Items)
{
    <div class="card mb-3">
        <div class="card-body">
            <h5 class="card-title">@article.Title</h5>
            <p class="card-text">@article.Content.Substring(0, 100)...</p>
            <a asp-action="Show" asp-route-id="@article.Id" class="btn btn-primary">
                Citește mai mult
            </a>
        </div>
    </div>
}

<!-- Paginare -->
<nav aria-label="Page navigation">
    <ul class="pagination">
        
        <!-- Previous -->
        <li class="page-item @(!Model.HasPreviousPage ? "disabled" : "")">
            <a class="page-link" 
               asp-action="Index" 
               asp-route-page="@(Model.PageIndex - 1)">
                Anterior
            </a>
        </li>
        
        <!-- Numere pagini -->
        @for (int i = 1; i <= Model.TotalPages; i++)
        {
            <li class="page-item @(i == Model.PageIndex ? "active" : "")">
                <a class="page-link" asp-action="Index" asp-route-page="@i">
                    @i
                </a>
            </li>
        }
        
        <!-- Next -->
        <li class="page-item @(!Model.HasNextPage ? "disabled" : "")">
            <a class="page-link" 
               asp-action="Index" 
               asp-route-page="@(Model.PageIndex + 1)">
                Următor
            </a>
        </li>
        
    </ul>
</nav>

<p class="text-muted">
    Total: @Model.TotalItems articole
</p>
```

### ✏️ Editor de text (Summernote / TinyMCE)

#### Summernote - Configurare

**1. Instalare:**
```html
<!-- În _Layout.cshtml sau în View -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-lite.min.js"></script>
```

**2. Inițializare în View:**
```html
@model Article

<form asp-action="Create" method="post">
    <div class="form-group">
        <label asp-for="Title"></label>
        <input asp-for="Title" class="form-control" />
    </div>
    
    <div class="form-group">
        <label asp-for="Content"></label>
        <textarea asp-for="Content" class="form-control summernote"></textarea>
    </div>
    
    <button type="submit" class="btn btn-primary">Salvează</button>
</form>

@section Scripts {
    <script>
        $(document).ready(function() {
            $('.summernote').summernote({
                height: 300,
                toolbar: [
                    ['style', ['style']],
                    ['font', ['bold', 'underline', 'clear']],
                    ['color', ['color']],
                    ['para', ['ul', 'ol', 'paragraph']],
                    ['table', ['table']],
                    ['insert', ['link', 'picture']],
                    ['view', ['fullscreen', 'codeview']]
                ]
            });
        });
    </script>
}
```

**3. Afișare conținut HTML în View:**
```html
@model Article

<h1>@Model.Title</h1>

<!-- Renderizează HTML-ul (sanitizat) -->
<div class="content">
    @Html.Raw(Model.Content)
</div>
```

### 🔍 Funcționalitate de căutare

#### 1. Controller cu căutare

```csharp
public class ArticlesController : Controller
{
    private readonly ApplicationDbContext db;
    
    public IActionResult Index(string searchQuery, int page = 1)
    {
        const int pageSize = 10;
        
        // Query de bază
        var query = db.Articles
            .Include(a => a.Category)
            .AsQueryable();
        
        // Filtrare după căutare
        if (!string.IsNullOrWhiteSpace(searchQuery))
        {
            query = query.Where(a => 
                a.Title.Contains(searchQuery) || 
                a.Content.Contains(searchQuery)
            );
        }
        
        // Numărare total
        var totalItems = query.Count();
        
        // Paginare
        var articles = query
            .OrderByDescending(a => a.Date)
            .Skip((page - 1) * pageSize)
            .Take(pageSize)
            .ToList();
        
        // ViewModel
        ViewBag.SearchQuery = searchQuery;
        ViewBag.TotalResults = totalItems;
        
        var paginatedList = new PaginatedList<Article>(
            articles, 
            totalItems, 
            page, 
            pageSize
        );
        
        return View(paginatedList);
    }
}
```

#### 2. View cu formular de căutare

```html
@model PaginatedList<Article>

<h1>Articole</h1>

<!-- Formular de căutare -->
<form asp-action="Index" method="get" class="mb-4">
    <div class="input-group">
        <input type="text" 
               name="searchQuery" 
               value="@ViewBag.SearchQuery" 
               class="form-control" 
               placeholder="Caută articole..." />
        <button type="submit" class="btn btn-primary">Căutare</button>
        
        @if (!string.IsNullOrWhiteSpace(ViewBag.SearchQuery))
        {
            <a asp-action="Index" class="btn btn-secondary">Resetează</a>
        }
    </div>
</form>

@if (!string.IsNullOrWhiteSpace(ViewBag.SearchQuery))
{
    <p class="text-muted">
        @ViewBag.TotalResults rezultate pentru "@ViewBag.SearchQuery"
    </p>
}

<!-- Lista articole -->
@foreach (var article in Model.Items)
{
    <div class="card mb-3">
        <div class="card-body">
            <h5 class="card-title">@article.Title</h5>
            <p class="card-text">@article.Content.Substring(0, 100)...</p>
        </div>
    </div>
}

<!-- Paginare (păstrează searchQuery) -->
<nav aria-label="Page navigation">
    <ul class="pagination">
        @for (int i = 1; i <= Model.TotalPages; i++)
        {
            <li class="page-item @(i == Model.PageIndex ? "active" : "")">
                <a class="page-link" 
                   asp-action="Index" 
                   asp-route-page="@i"
                   asp-route-searchQuery="@ViewBag.SearchQuery">
                    @i
                </a>
            </li>
        }
    </ul>
</nav>
```

### 🎨 Principii de Design

#### 1. Reguli de bază în design

**Contrastul:**
- Folosește culori contrastante pentru text și fundal
- Asigură-te că textul este citibil

**Alinierea:**
- Aliniază elementele consistent (stânga, centru, dreapta)
- Grupează elementele înrudite

**Spațierea:**
- Lasă spațiu între elemente (breathing room)
- Evită supraîncărcarea paginii

**Consistența:**
- Folosește aceleași stiluri pentru elemente similare
- Menține o paletă de culori consistentă

#### 2. User Experience (UX)

**Navigare intuitivă:**
- Meniu clar și accesibil
- Breadcrumbs pentru navigare
- Search bar vizibil

**Feedback utilizator:**
- Mesaje de succes/eroare
- Loading indicators
- Validare inline

**Responsive design:**
- Testează pe mobile, tablet, desktop
- Folosește Bootstrap grid system

**Accesibilitate:**
- Alt text pentru imagini
- Etichete pentru form inputs
- Contrast suficient pentru text

---

## <a name="curs-11"></a>🔌 Curs 11: REST API și Identity Framework

### 🎯 Concepte teoretice - REST API

#### Ce este REST API?
- **RE**presentational **S**tate **T**ransfer
- Arhitectură pentru servicii web
- Comunicare prin HTTP (JSON/XML)
- **Stateless**: Fiecare cerere este independentă

#### Principii REST

| Metodă HTTP | Operație | Exemplu URL | Descriere |
|-------------|----------|-------------|-----------|
| GET | Read | /api/articles | Obține lista |
| GET | Read | /api/articles/5 | Obține articolul cu id=5 |
| POST | Create | /api/articles | Creează articol nou |
| PUT | Update | /api/articles/5 | Actualizează articolul 5 |
| DELETE | Delete | /api/articles/5 | Șterge articolul 5 |

#### Coduri de status HTTP

| Cod | Semnificație | Utilizare |
|-----|--------------|-----------|
| 200 | OK | Cerere reușită |
| 201 | Created | Resursă creată |
| 204 | No Content | Ștergere reușită |
| 400 | Bad Request | Date invalide |
| 401 | Unauthorized | Neautentificat |
| 403 | Forbidden | Fără permisiuni |
| 404 | Not Found | Resursa nu există |
| 500 | Server Error | Eroare server |

### 💻 Practică - Creare API Controller

#### 1. Creare API Controller

```csharp
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace ProiectMVC.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ArticlesController : ControllerBase
    {
        private readonly ApplicationDbContext db;
        
        public ArticlesController(ApplicationDbContext context)
        {
            db = context;
        }
        
        // GET: api/articles
        [HttpGet]
        public async Task<ActionResult<IEnumerable<Article>>> GetArticles()
        {
            var articles = await db.Articles
                .Include(a => a.Category)
                .ToListAsync();
            
            return Ok(articles);
        }
        
        // GET: api/articles/5
        [HttpGet("{id}")]
        public async Task<ActionResult<Article>> GetArticle(int id)
        {
            var article = await db.Articles
                .Include(a => a.Category)
                .FirstOrDefaultAsync(a => a.Id == id);
            
            if (article == null)
            {
                return NotFound();
            }
            
            return Ok(article);
        }
        
        // POST: api/articles
        [HttpPost]
        public async Task<ActionResult<Article>> CreateArticle(Article article)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            
            article.Date = DateTime.Now;
            db.Articles.Add(article);
            await db.SaveChangesAsync();
            
            return CreatedAtAction(
                nameof(GetArticle), 
                new { id = article.Id }, 
                article
            );
        }
        
        // PUT: api/articles/5
        [HttpPut("{id}")]
        public async Task<IActionResult> UpdateArticle(int id, Article article)
        {
            if (id != article.Id)
            {
                return BadRequest();
            }
            
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }
            
            db.Entry(article).State = EntityState.Modified;
            
            try
            {
                await db.SaveChangesAsync();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ArticleExists(id))
                {
                    return NotFound();
                }
                throw;
            }
            
            return NoContent();
        }
        
        // DELETE: api/articles/5
        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteArticle(int id)
        {
            var article = await db.Articles.FindAsync(id);
            
            if (article == null)
            {
                return NotFound();
            }
            
            db.Articles.Remove(article);
            await db.SaveChangesAsync();
            
            return NoContent();
        }
        
        private bool ArticleExists(int id)
        {
            return db.Articles.Any(a => a.Id == id);
        }
    }
}
```

#### 2. Testare API cu Postman / Swagger

**Configurare Swagger în Program.cs:**
```csharp
var builder = WebApplication.CreateBuilder(args);

// Adăugare Swagger
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

var app = builder.Build();

// Activare Swagger în development
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}

// ... restul configurării
```

**Accesare:** `https://localhost:5001/swagger`

### 🔐 Identity Framework - JWT Authentication

#### 1. Instalare pachete

```bash
Install-Package Microsoft.AspNetCore.Authentication.JwtBearer
Install-Package System.IdentityModel.Tokens.Jwt
```

#### 2. Configurare JWT în appsettings.json

```json
{
  "Jwt": {
    "Key": "VerySecretKeyWithAtLeast32Characters!!",
    "Issuer": "https://localhost:5001",
    "Audience": "https://localhost:5001",
    "DurationInMinutes": 60
  }
}
```

#### 3. Configurare în Program.cs

```csharp
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.IdentityModel.Tokens;
using System.Text;

var builder = WebApplication.CreateBuilder(args);

// Configurare JWT
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options =>
    {
        options.TokenValidationParameters = new TokenValidationParameters
        {
            ValidateIssuer = true,
            ValidateAudience = true,
            ValidateLifetime = true,
            ValidateIssuerSigningKey = true,
            ValidIssuer = builder.Configuration["Jwt:Issuer"],
            ValidAudience = builder.Configuration["Jwt:Audience"],
            IssuerSigningKey = new SymmetricSecurityKey(
                Encoding.UTF8.GetBytes(builder.Configuration["Jwt:Key"])
            )
        };
    });

// ... restul configurării

var app = builder.Build();

app.UseAuthentication();  // ÎNAINTE de UseAuthorization!
app.UseAuthorization();
```

#### 4. Account Controller (Login/Register)

```csharp
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.IdentityModel.Tokens;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;

[Route("api/[controller]")]
[ApiController]
public class AccountController : ControllerBase
{
    private readonly UserManager<ApplicationUser> _userManager;
    private readonly IConfiguration _configuration;
    
    public AccountController(
        UserManager<ApplicationUser> userManager,
        IConfiguration configuration)
    {
        _userManager = userManager;
        _configuration = configuration;
    }
    
    // POST: api/account/register
    [HttpPost("register")]
    public async Task<IActionResult> Register([FromBody] RegisterModel model)
    {
        if (!ModelState.IsValid)
        {
            return BadRequest(ModelState);
        }
        
        var user = new ApplicationUser
        {
            UserName = model.Email,
            Email = model.Email
        };
        
        var result = await _userManager.CreateAsync(user, model.Password);
        
        if (!result.Succeeded)
        {
            return BadRequest(result.Errors);
        }
        
        // Adaugă rol implicit
        await _userManager.AddToRoleAsync(user, "User");
        
        return Ok(new { Message = "User registered successfully" });
    }
    
    // POST: api/account/login
    [HttpPost("login")]
    public async Task<IActionResult> Login([FromBody] LoginModel model)
    {
        var user = await _userManager.FindByEmailAsync(model.Email);
        
        if (user == null || !await _userManager.CheckPasswordAsync(user, model.Password))
        {
            return Unauthorized(new { Message = "Invalid credentials" });
        }
        
        // Generare token
        var token = await GenerateJwtToken(user);
        
        return Ok(new { Token = token });
    }
    
    private async Task<string> GenerateJwtToken(ApplicationUser user)
    {
        var roles = await _userManager.GetRolesAsync(user);
        
        var claims = new List<Claim>
        {
            new Claim(ClaimTypes.Name, user.UserName),
            new Claim(ClaimTypes.NameIdentifier, user.Id),
            new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString())
        };
        
        // Adaugă rolurile ca claims
        foreach (var role in roles)
        {
            claims.Add(new Claim(ClaimTypes.Role, role));
        }
        
        var key = new SymmetricSecurityKey(
            Encoding.UTF8.GetBytes(_configuration["Jwt:Key"])
        );
        var creds = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);
        var expires = DateTime.Now.AddMinutes(
            Convert.ToDouble(_configuration["Jwt:DurationInMinutes"])
        );
        
        var token = new JwtSecurityToken(
            issuer: _configuration["Jwt:Issuer"],
            audience: _configuration["Jwt:Audience"],
            claims: claims,
            expires: expires,
            signingCredentials: creds
        );
        
        return new JwtSecurityTokenHandler().WriteToken(token);
    }
}

// Models
public class RegisterModel
{
    [Required]
    [EmailAddress]
    public string Email { get; set; }
    
    [Required]
    [MinLength(6)]
    public string Password { get; set; }
}

public class LoginModel
{
    [Required]
    [EmailAddress]
    public string Email { get; set; }
    
    [Required]
    public string Password { get; set; }
}
```

#### 5. Protejare endpoint-uri cu [Authorize]

```csharp
[Route("api/[controller]")]
[ApiController]
public class ArticlesController : ControllerBase
{
    // Public - oricine poate accesa
    [HttpGet]
    [AllowAnonymous]
    public async Task<ActionResult<IEnumerable<Article>>> GetArticles()
    {
        // ...
    }
    
    // Doar utilizatori autentificați
    [HttpPost]
    [Authorize]
    public async Task<ActionResult<Article>> CreateArticle(Article article)
    {
        // ...
    }
    
    // Doar Admin
    [HttpDelete("{id}")]
    [Authorize(Roles = "Admin")]
    public async Task<IActionResult> DeleteArticle(int id)
    {
        // ...
    }
    
    // Admin sau Editor
    [HttpPut("{id}")]
    [Authorize(Roles = "Admin,Editor")]
    public async Task<IActionResult> UpdateArticle(int id, Article article)
    {
        // ...
    }
}
```

#### 6. Testare cu token JWT

**În Postman:**
1. Login: POST `/api/account/login` → Primești token
2. Copiezi token-ul
3. La următoarele cereri: Headers → `Authorization: Bearer <TOKEN>`

**Exemplu request:**
```
GET /api/articles
Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
```

---

## <a name="integrare"></a>🎓 Integrare Completă și Best Practices

### 📝 Checklist pentru proiect complet

#### 1. Structură și Organizare

- [ ] **Controllers** separate pentru fiecare entitate
- [ ] **Models** cu validări corecte
- [ ] **Views** organizate în foldere
- [ ] **Data** folder pentru DbContext
- [ ] **ViewModels** pentru date complexe

#### 2. Bază de Date

- [ ] **Connection string** în appsettings.json
- [ ] **DbContext** configurat corect
- [ ] **Relații** implementate (1:N, N:M)
- [ ] **Migrații** aplicate
- [ ] **Seed data** pentru testare

#### 3. Identity și Autorizare

- [ ] **Identity** configurat
- [ ] **Roluri** create (Admin, Editor, User)
- [ ] **Register/Login** funcțional
- [ ] **[Authorize]** pe controller-e/actions
- [ ] **_LoginPartial** în layout

#### 4. CRUD Operations

- [ ] **Index** - listă cu paginare
- [ ] **Show** - detalii element
- [ ] **Create** - formular + validare
- [ ] **Edit** - formular populat + validare
- [ ] **Delete** - cu confirmare

#### 5. Features Avansate

- [ ] **Căutare** funcțională
- [ ] **Paginare** implementată
- [ ] **Filtrare** după criterii
- [ ] **Sortare** (ASC/DESC)
- [ ] **Editor WYSIWYG** (Summernote/TinyMCE)

#### 6. UI/UX

- [ ] **Responsive design** (Bootstrap)
- [ ] **Navigare** intuitivă
- [ ] **Mesaje feedback** (TempData)
- [ ] **Validări client-side** (jQuery)
- [ ] **Design** consistent

### 🎯 Exemple de întrebări pentru examen

#### Teorie

**1. Explică arhitectura MVC**
- Model: Date și logică business
- View: Interfață utilizator (HTML + Razor)
- Controller: Intermediază între Model și View

**2. Ce sunt migrațiile în EF Core?**
- Sistem de versionare pentru schema BD
- Detectează modificări în modele
- Generează cod pentru actualizare BD

**3. Diferența între ViewBag, ViewData și TempData?**
- ViewBag: Obiect dinamic, doar în request curent
- ViewData: Dicționar, doar în request curent
- TempData: Persistă între redirect-uri

**4. Ce este Dependency Injection?**
- Pattern pentru gestionarea dependențelor
- Framework injectează servicii în constructori
- Configurare în Program.cs cu AddDbContext, AddIdentity, etc.

**5. Tipuri de relații în BD?**
- One-to-One (1:1): User → Profile
- One-to-Many (1:N): Category → Articles
- Many-to-Many (M:N): Students ↔ Courses (necesită tabel asociativ)

#### Practică

**1. Crează un Model Article cu validări**
```csharp
public class Article
{
    [Key]
    public int Id { get; set; }
    
    [Required(ErrorMessage = "Titlul este obligatoriu")]
    [StringLength(200, MinimumLength = 5)]
    public string Title { get; set; }
    
    [Required]
    public string Content { get; set; }
    
    public int CategoryId { get; set; }
    public virtual Category? Category { get; set; }
}
```

**2. Implementează CRUD în Controller**
```csharp
public class ArticlesController : Controller
{
    private readonly ApplicationDbContext db;
    
    public ArticlesController(ApplicationDbContext context)
    {
        db = context;
    }
    
    // Index, Show, Create, Edit, Delete
    // (vezi exemplele anterioare)
}
```

**3. Configurează Identity cu roluri**
```csharp
// Program.cs
builder.Services.AddIdentity<ApplicationUser, IdentityRole>()
    .AddEntityFrameworkStores<ApplicationDbContext>();

// Seed roluri
await roleManager.CreateAsync(new IdentityRole("Admin"));
await userManager.AddToRoleAsync(user, "Admin");
```

**4. Implementează paginare**
```csharp
public IActionResult Index(int page = 1)
{
    const int pageSize = 10;
    
    var articles = db.Articles
        .Skip((page - 1) * pageSize)
        .Take(pageSize)
        .ToList();
    
    return View(articles);
}
```

**5. Crează un API endpoint**
```csharp
[Route("api/[controller]")]
[ApiController]
public class ArticlesController : ControllerBase
{
    [HttpGet]
    public ActionResult<IEnumerable<Article>> GetArticles()
    {
        return Ok(db.Articles.ToList());
    }
    
    [HttpPost]
    [Authorize]
    public ActionResult<Article> CreateArticle(Article article)
    {
        db.Articles.Add(article);
        db.SaveChanges();
        return CreatedAtAction(nameof(GetArticle), 
            new { id = article.Id }, article);
    }
}
```

### 📚 Resurse și comenzi utile

#### Comenzi EF Core
```bash
# Creare migrație
Add-Migration NumeMigratie
dotnet ef migrations add NumeMigratie

# Aplicare migrație
Update-Database
dotnet ef database update

# Eliminare migrație
Remove-Migration
dotnet ef migrations remove

# Listare migrații
dotnet ef migrations list

# Creare bază de date
dotnet ef database update

# Ștergere bază de date
Drop-Database
dotnet ef database drop
```

#### Comenzi NuGet
```bash
# Instalare pachet
Install-Package NumePachet
dotnet add package NumePachet

# Actualizare pachet
Update-Package NumePachet
dotnet add package NumePachet --version x.x.x

# Dezinstalare pachet
Uninstall-Package NumePachet
dotnet remove package NumePachet
```

#### Comenzi dotnet CLI
```bash
# Creare proiect nou
dotnet new mvc -n NumeProiect

# Rulare aplicație
dotnet run

# Build
dotnet build

# Publish
dotnet publish -c Release

# Listare pachete instalate
dotnet list package
```

---

## 📌 Rezumat Final

### Concepte esențiale de reținut

1. **MVC Architecture**: Model (date), View (UI), Controller (logică)
2. **Entity Framework Core**: ORM pentru interacțiune cu BD
3. **Migrații**: Versionare schemă BD
4. **LINQ**: Interogări în C# (type-safe)
5. **Identity**: Sistem de autentificare și autorizare
6. **Razor Syntax**: HTML + C# în Views
7. **Validări**: Data Annotations + ModelState
8. **REST API**: GET, POST, PUT, DELETE + JSON
9. **Dependency Injection**: Injectare servicii în constructori
10. **Routing**: Mapare URL-uri la acțiuni

### Flow-ul unei cereri MVC

```
Browser
   ↓
REQUEST → /Articles/Show/5
   ↓
ROUTING → Identifică ArticlesController.Show(5)
   ↓
CONTROLLER → Apelează db.Articles.Find(5)
   ↓
MODEL → Entity Framework → SQL Query → Database
   ↓
DATABASE → Returnează date
   ↓
CONTROLLER → Trimite date către View
   ↓
VIEW → Generează HTML (Razor)
   ↓
RESPONSE → Browser primește HTML
   ↓
Browser afișează pagina
```

### Checkpoints pentru examen

- [ ] Înțeleg arhitectura MVC
- [ ] Știu să creez modele cu validări
- [ ] Pot implementa CRUD complet
- [ ] Știu să configurez EF Core și migrații
- [ ] Înțeleg relațiile în BD (1:1, 1:N, N:M)
- [ ] Pot scrie interogări LINQ
- [ ] Știu să configurez Identity
- [ ] Pot implementa autorizare pe roluri
- [ ] Știu să trimit date către View (Model, ViewBag, etc.)
- [ ] Pot crea formulare cu validare
- [ ] Înțeleg Layout-uri și Partial Views
- [ ] Pot implementa paginare și căutare
- [ ] Știu să creez un API RESTful
- [ ] Înțeleg JWT authentication

---

**Succes la examen! 🎓✨**

*Acest document acoperă toate conceptele fundamentale și practice din cursurile 1-12.*
