-- Script pentru adăugarea datelor de test în baza de date ArticlesDb
-- Rulați acest script în SQL Server Object Explorer după ce ați creat baza de date

-- ================================================
-- 1. INSERARE CATEGORII
-- ================================================

INSERT INTO Categories (Title) VALUES ('Tehnologie');
INSERT INTO Categories (Title) VALUES ('Sport');
INSERT INTO Categories (Title) VALUES ('Cultură');
INSERT INTO Categories (Title) VALUES ('Știință');

-- ================================================
-- 2. INSERARE ARTICOLE
-- ================================================

-- Articole despre Tehnologie (CategoryId = 1)
INSERT INTO Articles (Title, Content, Date, CategoryId) 
VALUES (
    'Noua versiune .NET 9', 
    'Microsoft a lansat oficial .NET 9, cea mai recentă versiune a platformei de dezvoltare. Aceasta vine cu îmbunătățiri semnificative de performanță, suport îmbunătățit pentru cloud și noi funcționalități pentru dezvoltatorii moderni. Printre cele mai importante caracteristici se numără suportul avansat pentru aplicații native cloud, îmbunătățiri la C# 12 și un ecosistem de biblioteci mai bogat.',
    GETDATE(), 
    1
);

INSERT INTO Articles (Title, Content, Date, CategoryId) 
VALUES (
    'Inteligența Artificială în 2025', 
    'Anul 2025 marchează o nouă eră în dezvoltarea inteligenței artificiale. Companiile tech investesc miliarde în cercetare și dezvoltare, iar aplicațiile practice ale AI devin din ce în ce mai prezente în viața cotidiană. De la asistente virtuale avansate până la conducere autonomă, AI transformă modul în care interacționăm cu tehnologia.',
    DATEADD(day, -2, GETDATE()), 
    1
);

-- Articole despre Sport (CategoryId = 2)
INSERT INTO Articles (Title, Content, Date, CategoryId) 
VALUES (
    'Campionatul Mondial de Fotbal 2026', 
    'Pregătirile pentru Cupa Mondială FIFA din 2026 sunt în toi. Turneul va avea loc în Statele Unite, Canada și Mexico, fiind prima ediție găzduită de trei țări. Stadioanele ultra-moderne și tehnologiile inovatoare promit să ofere fanilor o experiență de neuitat. Peste 48 de echipe vor concura pentru titlul suprem.',
    DATEADD(day, -5, GETDATE()), 
    2
);

INSERT INTO Articles (Title, Content, Date, CategoryId) 
VALUES (
    'Recorduri la Jocurile Olimpice', 
    'Jocurile Olimpice continuă să ne surprindă cu performanțe extraordinare. Sportivii își depășesc constant limitele, stabilind noi recorduri mondiale în diverse discipline. Pregătirea intensivă, tehnologia avansată în echipament și metodele moderne de antrenament contribuie la aceste realizări remarcabile.',
    DATEADD(day, -10, GETDATE()), 
    2
);

-- Articole despre Cultură (CategoryId = 3)
INSERT INTO Articles (Title, Content, Date, CategoryId) 
VALUES (
    'Expoziție de artă contemporană', 
    'Muzeul Național de Artă Contemporană deschide o nouă expoziție care prezintă lucrări ale unor artiști contemporani români și internaționali. Vizitatorii vor putea admira instalații interactive, picturi abstracte și sculpturi moderne care explorează teme actuale precum schimbările climatice, identitatea digitală și relațiile umane în era tehnologiei.',
    DATEADD(day, -3, GETDATE()), 
    3
);

INSERT INTO Articles (Title, Content, Date, CategoryId) 
VALUES (
    'Festivalul Internațional de Film', 
    'Cea de-a 25-a ediție a Festivalului Internațional de Film aduce pe marele ecran producții cinematografice din peste 40 de țări. Juriul internațional va decerna premii pentru cea mai bună regie, interpretare și scenariu. Festivalul include și masterclass-uri susținute de regizori de renume mondial.',
    DATEADD(day, -7, GETDATE()), 
    3
);

-- Articole despre Știință (CategoryId = 4)
INSERT INTO Articles (Title, Content, Date, CategoryId) 
VALUES (
    'Descoperire în fizica cuantică', 
    'Cercetători de la mai multe universități prestigioase au demonstrat un nou fenomen cuantic care ar putea revoluționa tehnologia calculatoarelor viitorului. Descoperirea deschide noi posibilități în domeniul computării cuantice și ar putea accelera dezvoltarea procesorilor cuantici mult mai puternici decât actualele.',
    DATEADD(day, -1, GETDATE()), 
    4
);

INSERT INTO Articles (Title, Content, Date, CategoryId) 
VALUES (
    'Misiune pe Marte: Noi descoperiri', 
    'Rover-ul Perseverance al NASA continuă să ne surprindă cu descoperiri fascinante de pe Planeta Roșie. Cele mai recente analize ale rocilor marțiene sugerează existența unor formațiuni geologice care ar fi putut susține viața microbiană în trecut. Aceste date sunt esențiale pentru înțelegerea istoriei planetei și planificarea misiunilor viitoare.',
    DATEADD(day, -4, GETDATE()), 
    4
);

INSERT INTO Articles (Title, Content, Date, CategoryId) 
VALUES (
    'Energie regenerabilă: Progrese în 2025', 
    'Sectorul energiei regenerabile înregistrează creșteri record. Panouri solare mai eficiente, turbine eoliene de nouă generație și sisteme de stocare a energiei revoluționează industria. Experții estimează că energia verde va depăși combustibilii fosili în următorii 10 ani, contribuind semnificativ la combaterea schimbărilor climatice.',
    DATEADD(day, -6, GETDATE()), 
    4
);

-- ================================================
-- VERIFICARE DATE INSERATE
-- ================================================

-- Verifică categoriile
SELECT * FROM Categories;

-- Verifică articolele cu categoriile aferente
SELECT 
    a.Id,
    a.Title AS 'Titlu Articol',
    c.Title AS 'Categorie',
    a.Date AS 'Data Publicării'
FROM Articles a
INNER JOIN Categories c ON a.CategoryId = c.Id
ORDER BY a.Date DESC;

-- Numără articolele pe categorii
SELECT 
    c.Title AS 'Categorie',
    COUNT(a.Id) AS 'Număr Articole'
FROM Categories c
LEFT JOIN Articles a ON c.Id = a.CategoryId
GROUP BY c.Title;
