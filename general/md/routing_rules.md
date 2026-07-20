# Specyfikacja Reguł Routingu (Routing Rules Specification) - ArtSea Portfolio CMS

W dokumentacji przedstawiono pełną specyfikację reguł routingu dla aplikacji **ArtSea Portfolio CMS** (Next.js App Router), opracowaną na podstawie kodu źródłowego, przypadków użycia (`przypadki_uzycia.md`), wymagań projektu (`SKILL.md`, notatek ze spotkań) oraz makiety **Figma** ([artsea-mine](https://www.figma.com/design/PJrVPgti28teIGaON3fHau/artsea-mine)).

---

## Mapowanie Ekranów z Figma na Ścieżki Aplikacji

| Nazwa Ramki w Figma | Ścieżka w Aplikacji (Route) | Przeznaczenie | Poziom Dostępności |
| :--- | :--- | :--- | :--- |
| `Home` | `/` lub `/[locale]` | Sekcja Hero, prezentacja wyróżnionych prac, wstęp do marki | Publiczny |
| `Portfolio` | `/portfolio` lub `/[locale]/portfolio` | Interaktywna galeria w układzie Bento Box i filtrowanie wg kategorii | Publiczny |
| `Praca` | `/work/[id]` lub `@modal/(.)work/[id]` | Widok szczegółów pracy oraz pop-up z galerią mediów | Publiczny |
| `O Mnie` | `/about` lub `/[locale]/about` | Biogram artysty (PL/EN), zdjęcia, odnośniki zewnętrzne i kontaktowe | Publiczny |
| `Admin Dashboard - Przeglad` | `/admin` lub `/admin/dashboard` | Główny pulpit administracyjny i podsumowanie statystyk | Admin (Chroniony) |
| `Admin Dashboard - Prace` | `/admin/works`<br>`/admin/works/new`<br>`/admin/works/[id]/edit` | Lista, dodawanie oraz edycja dzieł | Admin (Chroniony) |
| `Admin Dashboard - Uklad` | `/admin/layout` | Edytor układu Bento Box (osobno dla widoku Desktop i Mobile) | Admin (Chroniony) |
| `Admin Dashboard - Profil` | `/admin/profile` | Ustawienia profilu, edycja biogramu (PL/EN) oraz modala z linkami | Admin (Chroniony) |
| `Admin Dashboard - Kategorie` | `/admin/categories` | Zarządzanie kategoriami prac (nazwy PL/EN) | Admin (Chroniony) |

---

## Szczegółowe Reguły Routingu

### 1. Ścieżki Publiczne (`(public)`)

Dostępne dla każdego odwiedzającego bez konieczności logowania.

* **`/` (Strona Główna)**
  * **Ramka Figma**: `Home`
  * **Przypadek użycia**: **PU1** (Przeglądanie galerii)
  * **Reguła**: Renderuje sekcję powitalną oraz siatkę z wyróżnionymi pracami (`isFeatured: true`).

* **`/portfolio` (Galeria / Bento Box)**
  * **Ramka Figma**: `Portfolio`
  * **Przypadek użycia**: **PU1**
  * **Reguła**: Wyświetla pełny układ Bento Grid skonfigurowany w tabeli `siteSettings.layoutBentoBox`. Obsługuje filtrowanie po kategorii przez parametry URL (np. `/portfolio?category=[categoryId]`).

* **`/work/[id]` (Szczegóły Pracy)**
  * **Ramka Figma**: `Praca`
  * **Przypadek użycia**: **PU1**
  * **Reguła**: Wyświetla szczegółowe dane pracy (tytuł, rok wykonania, wymiary, technikę/tagi, karuzelę mediów).
  *  **Reguła Intercepting Route**: Przy nawigacji z poziomu `/portfolio` otwiera się jako **pop-up modalny na stronie** (`@modal/(.)work/[id]`), nie niszcząc stanu tła. Przy otwarciu z bezpośredniego linku/odświeżenia strony renderuje się jako pełna osobna strona (`/work/[id]`).

* **`/about` (O Mnie i Kontakt Media)**
  * **Ramka Figma**: `O Mnie`
  * **Przypadki użycia**: **PU2** (Kontakt przez linki media / mailto), **PU11**
  * **Reguła**: Renderuje zdjęcie profilowe, biogramy w dwóch językach (`bioPln` / `bioEng`), odnośniki społecznościowe oraz bezpośredni kontakt e-mail `mailto:` (tabela `links`).

---

### 2. Ścieżki Panelu Admina (`(admin)` / `/admin`)

Ścieżki chronione, dostępne **wyłącznie** po zarejestrowaniu sesji administratora (`BetterAuth`).

* **`/admin` (Przegląd / Overview)**
  * **Ramka Figma**: `Admin Dashboard - Przeglad`
  * **Reguła**: Pulpit z licznikami prac, aktywnymi kategoriami, skrótami do szybkiej edycji.

* **`/admin/works` (Zarządzanie Pracami)**
  * **Ramka Figma**: `Admin Dashboard - Prace` (Widok listy)
  * **Przypadki użycia**: **PU5**, **PU6**, **PU8**
  * **Reguła**: Tabela/siatka ze wszystkimi pracami z przełącznikami widoczności (`isVisible`), wyróżnienia (`isFeatured`), przyciskami edycji i usuwania.

* **`/admin/works/new` (Dodawanie Pracy)**
  * **Ramka Figma**: `Admin Dashboard - Prace` (Formularz tworzenia)
  * **Przypadki użycia**: **PU5**, **PU7**
  * **Reguła**: Formularz wgrywania mediów (PNG, JPG, GIF, MP4), wprowadzania tytułów i opisów (PL/EN), wymiarów, roku wykonania, wyboru kategorii oraz wymiarów siatki (`gridWidth`, `gridHeight`).

* **`/admin/works/[id]/edit` (Edycja Pracy)**
  * **Ramka Figma**: `Admin Dashboard - Prace` (Formularz edycji)
  * **Przypadki użycia**: **PU6**, **PU7**
  * **Reguła**: Wypełnia formularz istniejącymi danymi pracy do modyfikacji.

* **`/admin/layout` (Personalizacja Układu - Edytor Bento Box)**
  * **Ramka Figma**: `Admin Dashboard - Uklad` oraz `Admin Dashboard - Uklad - mobile`
  * **Przypadek użycia**: **PU12**
  * **Reguła**: Interaktywny edytor drag-and-drop pozwalający na skonfigurowanie dwóch niezależnych układów JSON: **Desktop** (4–6 kolumn) oraz **Mobile** (1–2 kolumny). Zmiany zapisują się w `siteSettings.layoutBentoBox`.

* **`/admin/profile` (Profil i Odnośniki Media)**
  * **Ramka Figma**: `Admin Dashboard - Profil` i `Admin Dashboard - Dodaj link`
  * **Przypadki użycia**: **PU11**
  * **Reguła**: Edytor tekstu biogramu (PL/EN) oraz menedżer linków społecznościowych/kontaktowych (`instagram`, `behance`, `email` itp.).

* **`/admin/categories` (Kategorie Prac)**
  * **Ramka Figma**: `Admin Dashboard - Kategorie`
  * **Przypadki użycia**: **PU9**, **PU10**
  * **Reguła**: Menedżer dwujęzycznych kategorii (`namePln`, `nameEng`). Blokuje usunięcie kategorii zawierającej aktywne prace bez uprzedniego przypisania ich do innej kategorii.

---

### 3. Ścieżki Autoryzacji (`(auth)`)

* **`/login`**: Formularz logowania BetterAuth.
* **`/register`**: Pierwszorazowa rejestracja konta administratora (PU4).
* **Reguła**: Zalogowany administrator próbujący wejść na `/login` lub `/register` zostaje automatycznie przekierowany do `/admin`.

---

### 4. Kontrola Dostępności i Middleware

```ts
// Logika Next.js Middleware
export function middleware(req: NextRequest) {
  const isAuth = checkBetterAuthSession(req);
  const path = req.nextUrl.pathname;

  // 1. Ochrona ścieżek admina
  if (path.startsWith('/admin') && !isAuth) {
    return NextResponse.redirect(new URL('/login?callbackUrl=' + encodeURIComponent(path), req.url));
  }

  // 2. Przekierowanie zalogowanego admina ze stron auth
  if ((path === '/login' || path === '/register') && isAuth) {
    return NextResponse.redirect(new URL('/admin', req.url));
  }

  return NextResponse.next();
}
```

---

### 5. Wielojęzyczność (i18n - PL / EN)

* **Reguła**: Obsługa wyboru języka (**PU3**) w wersjach PL (Polski) oraz EN (Angielski).
* **Ścieżki**: Prefiksowanie URL (`/[locale]/...`, np. `/pl/portfolio`, `/en/portfolio`) lub obsługa nagłówkiem/ciasteczkiem.
* **Reguła fallbacku**: Jeśli treść własna artysty (np. opis pracy) nie posiada tłumaczenia na język angielski, aplikacja wyświetla wersję polską bez wywoływania błędów.

---

### 6. Endpointy API (`/api/*`)

* **`/api/auth/[...all]`**: Endpointy BetterAuth.
* **`/api/media/upload`**: Kompresja i zapis mediów w Supabase storage.
* **`/api/site-settings`**: Odczyt i zapis konfiguracji siatki Bento i motywu.

---

## Zalecana Struktura Katalogów w Next.js App Router

```text
artsea-webapp/app/
├── [locale]/                 # Opcjonalny wrapper i18n
│   ├── (public)/             # Układ i strony publiczne
│   │   ├── page.tsx          # Strona Główna
│   │   ├── portfolio/
│   │   │   └── page.tsx      # Galeria Bento Box
│   │   ├── work/
│   │   │   ├── [id]/
│   │   │   │   └── page.tsx  # Samodzielna strona pracy
│   │   │   └── @modal/       # Route modalny (intercepting)
│   │   │       └── (.)[id]/
│   │   │           └── page.tsx # Pop-up podglądu pracy
│   │   └── about/
│   │       └── page.tsx      # O Mnie (Biogram i Linki Media/Email)
│   │
│   ├── (auth)/               # Logowanie i rejestracja
│   │   ├── login/page.tsx
│   │   └── register/page.tsx
│   │
│   └── admin/                # Chroniony Panel CMS
│       ├── page.tsx          # Przegląd
│       ├── works/
│       │   ├── page.tsx      # Lista Prac
│       │   ├── new/page.tsx  # Dodawanie Pracy
│       │   └── [id]/edit/page.tsx # Edycja Pracy
│       ├── layout/
│       │   └── page.tsx      # Edytor Układu Bento Box
│       ├── profile/
│       │   └── page.tsx      # Edytor Profilu i Linków Media
│       └── categories/
│           └── page.tsx      # Zarządzanie Kategoriami
│
└── api/
    ├── auth/[...all]/route.ts
    ├── media/upload/route.ts
    └── site-settings/route.ts
```
