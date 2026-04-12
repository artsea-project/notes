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

= Persony użytkowników

== Artysta 

#formatted_table(
  caption: [Profil persony - Artysta],
  columnsCount: 3,
  ref: "tab:requirements",
  // format: (auto, auto, auto),
  (
    [],
    [Cecha],
    [Opis],
    table.cell(rowspan: 4)[Profil],
    [Imię],
    [Otylia],
    [Wiek],
    [22],
    [Rola],
    [Studentka, początkująca artystka],
    [Osobowość],
    [Osoba o wysokiej wrażliwości na estetykę, mało techniczna],
  ),
)

#formatted_table(
  caption: [Szczegółowy opis profilu użytkownika: Artysta],
  columnsCount: 2,
  ref: "tab:requirements",
  // format: (auto, auto, auto),
  (
    [Cecha],
    [Opis],
    table.cell(rowspan: 3)[Potrzeby i cele],
    [Chce rozpocząć swoją karierę, stworzyć wizytókę dla swoich prac ],
    [Dąży do posiadania uporządkowanego portfolio w jednym miejscu, zamiast rozproszonego w różnych mediach],
    [Potrzebuje narzędzia, które nie wymaga technicznych umiejętności],
    formatted_table_sep,
    table.cell(rowspan: 2)[Problemy],
    [Nie posiada umiejętności potrzebnych do samodzielnego postawienia strony],
    [Koszty zatrudnienia web developera są zbyt wysokie],
    formatted_table_sep,
     table.cell(rowspan: 3)[Kontekst użycia systemu],
    [Używa systemu głównie na komputerze stacjonarnym (desktop) do zarządzania plikami i wgrywania zdjęć, ale czasami również na urządzeniu mobilnym do przeglądania i edycji treści],
    [Oczekuje prostego interfejsu opartego na mechanizmie "przeciągnij i upuść" (Drag-and-drop)],
    [Wykonanie podstawowej czynności, jak dodanie pracy do galerii, nie może mu zająć więcej niż 3 minuty],
  ),
)

== Odbiorca


#formatted_table(
  caption: [Profil persony - Odbiorca],
  columnsCount: 3,
  ref: "tab:requirements",
  // format: (auto, auto, auto),
  (
    [],
    [Cecha],
    [Opis],
    table.cell(rowspan: 4)[Profil],
    [Imię],
    [Maria],
    [Wiek],
    [30],
    [Rola],
    [Odbiorca sztuki, potencjalny klient],
    [Osobowość],
    [Osoba o wysokiej wrażliwości na estetykę, szukająca konretnych informacji],
  ),
)

#formatted_table(
  caption: [Szczegółowy opis profilu użytkownika: Odbiorca],
  columnsCount: 2,
  ref: "tab:requirements",
  // format: (auto, auto, auto),
  (
    [Cecha],
    [Opis],
    table.cell(rowspan: 3)[Potrzeby i cele],
    [Chce płynnie i wygodnie przeglądać galerie prac na telefonie],
    [Szuka szybkiego sposobu na nawiązanie kontaktu z artyst],
    [Potrzebuje możliwości filtrowania prac, aby szybko znaleźć to, co go interesuje],
    formatted_table_sep,
    table.cell(rowspan: 2)[Problemy],
    [Nieczytelny interfejs niedostosowany do małych ekranów],
    [Trudność w odnalezieniu danych kontaktowych do twórcy na rozproszonych portalach],
    formatted_table_sep,
     table.cell(rowspan: 2)[Kontekst użycia systemu],
    [Korzysta z systemu głównie na urządzeniach mobilnych (smartfon, tablet],
    [Kluczowa jest dla niego czytelność i szybkość ładowania interfejsu],
  ),
)

= Scenariusze użycia produktu

== 1. Scenariusz - budowa portfolio
- *Opis*: Otylia, początkująca artystka, chce stworzyć swoje pierwsze portfolio online, aby promować swoją twórczość i zdobyć klientów. Posiada wiele prac, które chce zaprezentować w uporządkowany sposób, ale brakuje jej jednego, profesjonalnego miejsca, gdzie mogłaby to zrobić.

  + Otylia wchodzi na stronę ArtSea i klika „Rejestracja”. Podaje e-mail, ustawia silne hasło i po chwili klika w link aktywacyjny, który przyszedł na jej pocztę.
  + Otylia wie, że jej prace dzielą się na obrazy olejne i grafiki cyfrowe. Przechodzi do sekcji „Kategorie” i dodaje nową kategorię: „Malarstwo olejowe”. Następnie dodaje kolejną kategorię: „Grafika cyfrowa”.
  + Przechodzi do sekcji „Moje Prace” i wgrywa zdjęcie swojej pracy. W formularzu wpisuje tytuł, wybiera nowo stworzoną kategorię i dodaje wymiary płótna. Klika „Zapisz”, a system potwierdza, że obraz jest już widoczny w jej portfolio.
  + Otylia powtarza ten proces dla wszystkich swoich prac, przypisując je do odpowiednich kategorii. Po wgraniu wszystkich prac, przechodzi do sekcji personalizacji. System wyświetla edytor strony głównej Bento Box z kafelkami zawierającymi pracami artysty. Otylia przeciąga, upuszcza kafelki oraz zmienia ich wielkość, aby ustawić je w preferowanej kolejności. Może również wybrać gamę kolorystyczną i typ czcionki z menu. Po zakończeniu klika „Zapisz układ”.

== 2. Scenariusz - budowa marki 
- *Opis*: Otylia chce zintegrować swoje działania w mediach społecznościowych z portfolio, aby zbudować spójną markę online. Chce, aby jej strona była miejscem, gdzie potencjalni klienci mogą łatwo znaleźć jej prace i dane kontaktowe.

  + Otylia loguje się do ArtSea i przechodzi do sekcji „Mój profil”.
  + W specjalnym edytorze Otylia wpisuje swój biogram. Wpisuje swoje imię i nazwisko. Wpisuje kilka zdań o swojej twórczości, inspiracjach i doświadczeniu, formatując tekst wedle potrzeb. Dodaje swoje zdjęcie profilowe.
  + Dodaje również linki do swoich profili na Instagramie i Facebooku, aby odwiedzający mogli łatwo znaleźć jej obecność w mediach społecznościowych.
  + Po zakończeniu edycji klika „Zapisz profil”. System potwierdza, że profil został zaktualizowany, a dane kontaktowe są teraz widoczne dla odwiedzających jej stronę.

== 3. Scenariusz - przeglądanie portfolio
- *Opis*: Maria, potencjalna klientka, chce przeglądać portfolio Otylii na swoim smartfonie, aby zobaczyć jej prace i ewentualnie skontaktować się z nią w sprawie zakupu.

  + Maria otwiera przeglądarkę na swoim smartfonie i wpisuje adres strony Otylii. Strona ładuje się szybko, a interfejs jest czytelny i dostosowany do urządzenia mobilnego.
  + Maria przegląda galerię prac Otylii, korzystając z funkcji filtrowania, aby wyświetlić tylko obrazy olejne. Klikając na miniaturkę pracy, może zobaczyć większe zdjęcie oraz szczegóły, takie jak tytuł, wymiary i opis.
  + Zainteresowana jedną z prac, Maria klika przycisk "O mnie", który przenosi ją do sekcji informacji o artyście. Znajduje tam biogram Otylii, jej zdjęcie profilowe oraz linki do mediów społecznościowych. Po zapoznaniu się z informacjami, Maria klika przycisk preferowanej platformy (np. Instagram), aby skontaktować się z Otylią.

= Backlog produktu

Do zarządzania wymaganiami i procesem wytwórczym wybrano narzędzie Jira. System został podzielony na Epiki, które grupują powiązane ze sobą przypadki użycia oraz wymagania techniczne.

== Struktura Backlogu

Zadania w backlogu zostały pogrupowane w cztery Epiki - główne obszary biznesowe:

+ System kont i autoryzacji - bezpieczeństwo i dostęp do panelu.

+ Zarządzanie treścią portfolio - główny moduł CMS do obsługi prac i kategorii.

+ Personalizacja - narzędzia do budowania unikalnej marki artysty (Bento Box, sekcja „O mnie”).

+ Interfejs odbiorcy i komunikacja  funkcje skierowane do klienta końcowego.

+ Wymagania jakościowe - zadania związane z optymalizacją i zapewnieniem jakości produktu.

#figure(
  image("jira-ss.png"),
  caption: [Zrzut ekranu z backlogu w Jira]
)

== Hierarchia i Priorytetyzacja

Wprowadzono następującą skalę priorytetów:

- Highest (MVP - Minimum Viable Product)
- High
- Low
- Lowest

Priorytety zadań zostały ustalone na podstawie ich wpływu na kluczowe funkcjonalności systemu oraz potrzeb użytkowników opisanych w pliku "project-organization-and-infrastructure.pdf". Schemat prioretyzacji MOSCoW został zmapowany na powyższą skalę, gdzie:
  - Must -> Highest
  - Should -> High
  - Could -> Low
  - Wont -> Lowest

= Kryteria akceptacji

== Kryteria akceptacji funkcjonalności

Kryteria akceptacji dla wybranych 4 funkcjonalności z backlogu:

#figure(
  image("about-me-section-acceptance-criteria.png"),
  caption: [Zrzut ekranu z backlogu w Jira - sekcja „O mnie”]
)

#figure(
  image("bento-box-acceptance-criteria.png"),
  caption: [Zrzut ekranu z backlogu w Jira - Bento Box]
)

#figure(
  image("adding-categories-acceptance-criteria.png"),
  caption: [Zrzut ekranu z backlogu w Jira - dodawanie kategorii]
)

#figure(
  image("editing-categories-acceptance-criteria.png"),
  caption: [Zrzut ekranu z backlogu w Jira - edycja kategorii]
)

== Ogólne kryteria akceptacji

Produkt uznaje się za gotowy do wdrożenia na środowisko produkcyjne, gdy spełnione są następujące warunki:

=== Kryteria Funkcjonalne:

- Wszystkie główne scenariusze biznesowe (Budowa portfolio, Budowa marki, Przeglądanie portfolio) są realizowane od początku do końca bez wystąpienia błędów krytycznych.

- Wszystkie zadania z backlogu produktu posiadające priorytet Highest zostały zaimplementowane, pomyślnie przetestowane i mają status "Done" w systemie Jira.

- System umożliwia pełną rejestrację, logowanie oraz zarządzanie treścią przez twórcę bez konieczności ingerencji administratora w bazę danych.

=== Kryteria Jakościowe i Wydajnościowe:

- Interfejs użytkownika jest w pełni responsywny (RWD) - dostosowuje się poprawnie do urządzeń mobilnych oraz ekranów desktopowych.

- Aplikacja jest w pełni kompatybilna i renderuje się poprawnie w najnowszych wersjach najpopularniejszych przeglądarek (Google Chrome, Safari, Mozilla Firefox, Microsoft Edge).

=== Kryteria Bezpieczeństwa:

- Aplikacja została wdrożona na środowisko produkcyjne i ruch sieciowy jest w całości szyfrowany za pomocą aktywnego certyfikatu SSL (wymuszone przekierowanie na protokół HTTPS).

- Wszystkie hasła użytkowników są bezpiecznie haszowane w bazie danych.

- Baza danych nie jest wystawiona na publiczny dostęp z zewnątrz (dostęp ograniczony wyłącznie dla zaufanych usług aplikacyjnych).

=== Kryteria Organizacyjne i Wdrożeniowe:

- Finalny kod źródłowy MVP został scalony do głównej gałęzi w repozytorium GitHub.

- Dokumentacja techniczna oraz infrastrukturalna w repozytorium notes została zaktualizowana i odpowiada stanowi faktycznemu wdrażanej aplikacji.

- Projekt pomyślnie przeszedł końcowe testy akceptacyjne przeprowadzone przez zespół deweloperski wcielający się w role modelowych użytkowników.
