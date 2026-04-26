#set text(lang: "pl")

#import "template.typ": *

#show: paper => jacow(
  title: [ArtSea],
  subtitle: [Scrum: Backlog sprintu],
  authors: (
    (name: "Benjamin Jurewicz", studentID: "198326"),
    (name: "Marta Kociszewska", studentID: "198143"),
    (name: "Lidia Zawrzykraj", studentID: "198257"),
    (name: "Piotr Kierznowski", studentID: "197652"),
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
- *ArtSea* - system zarządzania portfolio artysty
- *Ogólna koncepcja* - system planowany jest jako platforma, umożliwiająca artystom błyskawiczne generowanie własnych stron internetowych z ich twórczością

== Adresowany problem i obszar zastosowania
- *Problemy*:
  - Trudność techniczna: Artyści nie potrafią samodzielnie postawić (stworzyć) strony
  - Brak spójności: Portfolio w mediach społecznościowych są rozproszone i niespójne
  - Wysokie koszty: Zatrudnienie dewelopera jest zbyt drogie dla początkujących twórców
- *Obszar zastosowania*:
  - Sektor kreatywny, promocja sztuki w Internecie oraz digitalizacja dorobku artystycznego.

== Rynek i organizacja
- *Skala działalności:*
  - Projekt adresowany jest do twórców na poziomie krajowym i europejskim.
- *Rynek:*
  - Artyści niezależni, studenci uczelni artystycznych oraz małe galerie sztuki.

= Oszacowanie rozmiaru backlogu produktu

W celu oszacowania pracochłonności zadań w backlogu produktu, zespół przeprowadził sesję Planning Poker. Wykorzystano skalę opartą na ciągu Fibonacciego (1, 2, 3, 5, 8, 13). Proces ten pozwolił na wspólną dyskusję nad złożonością każdego z zadań, co zminimalizowało ryzyko błędnych estymacji wynikających z indywidualnego postrzegania trudności. Estymacja skupiła się na elementach wybranych do realizacji w pierwszym sprincie, co pozwoliło na precyzyjne określenie zakresu prac.

#figure(
  image("assets/planning-poker.png", width: 75%),
  caption: [Przebieg sesji Planning Poker],
)

= Założenia i dobór zakresu sprintu

Pierwszy sprint został zaplanowany jako iteracja dwutygodniowa. Przyjęto następujące założenia dotyczące pojemności zespołu:
- Zespół składa się z 3 osób bezpośrednio zaangażowanych w zadania techniczne i projektowe (Benjamin, Lidia, Marta).
- Przyjęto rezerwę czasową (ok. 20%) na spotkania statusowe, proces Code Review oraz dokumentację bieżącą.
- Średnia prędkość (velocity) zespołu została oszacowana na około 40 Story Points.

Dobór zakresu sprintu podyktowany był koniecznością stworzenia fundamentów systemu. Wybrano zadania z obszarów:
- *Infrastruktura:* Konfiguracja środowiska (Docker, PostgreSQL, DrizzleORM) jest niezbędna do rozpoczęcia jakichkolwiek prac programistycznych.
- *Bezpieczeństwo:* Autoryzacja stanowi fundament dostępu do panelu artysty.
- *Design i UX:* Opracowanie Design Systemu oraz makiet Dashboardu i Bento Box (kluczowej funkcji systemu) pozwoli na równoległe prowadzenie prac frontendowych w kolejnych iteracjach.
- *Architektura danych:* Projektowanie modeli bazy danych (artpiece, category i inne)

= Cel sprintu

Uruchomienie infrastruktury technicznej (Docker, PostgreSQL, DrizzleORM), wybór i implementacja mechanizmu autoryzacji oraz opracowanie spójnego Design Systemu i makiet kluczowych funkcjonalności (Dashboard, Bento Box).

= Backlog sprintu

Poniższa tabela przedstawia szczegółowy backlog pierwszego sprintu. Przyjęto przelicznik 1 Story Point (SP) = 1.5 godziny pracy.

#formatted_table(
  caption: [Backlog Sprintu 1],
  columnsCount: 6,
  (
    [Epic],
    [ID],
    [Nazwa zadania],
    [Osoba],
    [SP],
    [Czas (h)],
    [Infrastruktura],
    [KAN-30],
    [Konfiguracja Docker + PostgreSQL],
    [Benjamin],
    [2],
    [3],
    [Infrastruktura],
    [KAN-29],
    [Inicjalizacja DrizzleORM],
    [Benjamin],
    [2],
    [3],
    [Infrastruktura],
    [KAN-31],
    [Standardy kodu (ESLint, Prettier)],
    [Marta],
    [1],
    [1.5],
    [Infrastruktura],
    [KAN-35],
    [Konfiguracja shadcn/ui + Tailwind],
    [Lidia],
    [2],
    [3],
    [Infrastruktura],
    [KAN-32],
    [Dokumentacja architektury danych],
    [Marta],
    [2],
    [3],
    formatted_table_sep,
    [Autoryzacja],
    [KAN-6],
    [Analiza podejścia do autoryzacji],
    [Benjamin],
    [3],
    [4.5],
    [Autoryzacja],
    [KAN-7],
    [Logowanie i wylogowywanie (MVP)],
    [Benjamin],
    [5],
    [7.5],
    [Autoryzacja],
    [KAN-36],
    [Projekt bazy danych (modele)],
    [Marta],
    [5],
    [7.5],
    formatted_table_sep,
    [Design],
    [KAN-37],
    [Design System w Figmie],
    [Lidia],
    [5],
    [7.5],
    [Design],
    [KAN-33],
    [Projekt Hi-Fi Dashboardu],
    [Lidia],
    [5],
    [7.5],
    [Design],
    [KAN-34],
    [Makieta galerii Bento Box],
    [Lidia],
    [8],
    [12],
    formatted_table_sep,
    [*Suma*],
    [],
    [],
    [],
    [*40*],
    [*60*],
  ),
)

= Kryteria akceptacji

Wybrane przykłady kryteriów akceptacji:

== System autoryzacji (KAN-7)
#figure(
  image("assets/KAN-7-Acceptance-Criteria.png", width: 75%),
  caption: [Kryteria akceptacji dla zadania KAN-7 (System autoryzacji)],
)

== Projekt bazy danych (KAN-36)
#figure(
  image("assets/KAN-36-Acceptance-Criteria.png", width: 75%),
  caption: [Kryteria akceptacji dla zadania KAN-36 (Projekt bazy danych)],
)

== Makieta Bento Box (KAN-34)
#figure(
  image("assets/KAN-34-Acceptance-Criteria.png", width: 75%),
  caption: [Kryteria akceptacji dla zadania KAN-34 (Makieta Bento Box)],
)

= Definicja ukończenia

Element backlogu sprintu uznaje się za ukończony (Definition of Done), gdy:

- *Kod i Implementacja:*
  - Kod jest zgodny ze standardami (Lint/Prettier).
  - Infrastruktura (Docker) uruchamia się poprawnie jednym poleceniem.
  - Modele DrizzleORM odzwierciedlają projekt bazy danych.

- *Testowanie i Jakość:*
  - Funkcjonalność została przetestowana manualnie na środowisku lokalnym.
  - Zmiany przeszły pomyślnie Code Review (akceptacja przez innego członka zespołu).

- *Projektowanie (UI/UX):*
  - Projekty w Figmie są dostępne dla całego zespołu i posiadają zdefiniowane komponenty (Design System).

- *Dokumentacja:*
  - Zaktualizowano odpowiednie pliki w repozytorium `notes`.
  - Status zadania w Jira został zmieniony na "Done".

