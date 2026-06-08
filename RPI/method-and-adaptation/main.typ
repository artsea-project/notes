#set text(lang: "pl")

#import "template.typ": *

#show: paper => jacow(
  title: [ArtSea],
  subtitle: [Dobór i adaptacja metodyki],
  authors: (
    (name: "Benjamin Jurewicz", studentID: "198326"),
    (name: "Marta Kociszewska", studentID: "198143"),
    (name: "Lidia Zawrzykraj", studentID: "198257"),
    (name: "Piotr Kierznowski", studentID: "197652"),
  ),

  paper,
)

// Repozytoria
#let notes = link(" https://github.com/artsea-project/notes ")[#text(size: 1.3em)[_notes_]]
#let webapp = link("https://github.com/artsea-project/artsea-webapp")[#text(size: 1.3em)[_webapp_]]
#let thesis = link("https://github.com/artsea-project/thesis")[#text(size: 1.3em)[_thesis_]]

#import "@preview/unify:0.6.0": num, numrange, qty, qtyrange, unit

= O projekcie i produkcie

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

= Ocena według modelu uproszczonego

  Model uproszczony Boehma i Turnera porównuje projekt na pięciu osiach: rozmiar, krytyczność, dynamika, osoby i kultura. Im projekt jest mniejszy, mniej krytyczny, bardziej zmienny i oparty na współpracy doświadczonego zespołu, tym silniej wskazuje na zastosowanie metodyk zwinnych. Im większy, bardziej krytyczny, stabilny i proceduralny, tym bardziej pasuje do metodyk zdyscyplinowanych.

  *Ocena projektu ArtSea według pięciu kryteriów modelu uproszczonego:*

  - *Rozmiar*:
    - *Ocena ArtSea:* 3 osoby.
    - *Lepsze dopasowanie:* metodyki zwinne.
    - *Uzasadnienie:* zespół jest bardzo mały, a komunikacja między osobami ma niewielką liczbę ścieżek. Taki rozmiar sprzyja bezpośrednim uzgodnieniom, szybkiemu planowaniu sprintów i lekkiej dokumentacji. Metodyki klasyczne byłyby dla takiego zespołu nadmiarowe.
  - *Krytyczność*:
    - *Ocena ArtSea:* niska do umiarkowanej.
    - *Lepsze dopasowanie:* metodyki zwinne z elementami dyscypliny.
    - *Uzasadnienie:* błędy w aplikacji mogą powodować utratę danych portfolio, problemy wizerunkowe artysty albo naruszenia bezpieczeństwa konta, ale system nie jest produktem safety-critical ani mission-critical. Wymaga to praktyk jakościowych i bezpieczeństwa, lecz nie pełnej metodyki klasycznej.
  - *Dynamika*:
    - *Ocena ArtSea:* umiarkowana do wysokiej.
    - *Lepsze dopasowanie:* metodyki zwinne.
    - *Uzasadnienie:* produkt kierowany jest do użytkowników nietechnicznych i wrażliwych estetycznie. Funkcje takie jak Bento Box, personalizacja, układ galerii czy edytor treści wymagają iteracyjnej walidacji z użytkownikami i mogą zmieniać się po testach UX.
  - *Osoby*:
    - *Ocena ArtSea:* mały zespół o mieszanych kompetencjach.
    - *Lepsze dopasowanie:* metodyki zwinne, ale z ograniczeniami.
    - *Uzasadnienie:* zespół jest niewielki, a kompetencje jego członków wzajemnie się przenikają i nie są sztywno rozdzielone na osobne role. Sprzyja to zwinnej współpracy i szybkiemu reagowaniu na zmiany, ale nie ma podstaw, aby uznać, że cały zespół spełnia wysokie wymagania poziomów 2--3 z modelu Boehma i Turnera, dlatego konieczne są jawne checklisty, code review i dokumentowanie decyzji.
  - *Kultura*:
    - *Ocena ArtSea:* raczej zwinna, ale uporządkowana.
    - *Lepsze dopasowanie:* metodyki zwinne z adaptacją.
    - *Uzasadnienie:* zespół pracuje iteracyjnie i korzysta z praktyk zwinnych, ale jednocześnie potrzebuje jasnych zasad jakości i organizacji pracy.

#figure(
  image("chart/artsea-methodology-radar.png", width: 78%),
  caption: [Diagram radarowy dla modelu uproszczonego],
)

Wniosek z modelu uproszczonego jest jednoznaczny: ArtSea bardziej pasuje do metodyki zwinnej niż klasycznej. Najsilniej przemawiają za tym mały zespół, charakter produktu cyfrowego, potrzeba częstej walidacji UX oraz możliwość dostarczania przyrostów. Nie oznacza to jednak czystego, nieformalnego procesu. W obszarach bezpieczeństwa, jakości, dokumentacji i kompetencji zespołu potrzebne są dodatkowe praktyki dyscyplinujące.

= Ocena według zaadaptowanego modelu pełnego

== Zastosowanie

=== Główne cele
Celem projektu jest zbudowanie użytecznego MVP platformy portfolio, które pozwoli artystom szybko opublikować spójną stronę i sprawdzić wartość rozwiązania dla grupy docelowej. Istotne są szybkość dostarczenia wartości, prostota użycia, estetyka i możliwość reagowania na informację zwrotną od użytkowników. Tak sformułowany cel jest bliższy metodykom zwinnym niż klasycznym.

Elementy wskazujące na zwinność:
- możliwość dzielenia produktu na przyrosty: autoryzacja, CRUD prac, kategorie, galeria, Bento Box, sekcja „O mnie”, języki i kontakt,
- potrzeba weryfikacji z użytkownikami, czy interfejs jest rzeczywiście prosty i czy dodanie pracy zajmuje mniej niż 3 minuty,
- ryzyko błędnych założeń UX, które najlepiej redukować przez prototypy i iteracyjne testy.

Elementem częściowo niepasującym do czystej zwinności są wymagania jakościowe i bezpieczeństwa. Haszowanie haseł, HTTPS, ochrona bazy danych, wydajność obrazów i RODO nie mogą być odkładane wyłącznie na późniejszą refaktoryzację, ponieważ wpływają na architekturę i wiarygodność produktu.

=== Środowisko
Środowisko projektu jest umiarkowanie zmienne. Rynek narzędzi portfolio i kreatorów stron jest konkurencyjny, a oczekiwania użytkowników dotyczące estetyki, szybkości i obsługi mobilnej mogą zmieniać się po kontakcie z prototypem. Jednocześnie podstawowy problem biznesowy jest stabilny: nietechniczny artysta potrzebuje prostego narzędzia do stworzenia portfolio.

Ocena środowiska wskazuje na metodykę zwinną z planowanymi punktami stabilizacji. Zwinność jest potrzebna w zakresie UX, układu strony, priorytetów MVP i sposobu prezentacji prac. Bardziej planowe podejście jest potrzebne w zakresie architektury danych, autoryzacji, storage'u plików i wymagań jakościowych.

#pagebreak()
== Zarządzanie

=== Komunikacja
Zespół jest mały i pracuje hybrydowo. Spotkania statusowe odbywają się dwa razy w tygodniu na Discordzie, spotkania z interesariuszami co dwa tygodnie, komunikację mailową z opiekunem, dokumentowanie ważnych decyzji w repozytorium #notes oraz zarządzanie zadaniami w Jira. To środowisko dobrze pasuje do metodyk zwinnych, ponieważ umożliwia częstą komunikację i szybkie uzgadnianie priorytetów.

Jednocześnie praca częściowo zdalna i studencki charakter zespołu zwiększają ryzyko utraty wiedzy niejawnej. Retrospektywa pierwszego sprintu wskazała problemy z aktualnością statusów w Jira, odkładaniem decyzji projektowych w rozmowach na Discordzie oraz możliwym wąskim gardłem w code review i testach. Dlatego komunikacja nie może opierać się wyłącznie na wiedzy rozproszonej w zespole. Potrzebne jest utrzymanie lekkiej, ale konsekwentnej dokumentacji.

W tym kryterium projekt pasuje do metodyk zwinnych, ale wymaga rozszerzenia o jawne artefakty komunikacyjne: notatki decyzyjne, aktualne statusy zadań, kryteria akceptacji, Definition of Done i dokumentację techniczną dla ważnych decyzji.

== Techniczne

=== Wymagania
Wymagania funkcjonalne ArtSea są dobrze podzielne na historyjki i zadania. Backlog produktu obejmuje między innymi system kont, zarządzanie treścią portfolio, personalizację, publiczną galerię i wymagania jakościowe. Priorytety zostały opisane przez mapowanie MOSCoW na priorytety w Jira, a wybrane funkcje mają kryteria akceptacji.

To pasuje do podejścia zwinnego: wymagania mogą być rozwijane jako elementy backlogu, priorytetyzowane i dostarczane w kolejnych sprintach. Szczególnie funkcje związane z UX powinny być opisane jako historyjki użytkownika i walidowane przez prototypy.

Nie wszystkie wymagania powinny jednak pozostać nieformalne. Wymagania bezpieczeństwa, ochrony danych, kompatybilności przeglądarek, uploadu obrazów, utraty danych przy przerwanej sesji i wydajności powinny być udokumentowane w sposób weryfikowalny. W przeciwnym razie zespół może zbyt późno odkryć, że projekt nie spełnia wymagań jakościowych.

=== Wytwarzanie
Projekt techniczny wykorzystuje m.in. TypeScript, Next.js, TailwindCSS, shadcn, PostgreSQL. Taki stos technologiczny pozwala szybko budować przyrosty, ale jednocześnie zawiera obszary wymagające decyzji architektonicznych: model danych portfolio, przechowywanie plików, autoryzacja, optymalizacja obrazów, RWD i wielojęzyczność.

Podejście czysto klasyczne z pełnym Big Design Up Front byłoby zbyt ciężkie dla trzyosobowego zespołu i zmiennego UX. Podejście czysto zwinne z zasadą #link("https://en.wikipedia.org/wiki/You_aren't_gonna_need_it")[YAGNI] _(You aren't gonna need it)_ także byłoby ryzykowne, ponieważ błędne decyzje w architekturze danych, autoryzacji lub przechowywaniu obrazów mogą być kosztowne do odwrócenia. Wytwarzanie powinno więc opierać się na Scrumie z dodatkiem lekkiego projektowania architektury przed implementacją większych epików.

== Osoby

=== Klient
Głównym klientem w projekcie jest Pani promotor, która pełni rolę osoby oceniającej kierunek produktu, makiety, zakres funkcjonalny oraz zgodność projektu z celem pracy inżynierskiej. Nie jest to jednak klient w pełni odpowiadający idealnemu Product Ownerowi klasy CRACK (Collaborative, Responsible, Authorized, Committed, Knowledgeable), ponieważ nie reprezentuje bezpośrednio wszystkich końcowych użytkowników systemu. Z tego powodu decyzje produktowe uzupełniamy kryteriami akceptacji oraz testami wykonywanymi przez zespół.

Takie ułożenie współpracy częściowo pasuje do Scruma, ponieważ mamy osobę, która regularnie ocenia efekty i może zatwierdzać kierunek prac. Jednocześnie jest to obszar wymagający adaptacji, ponieważ brak stałego przedstawiciela realnych artystów może powodować, że część decyzji UX będzie oparta na założeniach zespołu. Aby ograniczyć to ryzyko, metodykę należy rozszerzyć o walidację najważniejszych funkcji z użytkownikami testowymi oraz o konkretne kryteria akceptacji dla elementów interfejsu.

#pagebreak()
=== Kultura
Kultura pracy zespołu jest bliższa zwinności, ponieważ zespół pracuje sprintami, przeprowadza retrospektywy, korzysta z tablicy zadań i reaguje na problemy procesu. Jednocześnie zespół świadomie wprowadza elementy porządku: Code Review, Definition of Done, manualne testy i dokumentację w repozytorium.

W modelu Boehma i Turnera jest to kultura pośrednia: zespół potrzebuje swobody w projektowaniu UX i iteracyjnym doprecyzowaniu produktu, ale potrzebuje też zasad, aby ograniczyć ryzyko wynikające z małego składu, pracy hybrydowej i mieszanych kompetencji. To ponownie wskazuje na metodykę zwinną z adaptacjami dyscyplinującymi.

#formatted_table(
  caption: [Podsumowanie oceny według modelu pełnego],
  columnsCount: 4,
  (
    [*Obszar*],
    [*Kryterium*],
    [*Dopasowanie*],
    [*Najważniejszy wniosek*],
    [Zastosowanie],
    [Główne cele],
    [Zwinne],
    [MVP, szybka wartość i walidacja UX są ważniejsze niż pełna przewidywalność planu.],
    [Zastosowanie],
    [Środowisko],
    [Zwinne z elementami planu],
    [UX i rynek są zmienne, ale architektura danych i bezpieczeństwo wymagają stabilizacji.],
    [Zarządzanie],
    [Komunikacja],
    [Zwinne z dokumentacją],
    [Mały zespół sprzyja komunikacji bezpośredniej, lecz praca hybrydowa wymaga jawnych notatek i statusów.],
    [Techniczne],
    [Wymagania],
    [Zwinne z formalizacją jakości],
    [Historyjki są dobre dla funkcji, ale wymagania jakościowe muszą być mierzalne.],
    [Techniczne],
    [Wytwarzanie],
    [Zwinne z lekką architekturą],
    [Przyrosty są możliwe, ale autoryzacja, storage i model danych wymagają wcześniejszych decyzji.],
    [Osoby],
    [Klient],
    [Niedopasowanie do Scruma],
    [Brak stałego Product Ownera CRACK trzeba kompensować walidacją i kryteriami akceptacji.],
    [Osoby],
    [Kultura],
    [Zwinne z porządkiem],
    [Zespół stosuje sprinty i retrospektywy, ale potrzebuje zasad jakości i przepływu.],
  ),
)

= Model dostarczania produktu końcowego

Najlepszym modelem dostarczania dla ArtSea jest model *przyrostowy*, a docelowo częściowo *ciągły* po ustabilizowaniu MVP.

Model jednorazowy nie pasuje do projektu. Produkt ma wiele niezależnych obszarów funkcjonalnych, które można dostarczać etapami: infrastruktura, autoryzacja, zarządzanie pracami, kategorie, galeria publiczna, personalizacja, sekcja „O mnie”, języki i kontakt. Jednorazowe dostarczenie całego systemu zwiększyłoby ryzyko, że problemy UX, architektury lub wydajności zostaną wykryte dopiero pod koniec pracy.

Model przyrostowy pasuje najlepiej do etapu pracy inżynierskiej. Pozwala zaplanować sprinty wokół epików, uzyskiwać działające części produktu, weryfikować kryteria akceptacji i aktualizować backlog.

Model ciągły jest właściwy jako kierunek po wdrożeniu MVP. Na obecnym etapie pełne Continuous Delivery byłoby jednak przedwczesne, ponieważ zespół dopiero stabilizuje proces, architekturę i kryteria jakości.

Sugerowana metodyka wynikająca z modelu dostarczania to *Scrum* jako metodyka bazowa dla przyrostowej realizacji produktu, uzupełniony praktykami Kanban do kontroli przepływu i praktykami inżynierskimi dla jakości.

= Metodyka i jej adaptacja

== Wybór metodyki bazowej

Na podstawie modelu uproszczonego, modelu pełnego i modelu dostarczania zalecaną metodyką bazową dla projektu ArtSea jest *Scrum*. Uzasadnienie wyboru:
- projekt jest realizowany przez mały zespół
- produkt można dzielić na przyrosty dostarczane w sprintach
- wymagania UX i priorytety produktu wymagają iteracyjnej walidacji
- zespół już używa elementów Scruma: backlogu produktu, backlogu sprintu, celu sprintu, Definition of Done
- Jira i tablica zadań wspierają planowanie oraz inspekcję postępu

Scrum nie powinien być jednak stosowany w wersji „czystej” i nieadaptowanej. Projekt ma kilka cech niepasujących do Scruma: brak stałego Product Ownera klasy CRACK, praca hybrydowa, potrzeba większej jawności wiedzy, wymagania bezpieczeństwa i jakości, mały zespół o mieszanych kompetencjach oraz potrzeba kontroli przepływu w code review i testach.

#pagebreak()

== Adaptacje metodyki

*Proponowane adaptacje Scruma dla projektu ArtSea:*

- *Brak stałego Product Ownera CRACK*
  - *Ryzyko:* backlog może bazować na założeniach zespołu, a nie na rzeczywistych potrzebach artystów.
  - *Adaptacja:* wprowadzić rolę pośredniczącego Product Ownera pełnioną przez zespół, z obowiązkową walidacją decyzji u promotora i użytkowników testowych.
  - *Uzasadnienie:* adaptacja zachowuje backlog i priorytetyzację Scruma, ale kompensuje brak jednej stale dostępnej osoby decyzyjnej.

- *Użytkownicy są nietechniczni i wrażliwi na UX*
  - *Ryzyko:* zespół może zbudować funkcje poprawne technicznie, ale za trudne lub nieatrakcyjne dla artystów.
  - *Adaptacja:* dodać testy użyteczności dla kluczowych przepływów: dodanie pracy w mniej niż 3 minuty, edycja Bento Box, znalezienie kontaktu na mobile.
  - *Uzasadnienie:* Scrum Review powinien obejmować nie tylko pokaz funkcji, ale także ocenę prostoty i estetyki interfejsu.

- *Wymagania jakościowe i bezpieczeństwa mają wpływ architektoniczny*
  - *Ryzyko:* #link("https://en.wikipedia.org/wiki/You_aren't_gonna_need_it")[YAGNI] i odkładanie decyzji może doprowadzić do kosztownych zmian w auth, bazie danych, storage'u obrazów lub wydajności.
  - *Adaptacja:* przed epikami technicznymi wykonywać krótkie spike'i architektoniczne i zapisywać decyzje #link("https://adr.github.io/")[ADR] w repozytorium #notes.
  - *Uzasadnienie:* to lekkie rozszerzenie Scruma, które nie tworzy pełnego #link("https://en.wikipedia.org/wiki/Big_design_up_front")[BDUF], ale chroni najważniejsze decyzje przed przypadkowością.

- *Praca hybrydowa i część ustaleń na Discordzie*
  - *Ryzyko:* wiedza niejawna może zniknąć, a osoby nieobecne na rozmowie nie będą znały decyzji.
  - *Adaptacja:* po każdym istotnym spotkaniu zapisywać krótką notatkę decyzyjną: kontekst, decyzja, konsekwencje, odpowiedzialna osoba.
  - *Uzasadnienie:* metodyka zwinna zostaje rozszerzona o minimalną dokumentację, potrzebną przy pracy zdalnej i dyplomowej.

- *Ryzyko wąskiego gardła w code review i testach*
  - *Ryzyko:* zadania mogą kumulować się pod koniec sprintu, a przyrost nie będzie faktycznie gotowy.
  - *Adaptacja:* rozszerzyć standardową tablicę sprintu o praktyki Kanban: limity WIP, osobne kolumny Code Review i Testy oraz stałe sloty na review/testy.
  - *Uzasadnienie:* to adaptacja przepływu, która wzmacnia przejrzystość, inspekcję i adaptację bez niszczenia Scruma.

- *Mieszane kompetencje zespołu*
  - *Ryzyko:* przy zadaniach łączących kilka obszarów, np. UX, frontend, backend i bazę danych, pojedyncza osoba może podjąć decyzję dobrą lokalnie, ale problematyczną dla innej części systemu.
  - *Adaptacja:* przed rozpoczęciem większych zadań uzgadniać krótko podejście z resztą zespołu, a zadania o większym ryzyku dzielić na mniejsze kroki lub poprzedzać krótkim spike'em technicznym.
  - *Uzasadnienie:* taka adaptacja pasuje do małego zespołu, ponieważ nie dodaje ciężkiej dokumentacji ani formalnych ról, ale zmniejsza ryzyko pracy w oderwaniu od pozostałych obszarów projektu.

- *Duży udział prac UX i projektowych*
  - *Ryzyko:* klasyczny sprint deweloperski może nie uwzględniać równoległej pracy w Figmie i walidacji makiet.
  - *Adaptacja:* traktować artefakty UX jako pełnoprawne elementy backlogu z kryteriami akceptacji i Definition of Done dla projektów.
  - *Uzasadnienie:* dzięki temu Scrum obejmuje zarówno kod, jak i przyrost wiedzy/prototypu potrzebny do następnych sprintów.

== Elementy Scruma utrzymane bez zmian

Należy utrzymać następujące elementy metodyki:
- backlog produktu w Jira, podzielony na epiki i priorytety,
- planowanie sprintu i określanie celu sprintu,
- krótkie sprinty, preferencyjnie dwutygodniowe,
- estymację złożoności metodą Planning Poker,
- Definition of Done,
- retrospektywy po każdym sprincie,
- regularną inspekcję przyrostu.

== Elementy przycięte lub uproszczone

Ze względu na trzyosobowy zespół nie ma potrzeby pełnej formalizacji ról i ceremonii w skali dużej organizacji. Scrum Master może być rolą rotacyjną lub przypisaną osobie moderującej spotkania, a Product Owner powinien być rolą pośredniczącą, wspieraną walidacją zewnętrzną. Daily Scrum w klasycznej codziennej formie można zastąpić krótkimi statusami dwa razy w tygodniu oraz obowiązkiem aktualizacji Jiry, o ile nie spada przejrzystość sprintu. Jeżeli w sprincie pojawiają się blokery lub intensywna integracja kodu, należy czasowo wrócić do częstszych krótkich synchronizacji.

== Elementy dodane do metodyki

Do Scruma należy dodać:
- lekkie #link("https://github.com/architecture-decision-record/architecture-decision-record#what-is-an-architecture-decision-record")[ADR] dla decyzji architektonicznych,
- checklisty Definition of Done dla kodu, UX i dokumentacji,
- limity WIP dla pracy w toku, review i testów,
- formalne kryteria akceptacji dla wymagań jakościowych,
- dokumentowanie ważnych decyzji w #notes.

== Wniosek końcowy

ArtSea powinno być prowadzone jako projekt zwinny, oparty na Scrumie, ale nie jako projekt pozbawiony dyscypliny. Najważniejsze cechy projektu -- mały zespół, zmienny UX, możliwość przyrostowego dostarczania i potrzeba szybkiej walidacji wartości -- wskazują na Scrum. Najważniejsze odstępstwa -- brak stałego Product Ownera CRACK, wymagania jakościowe, bezpieczeństwo, praca hybrydowa i mieszane kompetencje -- wymagają adaptacji metodyki przez dodanie praktyk dokumentacyjnych, jakościowych i przepływowych. Taka adaptacja nie niszczy fundamentów Scruma, ponieważ nadal zachowuje empiryzm, przejrzystość, inspekcję, adaptację i dostarczanie przyrostów, a jednocześnie kompensuje realne ryzyka projektu ArtSea.
