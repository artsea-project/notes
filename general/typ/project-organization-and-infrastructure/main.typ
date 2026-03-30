#set text(lang: "pl")

#import "template.typ": *

#show: paper => jacow(
  title: [ArtSea],
  subtitle: [organizacja i infrastruktura projektu],
  authors: (
    (name: "Benjamin Jurewicz", studentID: "198326"),
    (name: "Marta Kociszewska", studentID: "198143"),
    (name: "Lidia Zawrzykraj", studentID: "198257"),
  ),

  // Jesli chcesz custom date to odkomentuj, podstawowo jest dzisiejsza
  // date: datetime(year: 2026, month: 12, day: 12),

  // Paper abstract
  // abstract: [ To jest opcjonalne i jak nie chcesz tego to po prostu zakomentuj ],

  paper,
)

// Repozytoria
#let notes = link(" https://github.com/artsea-project/notes ")[_notes_]
#let webapp = link("https://github.com/artsea-project/artsea-webapp")[_webapp_]
#let thesis = link("https://github.com/artsea-project/thesis")[_thesis_]

// Other useful packages
//#import "@preview/physica:0.9.3"
#import "@preview/unify:0.6.0": num, numrange, qty, qtyrange, unit

= Opis projektu i produktu
== Nazwa i ogólna koncepcja
- *ArtSea* - system zarządzania protfolio artysty
- *Ogólna koncepcja* - system planowany jest jako platforma, umożliwiająca artystom błyskawiczne generowanie własnych stron internetowych z ich twórczością

== Adresowany problem i obszar zastosowania
- *Problemy*:
  - Trudność techniczna: Artyści nie potrafią samodzielnie postawić (stworzyć) strony
  - Brak spójności: Portfolia w mediach społecznościowych są rozproszone i niespójne
  - Wysokie koszty: Zatrudnienie dewelopera jest zbyt drogie dla początkujących twórców
- *Obszar zastosowania*:
  - Sektor kreatywny, promocja sztuki w Internecie oraz digitalizacja dorobku artystycznego.

== Rynek i organizacja
- *Skala działalności:*
  - Projekt adresowany jest do twórców na poziomie krajowym i europejskim.
- *Rynek:*
  - Artyści niezależni, studenci uczelni artystycznych oraz małe galerie sztuki.

== Interesariusze

- Twórcy, Artyści,
- Odbirocy sztuki,
- Administratorzy systemu,
- Organy regulacyjne (RODO)


== Wymagania funkcjonalne
#formatted_table(
  caption: [Wymagania funkcjonalne systemu],
  columnsCount: 3,
  ref: "tab:requirements",
  // format: (auto, auto, auto),
  (
    [Użytkownik],
    [Funkcja],
    [Priorytet],
    table.cell(rowspan: 6)[Artysta],
    [Rejestracja konta], // to disscuss
    [MUST],
    [Dodawanie/edytowanie/usuwanie grafik, zdjęć, opisów, kategorii prac],
    [MUST],
    [Dodanie/edytowianie informacji o sobie],
    [MUST],
    [Moliwość zmieniania layoutu strony głównej (_bento box_)],
    [SHOULD],
    [Możliwość dodawania gifów],
    [SHOULD],
    [Integracja z mediami społecznościowymi],
    [COULD],
    formatted_table_sep,
    table.cell(rowspan: 3)[Odbiorcy],
    [Przeglądanie galerii zdjęć],
    [MUST],
    [Możliwość kontaktu z artystą (np. formularz kontaktowy)],
    [MUST],
    [Wybór języka interfejsu],
    [SHOULD],
    formatted_table_sep,
    // To discuss - advised to remove administrator
    // table.cell(rowspan: 2)[Administrator],
    // [Panel zarządzania użytkownikami],
    // [MUST],
    // [Moderacja treści],
    // [MUST],
  ),
)

== Wymagania jakościowe

=== Wydajność:
- Czas ładowania całej strony przy łączu _LTE_ nie może przekraczać 2 sekund (np. generowanie miniatur pełnych zdjęć). (COULD)
=== Niezawodność:
- System musi poprawnie obsłużyć proces zapisu wielu formatów plików graficznych. (MUST)
- System musi gwarantować, że żadne dane wprowadzone przez użytkownika nie zostaną stracone w przypadku utraty sesji. (COULD)
// === Dostępność
//   - Usługa musi być dostępna dla użytkowników (uptime) na poziomie 99,5% w skali miesiąca, z wyłączeniem planowanych okien serwisowych. (MUST) - to discuss
=== Ochrona
- Strona musi być zabezpieczona aktywnym certyfikatem SSL (protokół HTTPS). (MUST)
=== Bezpieczeństwo
- Hasła użytkowników muszą być przechowywane w bazie danych w formie zahaszowanej przy użyciu obecnie bezpiecznego algorytmu. (MUST)
=== Przenośność
- System musi poprawnie wyświetlać portfolio na trzech najpopularniejszych przeglądarkach (Chrome, Safari, Firefox) oraz na systemach Android i iOS. (MUST)
=== Konfigurowalność
- Artysta musi mieć możliwość zmiany parametrów wizualnych strony (np. kolorystyka, font, układ siatki). (SHOULD)

== Ograniczenia

- Limit rozmiaru plików,
- Zgodność z RODO,

== Główne etapy projektu

+ Analiza i specyfikacja wymagań.
+ Projektowanie UI/UX i architektury systemu.
+ Implementacja projektu (MVP).
+ Ewaluacja działania na różnych platformach.
+ Wdrożenie.
+ Przygotowanie tutoriali dla artystów.

= Interesariusze i użytkownicy

== Interesariusze systemu

#formatted_table(
  caption: [Interesariusze systemu],
  columnsCount: 2,
  (
    [Interesariusz],
    [Punkt widzenia],
    [Artysta (Twórca)],
    [Chce szybko i tanio pokazać swoje prace; boi się trudnej obsługi ],
    [Odbiorca (Klient) ],
    [Chce płynnie przeglądać galerię na telefonie; szuka kontaktu do artysty ],
    // [Administrator platformy],
    // [Musi mieć możliwość kontrolowania treści ],
  ),
)

== Kontekst systemu

#formatted_table(
  caption: [Specyfikacja użytkowników],
  columnsCount: 3,
  (
    [Użytkownik],
    [Specyfika],
    [Opis specyfiki],
    table.cell(rowspan: 3)[Artysta],
    [Profil],
    [Osoba wrażliwa estetycznie, często nietechniczna],
    [Warunki, w których używa systemu],
    [Głównie desktop (do wygrywania zdjęć), rzadziej mobilnie],
    [Wymagania względem interfejsu użytkownika],
    [Drag-and-drop, interfejs prosty w obsłudze],
    formatted_table_sep,
    table.cell(rowspan: 3)[Odbiorca],
    [Profil],
    [Potencjalny kupiec lub fan sztuki],
    [Warunki, w których używa systemu],
    [Głównie urządzenia mobilne],
    [Wymagania względem interfejsu użytkownika],
    [Szybkość ładowania zdjęć, czytelność],
  ),
)

= Zespół

System jest rozwijany przez zespół pracujący w trybie hybrydowym (częściowo podczas spotkań, częściowo zdalnie).

#formatted_table(
  caption: [Zespół],
  columnsCount: 4,
  (
    [Osoba],
    [Umiejętności],
    [Odpowiedzialność],
    [Kontakt],
    [Marta Kociszewska],
    [Inyżynieria wymagań, Testowanie],
    [Specyfikacja wymagań, QA],
    [#link("mailto:martakociszewska04@gmail.com", "martakociszewska04@gmail.com")],
    [Benjamin Jurewicz],
    [Projektowanie Systemu],
    [Backend, Repozytoria],
    [#link("mailto:benjamin.jurewicz204@gmail.com", "benjamin.jurewicz204@gmail.com")],
    [Lidia Zawrzykraj],
    [Figma, Prototypowanie, IA, RWD],
    [UX/UI],
    [#link("mailto:lidia.zawrzykraj@gmail.com", "lidia.zawrzykraj@gmail.com")],
  ),
)


= Komunikacja w zespole i z interesariuszami

*Organizacja spotkań:*
- Spotkania wewnętrzne (zespół): Krótkie spotkania statusowe odbywają się dwa razy w tygodniu (poniedziałek, piątek) na platformie Discord w celu omówienia postępów i blokad.
- Spotkania z interesariuszami: Stałe spotkania statusowe odbywają się co dwa tygodnie w środy. Miejscem spotkań jest gabinet promotorki lub MS Teams (zależnie od ustaleń).
- Komunikacja zdalna: Do bieżącej, szybkiej wymiany informacji między członkami zespołu służy kanał na Discordzie. Ważne decyzje projektowe są dokumentowane w repozytorium #notes.
- Komunikacja z otoczeniem: Oficjalna korespondencja z opiekunem projektu (promotorką) odbywa się drogą mailową w celu potwierdzania terminów i przesyłania gotowych partii materiałów.

= Współdzielenie dokumentów i kodu

== Sposób wymiany i adresy repozytoriów:
Wszystkie zasoby projektu znajdują się w ramach jednej organizacji na platformie GitHub. Dostęp do edycji mają wyłącznie członkowie zespołu.

=== Struktura repozytoriów:
- #webapp: Kod źródłowy aplikacji.
- #notes: Notatki ze spotkań, raporty, analizy wymagań i dokumentacja techniczna.
- #thesis: Pliki źródłowe pracy dyplomowej.

=== Odpowiedzialność i porządek:

- Konfiguracja i utrzymanie repozytorium: Benjamin Jurewicz– dba o strukturę branchy i uprawnienia.

- Porządek w dokumentacji: Marta Kociszewska – dba o aktualność plików w #notes i #thesis.

- Schemat nazewnictwa plików:

=== Wersjonowanie:

- Kod i praca dyplomowa: Automatycznie poprzez mechanizm git w odpowiednich repozytoriach.

- Dokumentacja pomocnicza: Wersjonowanie automatyczne wewnątrz GitHuba (historia zmian pliku).

= Narzędzia

#formatted_table(
  caption: [Narzędzia],
  columnsCount: 3,
  (
    [Obszar],
    [Narzędzie],
    [Zastosowanie],
    [Komunikacja],
    [Discord, MS Teams],
    [Spotkania zespołu],
    [Współdzielenie kodu],
    [GitHub (repo: #webapp)],
    [Przechowywanie i wersjonowanie kodu źródłowego],
    [Dokumentacja i notatki],
    [GitHub (repo: #notes, #thesis)],
    [Przechowywanie i wersjonowanie notatek oraz treści pracy],
    [Modelowanie],
    [Figma],
    [Tworzenie makiet systemu],
    [Testy],
    [],
    [],
  ),
)
