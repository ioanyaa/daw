# 🚀 QUICK START GUIDE

## Pași Rapidi de Instalare

### 1. Deschide Proiectul
- Deschide `ArticlesApp.csproj` cu Visual Studio 2022
- Restaurează pachetele NuGet (se face automat)

### 2. Creează Baza de Date

Deschide **Package Manager Console** și rulează:

```powershell
Add-Migration InitialCreate
Update-Database
```

### 3. Adaugă Date de Test

**Opțiunea 1 - SQL Server Object Explorer:**
1. View → SQL Server Object Explorer
2. (localdb)\mssqllocaldb → Databases → ArticlesDb
3. Right-click pe `ArticlesDb` → New Query
4. Copiază conținutul din `SampleData.sql` și execută (F5)

**Opțiunea 2 - Direct în tabele:**
1. Deschide `Categories` table → View Data
2. Adaugă manual:
   - Tehnologie
   - Sport
   - Cultură
   - Știință
3. Deschide `Articles` table → View Data
4. Adaugă câteva articole

### 4. Rulează Aplicația

Apasă **F5** sau click pe butonul verde **Run**

Browser-ul va deschide: `https://localhost:XXXX/Articles`

---

## 📁 Structura Fișierelor

```
ArticlesApp/
├── Controllers/
│   ├── ArticlesController.cs      ✅ CRUD complet
│   └── CategoriesController.cs    ✅ Index + Delete
├── Models/
│   ├── Article.cs                 ✅ Cu validări
│   └── Category.cs                ✅ Cu relație
├── Data/
│   └── ApplicationDbContext.cs    ✅ DbContext configurat
├── Views/
│   ├── Articles/                  ✅ Toate view-urile CRUD
│   └── Categories/                ✅ Index + Delete
├── Program.cs                     ✅ Configurat
├── appsettings.json              ✅ Connection string
└── SampleData.sql                ✅ Date de test
```

---

## ✅ Checklist După Instalare

- [ ] Proiectul se compilează fără erori
- [ ] Baza de date `ArticlesDb` există
- [ ] Tabelele `Articles` și `Categories` sunt create
- [ ] Există cel puțin 4 categorii în baza de date
- [ ] Există articole de test
- [ ] Aplicația pornește și merge la `/Articles`
- [ ] Poți crea un articol nou
- [ ] Dropdown-ul pentru categorii funcționează
- [ ] Poți edita și șterge articole
- [ ] Nu poți șterge o categorie cu articole

---

## 🛠️ Comenzi Utile

### Package Manager Console

```powershell
# Creare migrație
Add-Migration NumeMigratie

# Aplicare migrații
Update-Database

# Rollback la migrație anterioară
Update-Database MigratiePrecedenta

# Ștergere ultimă migrație (dacă nu e aplicată)
Remove-Migration
```

### SQL Server Object Explorer

```sql
-- Verificare categorii
SELECT * FROM Categories;

-- Verificare articole cu categorii
SELECT a.Title, c.Title AS Category, a.Date
FROM Articles a
INNER JOIN Categories c ON a.CategoryId = c.Id;

-- Ștergere toate datele (pentru reset)
DELETE FROM Articles;
DELETE FROM Categories;
```

---

## 🎯 Teste Funcționale

### Test 1: Creare Articol
1. Click pe "Adaugă Articol Nou"
2. Completează toate câmpurile
3. Selectează o categorie din dropdown
4. Click "Salvează"
5. **Rezultat așteptat:** Mesaj verde "Articolul a fost creat cu succes!"

### Test 2: Validări
1. Click pe "Adaugă Articol Nou"
2. Lasă câmpurile goale
3. Click "Salvează"
4. **Rezultat așteptat:** Mesaje de eroare roșii pentru fiecare câmp

### Test 3: Editare
1. Click pe "Editează" la un articol
2. Modifică titlul și categoria
3. Click "Salvează Modificările"
4. **Rezultat așteptat:** Modificările sunt salvate

### Test 4: Ștergere Categorie cu Articole
1. Mergi la `/Categories`
2. Încearcă să ștergi o categorie care are articole
3. **Rezultat așteptat:** Mesaj de eroare "Nu poți șterge această categorie deoarece conține articole!"

---

## 📞 Suport

Dacă întâmpini probleme:
1. Verifică că SQL Server LocalDB este instalat
2. Verifică connection string-ul în `appsettings.json`
3. Asigură-te că pachetele NuGet sunt instalate
4. Rulează din nou migrațiile

**Success! 🎉**
