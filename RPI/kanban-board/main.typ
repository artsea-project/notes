#set text(lang: "pl")

#import "template.typ": *

#show: paper => jacow(
  title: [ArtSea],
  subtitle: [Tablica Kanban],
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

= Stany zgłoszeń/zadań

Domyślny zestaw stanów został rozszerzony, aby odzwierciedlał zdefiniowaną wcześniej Definicję Ukończenia (Definition of Done). Na tablicy Kanban w Jira znajdą się następujące kolumny (stany):

#formatted_table(
  caption: [Stany zadań na tablicy Kanban],
  columnsCount: (auto, auto, 1fr),
  ref: "tab:requirements",
  // format: (auto, auto, auto),
  (
    [Stan],
    [Opis],
    [Kryteria ukończenia],
    [DO ZROBIENIA (TO DO)],
    [Zadania wybrane do realizacji w bieżącym sprincie, które jeszcze nie zostały rozpoczęte],
    [Członek zespołu przypisuje zadanie do siebie i fizycznie rozpoczyna nad nim pracę],
    formatted_table_sep,
    [W TOKU (IN PROGRESS)],
    [Zadania, nad którymi aktualnie trwają prace deweloperskie lub projektowe],
    [Zakończenie implementacji kodu zgodnie ze standardami (Lint/Prettier) lub ukończenie projektów w Figmie],
    formatted_table_sep,
    [ZABLOKOWANE (BLOCKED)],
    [Oznacza, że prace nad zadaniem nie mogą być kontynuowane (np. z powodu braku dostępu, błędów środowiska lub oczekiwania na decyzję)],
    [Rozwiązanie problemu blokującego (powrót do "W TOKU")],
    formatted_table_sep,
    [CODE REVIEW (IN REVIEW)],
    [Kod został napisany i czeka na weryfikację przez innego członka zespołu, co jest wymogiem w projekcie],
    [Akceptacja zmian (Pull Requesta) przez inną osobę z zespołu],
    formatted_table_sep,
    [TESTY (IN TESTING)],
    [Kod przeszedł weryfikację i czeka na manualne testy funkcjonalności na środowisku lokalnym/deweloperskim],
    [Kryterium przejścia: Pomyślne przejście testów realizowanych przez osobę odpowiedzialną za QA],
    formatted_table_sep,
    [GOTOWE (DONE):],
    [Stan końcowy dla zadań, które zostały w pełni zrealizowane, zweryfikowane i są gotowe do uznania za część przyrostu produktu],
    [Zadanie spełnia wszystkie kryteria akceptacji oraz Definicję Ukończenia],
  ),
)
#figure(
  image("kanban-board-jira.png"),
  caption: [Zrzut ekranu z tablic Kanban w Jira]
)
= Limity WIP (Work in Progress)

#formatted_table(
  caption: [Stany zadań na tablicy Kanban],
  columnsCount: (auto, auto, 1fr),
  ref: "tab:requirements",
  // format: (auto, auto, auto),
  (
    [Stan],
    [Limit],
    [Uzasadnienie],
    [DO ZROBIENIA (TO DO)],
    [Limit wynikający z pojemności sprintu],
    [Zgodnie z ustaleniami z poprzedniego etapu, średnia prędkość naszego zespołu została oszacowana na około 40 Story Points dla dwutygodniowej iteracji. Limit w tej kolumnie jest wyrażony w prostej liczbie zadań, lecz w maksymalnej sumie punktów złożoności. Aby plan był realistyczny i dostosowany do naszych możliwości (z uwzględnieniem 20% rezerwy czasowej), łączna waga zadań wybranych do realizacji w sprincie nie może przekroczyć 40 Story Points.],
    formatted_table_sep,
    [W TOKU (IN PROGRESS)],
    [3],
    [Zespół deweloperski liczy dokładnie 3 osoby. Limit 3 wymusza zasadę, według której każdy członek zespołu pracuje w danej chwili wyłącznie nad jednym zadaniem. Pozwala to na pełne skupienie, unikanie wielozadaniowości (context switching) i szybsze dostarczanie wartości.],
    formatted_table_sep,
    [ZABLOKOWANE (BLOCKED)],
    [2],
    [Stan zablokowania jest sytuacją wyjątkową. Jeśli więcej niż 2 zadania trafią do tej kolumny, oznacza to poważny problem z przepływem pracy (np. problemy ze środowiskiem, brak decyzji biznesowych). Limit ten wymusza na zespole natychmiastowe przerwanie innych prac i skupienie się na odblokowaniu zadań.],
    formatted_table_sep,
    [CODE REVIEW (IN REVIEW)],
    [2],
    [Każde zadanie wymaga akceptacji (Pull Requesta) przez przynajmniej jednego innego członka zespołu , na co przewidziano rezerwę czasową. Limit 2 zapobiega tworzeniu się "wąskiego gardła". Wymusza to na zespole bieżące weryfikowanie kodu innych członków, zanim wezmą z kolumny TO DO kolejne zadania dla siebie.],
    formatted_table_sep,
    [TESTY (IN TESTING)],
    [2],
    [Za proces QA i testowanie odpowiada głównie jedna osoba.Zbyt wysoki limit w tej kolumnie mógłby doprowadzić do jej przeciążenia i zablokowania procesu dostarczania gotowego oprogramowania. Limit 2 pozwala na płynną i dokładną weryfikację funkcjonalności.],
    formatted_table_sep,
    [GOTOWE (DONE):],
    [Brak limitu],
    [Jest to kolumna końcowa, która gromadzi wszystkie zadania spełniające kryteria "Definition of Done". Jej celem jest pokazywanie przyrostu ukończonego produktu, dlatego nie ogranicza się w niej liczby kart.],
  ),
)

= Tablica Kanban

= Metryki produktywności