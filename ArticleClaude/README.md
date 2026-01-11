# 📚 ArticlesApp - Aplicație ASP.NET Core MVC

Aplicație web pentru gestionarea articolelor și categoriilor, implementând operațiile CRUD complete.

## 📋 Cerințe Tehnice

- **.NET 6.0** sau superior
- **SQL Server** (LocalDB sau SQL Server Express)
- **Visual Studio 2022** sau VS Code cu extensia C#

---

## 🚀 Pași de Instalare

### 1. Creare Proiect Nou

1. Deschide **Visual Studio 2022**
2. Click pe **Create a new project**
3. Selectează **ASP.NET Core Web App (Model-View-Controller)**
4. Setări:
   - **Project name:** `ArticlesApp`
   - **Framework:** `.NET 6.0` (sau mai nou)
   - **Authentication type:** `None`
5. Click **Create**

---

### 2. Instalare Pachete NuGet

Deschide **Package Manager Console** (`Tools → NuGet Package Manager → Package Manager Console`)

```powershell
Install-Package Microsoft.EntityFrameworkCore.SqlServer -Version 6.0.0
Install-Package Microsoft.EntityFrameworkCore.Tools -Version 6.0.0
```

---

### 3. Structura Proiectului

```
ArticlesApp/
│
├── Controllers/
│   ├── ArticlesController.cs
│   └── CategoriesController.cs
│
├── Models/
│   ├── Article.cs
│   └── Category.cs
│
├── Data/
│   └── ApplicationDbContext.cs
│
├── Views/
│   ├── Articles/
│   │   ├── Index.cshtml
│   │   ├── Details.cshtml
│   │   ├── Create.cshtml
│   │   ├── Edit.cshtml
│   │   └── Delete.cshtml
│   │
│   ├── Categories/
│   │   ├── Index.cshtml
│   │   └── Delete.cshtml
│   │
│   └── Shared/
│       ├── _Layout.cshtml
│       └── _ValidationScriptsPartial.cshtml
│
├── appsettings.json
├── Program.cs
└── ArticlesApp.csproj
```

---

### 4. Copiere Fișiere

Copiază toate fișierele din acest pachet în locațiile corespunzătoare din proiectul tău.

**Important:** Creează mai întâi folderul `Data` în rădăcina proiectului!

---

### 5. Configurare Connection String

Fișierul `appsettings.json` este deja configurat cu:

```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=(localdb)\\mssqllocaldb;Database=ArticlesDb;Trusted_Connection=True;MultipleActiveResultSets=true"
  }
}
```

**Dacă folosești SQL Server Express**, modifică la:
```
Server=localhost\\SQLEXPRESS;Database=ArticlesDb;Trusted_Connection=True;
```

---

### 6. Creare Bază de Date

În **Package Manager Console**, execută:

```powershell
Add-Migration InitialCreate
Update-Database
```

Aceasta va crea baza de date `ArticlesDb` cu tabelele:
- `Articles`
- `Categories`

---

### 7. Adăugare Date de Test

#### Opțiunea 1: SQL Server Object Explorer (Visual Studio)

1. Deschide **View → SQL Server Object Explorer**
2. Navighează la `(localdb)\mssqllocaldb → Databases → ArticlesDb → Tables`
3. Click dreapta pe `Categories` → **View Data**
4. Adaugă manual categorii:
   - Tehnologie
   - Sport
   - Cultură
   - Știință

5. Click dreapta pe `Articles` → **View Data**
6. Adaugă articole (asigură-te că `CategoryId` corespunde cu ID-urile din Categories)

#### Opțiunea 2: SQL Query

Click dreapta pe `ArticlesDb` → **New Query** și execută:

```sql
-- Inserare Categorii
INSERT INTO Categories (Title) VALUES ('Tehnologie');
INSERT INTO Categories (Title) VALUES ('Sport');
INSERT INTO Categories (Title) VALUES ('Cultură');
INSERT INTO Categories (Title) VALUES ('Știință');

-- Inserare Articole
INSERT INTO Articles (Title, Content, Date, CategoryId) 
VALUES ('Noua versiune .NET 9', 'Microsoft a lansat .NET 9 cu îmbunătățiri semnificative de performanță și noi funcționalități pentru dezvoltatorii moderni.', GETDATE(), 1);

INSERT INTO Articles (Title, Content, Date, CategoryId) 
VALUES ('Campionatul Mondial de Fotbal 2026', 'Pregătirile pentru Cupa Mondială din 2026 sunt în toi, cu stadioane noi și tehnologii inovatoare pentru fani.', GETDATE(), 2);

INSERT INTO Articles (Title, Content, Date, CategoryId) 
VALUES ('Expoziție de artă contemporană', 'Muzeul Național deschide o nouă expoziție cu lucrări ale artiștilor contemporani români și internaționali.', GETDATE(), 3);

INSERT INTO Articles (Title, Content, Date, CategoryId) 
VALUES ('Descoperire în fizica cuantică', 'Cercetători au demonstrat un nou fenomen cuantic care ar putea revoluționa calculatoarele viitorului.', GETDATE(), 4);

INSERT INTO Articles (Title, Content, Date, CategoryId) 
VALUES ('Inteligența Artificială în 2025', 'Analiza trendurilor și inovațiilor din domeniul AI care vor marca industria tech în următorii ani.', GETDATE(), 1);
```

---

### 8. Rulare Aplicație

1. Apasă **F5** sau click pe **Run** în Visual Studio
2. Browser-ul va deschide aplicația
3. Navighează la:
   - `https://localhost:XXXX/Articles` - pentru lista de articole
   - `https://localhost:XXXX/Categories` - pentru categorii

---

## ✨ Funcționalități

### Articole (CRUD Complet)

✅ **Create** - Adăugare articol nou cu:
- Validări pe toate câmpurile
- Dropdown pentru selecție categorie
- Data și ora publicării

✅ **Read** - Vizualizare:
- Listă completă cu categorie afișată
- Detalii individuale pentru fiecare articol

✅ **Update** - Editare:
- Modificare toate câmpurile
- Dropdown pentru schimbare categorie

✅ **Delete** - Ștergere cu confirmare

### Categorii

✅ Afișare listă cu număr de articole
✅ Ștergere categorie (doar dacă nu conține articole)
✅ Validare: previne ștergerea categoriilor cu articole

---

## 🎨 Tehnologii Folosite

- **ASP.NET Core 6.0 MVC**
- **Entity Framework Core 6.0**
- **SQL Server / LocalDB**
- **Bootstrap 5** (pentru UI)
- **Razor Pages** (pentru view-uri)

---

## 📊 Structura Bazei de Date

### Tabel: Categories
| Coloană | Tip | Constrângeri |
|---------|-----|--------------|
| Id | int | Primary Key, Identity |
| Title | nvarchar(100) | Required |

### Tabel: Articles
| Coloană | Tip | Constrângeri |
|---------|-----|--------------|
| Id | int | Primary Key, Identity |
| Title | nvarchar(200) | Required, MinLength: 5 |
| Content | nvarchar(MAX) | Required, MinLength: 10 |
| Date | datetime2 | Required |
| CategoryId | int | Foreign Key → Categories.Id |

**Relație:** One-to-Many (Category → Articles)

**Delete Behavior:** Restrict (nu se poate șterge categoria dacă are articole)

---

## 🔧 Troubleshooting

### Eroare: "Cannot open database"
**Soluție:** Verifică connection string-ul în `appsettings.json` și asigură-te că SQL Server LocalDB este pornit.

### Eroare: "No migrations found"
**Soluție:** Rulează din nou:
```powershell
Add-Migration InitialCreate
Update-Database
```

### Dropdown-ul pentru categorii este gol
**Soluție:** Adaugă categorii în baza de date folosind SQL Server Object Explorer.

### Eroare la ștergere categorie
**Soluție:** Aceasta este normal dacă categoria conține articole. Șterge mai întâi articolele sau mută-le în altă categorie.

---

## 📝 Validări Implementate

### Article Model
- **Title:** Obligatoriu, 5-200 caractere
- **Content:** Obligatoriu, minim 10 caractere
- **Date:** Obligatoriu
- **CategoryId:** Obligatoriu

### Category Model
- **Title:** Obligatoriu, maxim 100 caractere

---

## 🎯 Funcționalități Extra Implementate

✅ Mesaje de succes/eroare cu TempData
✅ Validare împiedică ștergerea categoriilor cu articole
✅ Formatare profesională a datelor
✅ UI responsive cu Bootstrap
✅ Tag helpers pentru formulare
✅ Anti-forgery tokens pentru securitate

---

## 📚 Cerințe Îndeplinite

- ✅ Două modele (Article, Category) cu relație
- ✅ CRUD complet pe Article
- ✅ Afișare articole cu denumirea categoriei
- ✅ Detalii articol individual
- ✅ Adăugare cu validări și helpere
- ✅ Editare cu dropdown pentru categorie
- ✅ Ștergere articol
- ✅ Ștergere categorie
- ✅ ID-urile nu sunt vizibile/editabile în interfață
- ✅ Fără cod generat automat
- ✅ Controllers și Views create manual

---

## 👨‍💻 Autor

Aplicație creată pentru învățarea ASP.NET Core MVC și Entity Framework Core.

---

## 📄 Licență

Acest proiect este creat în scop educațional.

---

## 🆘 Suport

Pentru probleme sau întrebări:
1. Verifică secțiunea **Troubleshooting**
2. Revizuiește pașii de instalare
3. Asigură-te că toate pachetele NuGet sunt instalate corect

**Succes! 🚀**
