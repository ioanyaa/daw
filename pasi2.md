## GHID COMPLET - Aplicație Gym Memberships (Abonamente Săli de Sport)

### PASUL 1: Creare Proiect

1. **Visual Studio** → New Project
2. Selectează **ASP.NET Core Web App (Model-View-Controller)**
3. Nume: `GymMembershipsApp`
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

**Models/Gym.cs**
```csharp
using System.ComponentModel.DataAnnotations;

namespace GymMembershipsApp.Models
{
    public class Gym
    {
        [Key]
        public int Id { get; set; }

        [Required(ErrorMessage = "Numele sălii de sport este obligatoriu")]
        [StringLength(100, ErrorMessage = "Numele nu poate depăși 100 de caractere")]
        public string Nume { get; set; }

        // Relație one-to-many
        public virtual ICollection<Membership> Memberships { get; set; } = new List<Membership>();
    }
}
```

**Models/Membership.cs**
```csharp
using System.ComponentModel.DataAnnotations;

namespace GymMembershipsApp.Models
{
    public class Membership
    {
        [Key]
        public int Id { get; set; }

        [Required(ErrorMessage = "Titlul abonamentului este obligatoriu")]
        [StringLength(200, ErrorMessage = "Titlul nu poate depăși 200 de caractere")]
        public string Titlu { get; set; }

        [Required(ErrorMessage = "Valoarea abonamentului este obligatorie")]
        [Range(1, int.MaxValue, ErrorMessage = "Valoarea abonamentului trebuie să fie un număr întreg pozitiv")]
        public int Valoare { get; set; }

        [Required(ErrorMessage = "Data emiterii este obligatorie")]
        [DataType(DataType.DateTime)]
        public DateTime DataEmitere { get; set; }

        [Required(ErrorMessage = "Sala de sport este obligatorie")]
        public int GymId { get; set; }

        // Navigation property
        public virtual Gym? Gym { get; set; }
    }
}
```

---

### PASUL 4: Creare DbContext

**Data/ApplicationDbContext.cs** (crează folderul Data mai întâi)

```csharp
using GymMembershipsApp.Models;
using Microsoft.EntityFrameworkCore;

namespace GymMembershipsApp.Data
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) 
            : base(options)
        {
        }

        public DbSet<Gym> Gyms { get; set; }
        public DbSet<Membership> Memberships { get; set; }

        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            // Configurare relație
            modelBuilder.Entity<Membership>()
                .HasOne(m => m.Gym)
                .WithMany(g => g.Memberships)
                .HasForeignKey(m => m.GymId)
                .OnDelete(DeleteBehavior.Restrict); // Previne ștergerea sălii dacă are abonamente
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
    "DefaultConnection": "Server=(localdb)\\mssqllocaldb;Database=GymMembershipsDb;Trusted_Connection=True;MultipleActiveResultSets=true"
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
using GymMembershipsApp.Data;
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
    pattern: "{controller=Memberships}/{action=Index}/{id?}");

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

**SQL Server Object Explorer** → GymMembershipsDb → Tables

**Inserează săli de sport:**
```sql
INSERT INTO Gyms (Nume) VALUES ('World Class');
INSERT INTO Gyms (Nume) VALUES ('Fitness Factory');
INSERT INTO Gyms (Nume) VALUES ('GymBox');
INSERT INTO Gyms (Nume) VALUES ('Premium Fitness');
```

**Inserează abonamente:**
```sql
INSERT INTO Memberships (Titlu, Valoare, DataEmitere, GymId) 
VALUES ('Abonament Standard', 150, GETDATE(), 1);

INSERT INTO Memberships (Titlu, Valoare, DataEmitere, GymId) 
VALUES ('Abonament Premium', 300, GETDATE(), 1);

INSERT INTO Memberships (Titlu, Valoare, DataEmitere, GymId) 
VALUES ('Abonament Student', 100, GETDATE(), 2);

INSERT INTO Memberships (Titlu, Valoare, DataEmitere, GymId) 
VALUES ('Abonament VIP', 500, GETDATE(), 3);
```

---

### PASUL 9: Controller pentru Memberships

**Controllers/MembershipsController.cs** (Add → Controller → MVC Controller - Empty)

```csharp
using GymMembershipsApp.Data;
using GymMembershipsApp.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Rendering;
using Microsoft.EntityFrameworkCore;

namespace GymMembershipsApp.Controllers
{
    public class MembershipsController : Controller
    {
        private readonly ApplicationDbContext _context;

        public MembershipsController(ApplicationDbContext context)
        {
            _context = context;
        }

        // GET: Memberships (Index)
        public IActionResult Index()
        {
            var memberships = _context.Memberships
                .Include(m => m.Gym)
                .OrderByDescending(m => m.DataEmitere)
                .ToList();

            return View(memberships);
        }

        // GET: Memberships/New
        public IActionResult New()
        {
            ViewBag.Gyms = new SelectList(_context.Gyms, "Id", "Nume");
            
            // Setăm data curentă pentru abonament nou
            var membership = new Membership
            {
                DataEmitere = DateTime.Now
            };
            
            return View(membership);
        }

        // POST: Memberships/New
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult New([Bind("Titlu,Valoare,DataEmitere,GymId")] Membership membership)
        {
            if (ModelState.IsValid)
            {
                _context.Memberships.Add(membership);
                _context.SaveChanges();
                TempData["SuccessMessage"] = "Abonamentul a fost adăugat cu succes!";
                return RedirectToAction(nameof(Index));
            }

            ViewBag.Gyms = new SelectList(_context.Gyms, "Id", "Nume", membership.GymId);
            return View(membership);
        }

        // GET: Memberships/Edit/5
        public IActionResult Edit(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var membership = _context.Memberships.Find(id);
            if (membership == null)
            {
                return NotFound();
            }

            ViewBag.Gyms = new SelectList(_context.Gyms, "Id", "Nume", membership.GymId);
            return View(membership);
        }

        // POST: Memberships/Edit/5
        [HttpPost]
        [ValidateAntiForgeryToken]
        public IActionResult Edit(int id, [Bind("Id,Titlu,Valoare,DataEmitere,GymId")] Membership membership)
        {
            if (id != membership.Id)
            {
                return NotFound();
            }

            if (ModelState.IsValid)
            {
                try
                {
                    _context.Update(membership);
                    _context.SaveChanges();
                    TempData["SuccessMessage"] = "Abonamentul a fost modificat cu succes!";
                }
                catch (DbUpdateConcurrencyException)
                {
                    if (!MembershipExists(membership.Id))
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

            ViewBag.Gyms = new SelectList(_context.Gyms, "Id", "Nume", membership.GymId);
            return View(membership);
        }

        // GET: Memberships/Delete/5
        public IActionResult Delete(int? id)
        {
            if (id == null)
            {
                return NotFound();
            }

            var membership = _context.Memberships
                .Include(m => m.Gym)
                .FirstOrDefault(m => m.Id == id);

            if (membership == null)
            {
                return NotFound();
            }

            return View(membership);
        }

        // POST: Memberships/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public IActionResult DeleteConfirmed(int id)
        {
            var membership = _context.Memberships.Find(id);
            
            if (membership == null)
            {
                return NotFound();
            }

            _context.Memberships.Remove(membership);
            _context.SaveChanges();
            TempData["SuccessMessage"] = "Abonamentul a fost șters cu succes!";

            return RedirectToAction(nameof(Index));
        }

        private bool MembershipExists(int id)
        {
            return _context.Memberships.Any(e => e.Id == id);
        }
    }
}
```

---

### PASUL 10: View-uri pentru Memberships

**Views/Memberships/Index.cshtml**

```html
@model IEnumerable<GymMembershipsApp.Models.Membership>

@{
    ViewData["Title"] = "Afișare Abonamente";
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

    <div class="mb-3">
        <a asp-action="New" class="btn btn-primary">
            <i class="bi bi-plus-circle"></i> Adaugă Abonament Nou
        </a>
    </div>

    @if (!Model.Any())
    {
        <div class="alert alert-info">
            Nu există abonamente în baza de date.
        </div>
    }
    else
    {
        <table class="table table-striped table-hover">
            <thead class="table-dark">
                <tr>
                    <th>Titlu</th>
                    <th>Valoare (RON)</th>
                    <th>Data Emiterii</th>
                    <th>Sala de Sport</th>
                    <th>Acțiuni</th>
                </tr>
            </thead>
            <tbody>
                @foreach (var membership in Model)
                {
                    <tr>
                        <td>@membership.Titlu</td>
                        <td>
                            <span class="badge bg-success">@membership.Valoare RON</span>
                        </td>
                        <td>@membership.DataEmitere.ToString("dd.MM.yyyy HH:mm")</td>
                        <td>
                            <strong>@membership.Gym?.Nume</strong>
                        </td>
                        <td>
                            <a asp-action="Edit" asp-route-id="@membership.Id" class="btn btn-sm btn-warning">
                                Editează
                            </a>
                            <a asp-action="Delete" asp-route-id="@membership.Id" class="btn btn-sm btn-danger">
                                Șterge
                            </a>
                        </td>
                    </tr>
                }
            </tbody>
        </table>
    }
</div>
```

**Views/Memberships/New.cshtml**

```html
@model GymMembershipsApp.Models.Membership

@{
    ViewData["Title"] = "Adăugare Abonament";
}

<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <h1>@ViewData["Title"]</h1>
            <hr />

            <form asp-action="New" method="post">
                <div asp-validation-summary="ModelOnly" class="text-danger mb-3"></div>

                <div class="mb-3">
                    <label asp-for="Titlu" class="form-label">Titlu Abonament</label>
                    <input asp-for="Titlu" class="form-control" placeholder="Ex: Abonament Premium" />
                    <span asp-validation-for="Titlu" class="text-danger"></span>
                </div>

                <div class="mb-3">
                    <label asp-for="Valoare" class="form-label">Valoare (RON)</label>
                    <input asp-for="Valoare" type="number" class="form-control" placeholder="Ex: 150" />
                    <span asp-validation-for="Valoare" class="text-danger"></span>
                </div>

                <div class="mb-3">
                    <label asp-for="DataEmitere" class="form-label">Data Emiterii</label>
                    <input asp-for="DataEmitere" type="datetime-local" class="form-control" />
                    <span asp-validation-for="DataEmitere" class="text-danger"></span>
                    <small class="form-text text-muted">Data este setată automat la data curentă</small>
                </div>

                <div class="mb-3">
                    <label asp-for="GymId" class="form-label">Sala de Sport</label>
                    <select asp-for="GymId" class="form-select" asp-items="ViewBag.Gyms">
                        <option value="">-- Selectează Sala --</option>
                    </select>
                    <span asp-validation-for="GymId" class="text-danger"></span>
                </div>

                <div class="mt-4">
                    <button type="submit" class="btn btn-primary">Adaugă Abonament</button>
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

**Views/Memberships/Edit.cshtml**

```html
@model GymMembershipsApp.Models.Membership

@{
    ViewData["Title"] = "Editare Abonament";
}

<div class="container mt-4">
    <div class="row justify-content-center">
        <div class="col-md-8">
            <h1>@ViewData["Title"]</h1>
            <hr />

            <form asp-action="Edit" method="post">
                <div asp-validation-summary="ModelOnly" class="text-danger mb-3"></div>

                <input type="hidden" asp-for="Id" />

                <div class="mb-3">
                    <label asp-for="Titlu" class="form-label">Titlu Abonament</label>
                    <input asp-for="Titlu" class="form-control" />
                    <span asp-validation-for="Titlu" class="text-danger"></span>
                </div>

                <div class="mb-3">
                    <label asp-for="Valoare" class="form-label">Valoare (RON)</label>
                    <input asp-for="Valoare" type="number" class="form-control" />
                    <span asp-validation-for="Valoare" class="text-danger"></span>
                </div>

                <div class="mb-3">
                    <label class="form-label">Data Emiterii</label>
                    <input type="text" class="form-control" value="@Model.DataEmitere.ToString("dd.MM.yyyy HH:mm")" disabled />
                    <input type="hidden" asp-for="DataEmitere" />
                    <small class="form-text text-muted">Data emiterii nu poate fi modificată</small>
                </div>

                <div class="mb-3">
                    <label asp-for="GymId" class="form-label">Sala de Sport</label>
                    <select asp-for="GymId" class="form-select" asp-items="ViewBag.Gyms">
                        <option value="">-- Selectează Sala --</option>
                    </select>
                    <span asp-validation-for="GymId" class="text-danger"></span>
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

**Views/Memberships/Delete.cshtml**

```html
@model GymMembershipsApp.Models.Membership

@{
    ViewData["Title"] = "Șterge Abonament";
}

<div class="container mt-4">
    <h1 class="text-danger">@ViewData["Title"]</h1>
    <hr />

    <div class="alert alert-warning">
        <h4>Ești sigur că vrei să ștergi acest abonament?</h4>
    </div>

    <div class="card">
        <div class="card-body">
            <dl class="row">
                <dt class="col-sm-3">Titlu</dt>
                <dd class="col-sm-9">@Model.Titlu</dd>

                <dt class="col-sm-3">Valoare</dt>
                <dd class="col-sm-9">
                    <span class="badge bg-success">@Model.Valoare RON</span>
                </dd>

                <dt class="col-sm-3">Data Emiterii</dt>
                <dd class="col-sm-9">@Model.DataEmitere.ToString("dd.MM.yyyy HH:mm")</dd>

                <dt class="col-sm-3">Sala de Sport</dt>
                <dd class="col-sm-9">
                    <strong>@Model.Gym?.Nume</strong>
                </dd>
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

### PASUL 11: Actualizare Layout

**Views/Shared/_Layout.cshtml** - adaugă în navbar (între `<ul class="navbar-nav flex-grow-1">`):

```html
<li class="nav-item">
    <a class="nav-link text-dark" asp-controller="Memberships" asp-action="New">Adăugare Abonament</a>
</li>
<li class="nav-item">
    <a class="nav-link text-dark" asp-controller="Memberships" asp-action="Index">Afișare Abonamente</a>
</li>
```

**Exemplu complet de navbar:**

```html
<div class="navbar-collapse collapse d-sm-inline-flex justify-content-between">
    <ul class="navbar-nav flex-grow-1">
        <li class="nav-item">
            <a class="nav-link text-dark" asp-area="" asp-controller="Home" asp-action="Index">Home</a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-dark" asp-controller="Memberships" asp-action="New">Adăugare Abonament</a>
        </li>
        <li class="nav-item">
            <a class="nav-link text-dark" asp-controller="Memberships" asp-action="Index">Afișare Abonamente</a>
        </li>
    </ul>
</div>
```

---

### PASUL 12: Rulare și Testare

1. **Apasă F5** sau Run
2. Navigează la **Memberships/Index**
3. Testează toate operațiunile:
   - ✅ **Index** - Vizualizează lista de abonamente cu informații despre săli
   - ✅ **New** - Adaugă abonamente noi (data se setează automat la data curentă)
   - ✅ **Edit** - Editează abonamente (data emiterii rămâne neschimbată)
   - ✅ **Delete** - Șterge abonamente cu mesaj de confirmare

---

## ✅ CHECKLIST FINAL

- ✅ Modele `Gym` și `Membership` cu validări complete
- ✅ Relație one-to-many (Gym → Memberships)
- ✅ Chei primare și externe configurate corect
- ✅ DbContext configurat cu restricții de ștergere
- ✅ Migrații create și rulate
- ✅ Date de test adăugate în baza de date
- ✅ CRUD complet pentru Membership:
  - ✅ **Index** - Afișare cu titlu, valoare, data emiterii, nume sală
  - ✅ **New** - Adăugare cu dropdown pentru săli
  - ✅ **Edit** - Editare cu dropdown, data emiterii read-only
  - ✅ **Delete** - Ștergere cu mesaj de confirmare
- ✅ Dropdown pentru selectarea sălii de sport
- ✅ Validări pentru toate câmpurile:
  - ✅ Titlu obligatoriu
  - ✅ Valoare obligatorie și număr întreg pozitiv
  - ✅ Data emiterii obligatorie
  - ✅ GymId obligatoriu
- ✅ Data emiterii nu este editabilă în formular Edit
- ✅ ID-urile nu sunt vizibile în interfață
- ✅ TempData pentru mesaje de success
- ✅ Layout actualizat cu linkuri către "Adăugare Abonament" și "Afișare Abonamente"
- ✅ Design Bootstrap responsive
- ✅ Mesaje de validare personalizate în română

---

## 📝 OBSERVAȚII IMPORTANTE

1. **Data Emiterii**: 
   - Se setează automat la data curentă când creezi un abonament nou
   - NU poate fi modificată în pagina de editare (câmp read-only)
   - Se păstrează întotdeauna data inițială din momentul creării

2. **Validări**:
   - Toate câmpurile sunt obligatorii
   - Valoarea trebuie să fie un număr întreg pozitiv (min. 1)
   - Mesaje de eroare personalizate în română pentru fiecare câmp

3. **Relații**:
   - O sală de sport poate avea mai multe abonamente
   - Un abonament aparține unei singure săli de sport
   - `DeleteBehavior.Restrict` previne ștergerea accidentală a sălilor cu abonamente

4. **Nume Metode**:
   - **New** (nu Create) - pentru adăugare
   - **Edit** - pentru editare
   - **Delete** - pentru ștergere
   - **Index** - pentru listare

Aplicația este completă și respectă toate cerințele laboratorului! 🎉
