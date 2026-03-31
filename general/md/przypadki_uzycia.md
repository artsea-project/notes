# Przypadki użycia Portfolio Artysty

## Przypadki użycia dla Odbiorcy

```mermaid
flowchart LR
    Odbiorca((Odbiorca))
    SerwerEmail(("Serwer E-mail"))

    subgraph ArtSea [Interfejs portfolio]
        PU1([Przeglądanie galerii zdjęć])
        PU2([Kontakt z artystą / Formularz])
        PU3([Wybór języka interfejsu])
    end

    Odbiorca --> PU1
    Odbiorca --> PU2
    Odbiorca --> PU3
    PU2 --> SerwerEmail
```

## Przypadki użycia dla Artysty

```mermaid
flowchart LR
    Artysta((Artysta))

    subgraph ArtSea [Interfejs portfolio]
        PU4([Rejestracja konta])
        PU5([Dodawanie pracy])
        PU6([Edytowanie pracy])
        PU7([Wypełnienia detali pracy])
        PU8([Usuwanie pracy])
        PU9([Dodawanie kategorii prac])
        PU10([Edytowanie kategorii prac])
        PU11([Dodawanie/edytyowanie informacji o sobie])
        PU12([Zmienianie layoutu strony głównej])
    end

    Artysta --> PU4
    Artysta --> PU5
    Artysta --> PU6
    Artysta --> PU8
    Artysta --> PU9
    Artysta --> PU10
    Artysta --> PU11
    Artysta --> PU12
    PU5 --- | << includes >> | PU7
    PU6 --- | << includes >> | PU7
```

<!--
Stary diagram (wszystkie przypadki użycia w jednym)
```mermaid
flowchart LR
    %% Definicja aktora
    Odbiorca((Odbiorca))
    Artysta((Artysta))
    SerwerEmail(("Serwer E-mail"))

    %% Granice systemu ArtSea
    subgraph ArtSea [Interfejs portfolio]
        PU1([Przeglądanie galerii zdjęć])
        PU2([Kontakt z artystą / Formularz])
        PU3([Wybór języka interfejsu])
        PU4([Rejestracja konta])
        PU5([Dodawanie pracy])
        PU6([Edytowanie pracy])
        PU7([Wypełnienia detali pracy])
        PU8([Usuwanie pracy])
        PU9([Dodawanie kategorii prac])
        PU10([Edytowanie kategorii prac])
        PU11([Dodawanie/edytyowanie informacji o sobie])
        PU12([Zmienianie layoutu strony głównej])
    end

    %% Relacje
    Odbiorca --- PU1
    Odbiorca --- PU2
    PU2 --- SerwerEmail
    Odbiorca --- PU3
    Artysta --- PU4
    Artysta --- PU5
    Artysta --- PU6
    PU5 --- | << includes >> | PU7
    PU6 --- | << includes >> | PU7
    Artysta --- PU8
    Artysta --- PU9
    Artysta --- PU10
    Artysta --- PU11
    Artysta --- PU12
```
-->

## Specyfikacja przypadków użycia

<!-- PU1 -->
| **Nazwa** | Przeglądanie galerii zdjęć | 
| :--- | :--- |
| **Warunki wstępne** | Artysta udostępnił publicznie swoje portfolio w systemie ArtSea, w którym znajduje się co najmniej jedna praca graficzna. |
| **Podstawowy scenariusz interakcji** | 1. Odbiorca wchodzi na stronę galerii artysty.<br>2. System ładuje układ strony i wyświetla miniatury prac.<br>3. Odbiorca wybiera (klika) interesującą go miniaturę.<br> 4. System wyświetla powiększone zdjęcie w wysokiej rozdzielczości wraz tytułem, opisem, użytymi technikami itd.<br> 5. Odbiorca zamyka podgląd powiększonego zdjęcia.<br> 6. System powraca do widoku głównej galerii, zachowując pozycję przewijania.|
| **Wyjątki i scenariusze alternatywne** | **Filtrowanie po kategorii:**<br>3a1. Odbiorca przed kliknięciem wybiera z menu konkretną kategorię prac (np. rzeźba)<br>3a2.System odświeża siatkę, pokazując wyłącznie miniatury z wybranej kategorii. <br><br> **Brak Prac:**<br> 2a. Portfolio jest puste. System wyświetla wiadomość typu: "Artysta nie dodał jeszcze żadnych prac. Zajrzyj tu wkrótce!" |
| **Warunki końcowe** | Odbiorca pomyślnie obejrzał wybrane prace w portfolio. |
| **Komentarze** | idk w końcu jak robimy z tymi podstronami |
<br><br>

<!-- PU2 -->
| **Nazwa** | Kontakt z artystą / Formularz |
| :--- | :--- |
| **Warunki wstępne** | Odbiorca znajduje się w portfolio artysty. Artysta włączył opcję formularza kontaktowego w ustawieniach systemu. |
| **Podstawowy scenariusz interakcji** | 1. Odbiorca przechodzi do sekcji kontaktowej na stronie<br>2. System wyświetla formularz kontaktowy z polami: Imię i Nazwisko, Adres e-mail (zwrotny), Temat, Treść wiadomości.<br>3. Odbiorca wypełnia wszystkie wymagane pola.<br> 4.  Odbiorca klika przycisk "Wyślij wiadomość".<br> 5. System waliduje poprawność wprowadzonych danych. <br> 6. System przekazuje wiadomość do zewnętrznego serwera E-mail<br> 7. System wyświetla komunikat o sukcesie i czyści Formularz.|
| **Wyjątki i scenariusze alternatywne** | **Zachowanie stanu przy utracie sesji:**<br>3a. Jeśli Odbiorca na chwilę straci połączenie z internetem w trakcie pisania, system zachowuje wpisaną treść w pamięci lokalnej przeglądarki, zapobiegając utracie tekstu.<br><br> **Błąd walidacji danych:**<br>5a. Odbiorca wprowadził niepoprawny format adresu e-mail (np. brak znaku @) lub zostawił puste pole obowiązkowe. System nie wysyła wiadomości, podświetla błędne pola na czerwono i wyświetla komunikat: "Popraw błędy w formularzu przed wysłaniem".<br><br>**Błąd serwera:**<br> 6a. Serwer napotyka błąd podczas próby wysłania wiadomości (np. problem z usługą e-mail). System wyświetla komunikat: "Wystąpił problem techniczny. Nie udało się wysłać wiadomości. Spróbuj ponownie później." Tekst wpisany przez użytkownika nie jest usuwany.
| **Warunki końcowe** | Wiadomość od Odbiorcy zostaje pomyślnie przekazana do wysyłki na adres e-mail Artysty. |
| **Komentarze** | --- |
<br><br>

<!-- PU3 -->
| **Nazwa** | Wybór języka interfejsu |
| :--- | :--- |
| **Warunki wstępne** | Odbiorca znajduje się w portfolio. System ma zaimplementowaną obsługę więcej niż jednego języka. |
| **Podstawowy scenariusz interakcji** | 1. Odbiorca lokalizuje przycisk wyboru języka.<br>2. Odbiorca klika przycisk wyboru języka.<br>3. System wyświetla listę dostępnych języków.<br> 4. Odbiorca klika preferowany język.<br> 5. System przeładowuje stronę na wybrany język. |
| **Wyjątki i scenariusze alternatywne** | **Brak tłumaczeń treści autorskich:**<br>5a. Interfejs platformy zmienia się na wybrany język, ale opisy zdjęć i biogram wprowadzone manualnie przez artystę pozostają w języku oryginalnym. System może opcjonalnie wyświetlić komunikat "Treści autorskie mogą nie być dostępne w wybranym języku".|
| **Warunki końcowe** | System zapamiętuje wybór języka w pliku cookie/localStorage na urządzeniu Odbiorcy na czas trwania sesji i kolejnych wizyt. Interfejs prezentowany jest w wybranym języku. |
| **Komentarze** | Czy tłumaczenie wprowadza artysta czy będzie automatyczne? |

## Przypadki użycia dla Artysty

<!-- PU4 -->
| **Nazwa** | Rejestracja konta |
| :--- | :--- |
| **Warunki wstępne** | Artysta nie posiada jeszcze konta w systemie ArtSea. |
| **Podstawowy scenariusz interakcji** | 1. Artysta klika przycisk "Rejestracja" na stronie logowania.<br> 2. System wyświetla formularz rejestracji z polami: Adres e-mail, Hasło, Potwierdzenie hasła, Imię i Nazwisko.<br> <!-- TO DO - ustalic jakie dane potrzebne --> 3. Artysta wypełnia wszystkie wymagane pola.<br>4. Artysta klika przycisk "Utwórz konto".<br>5. System waliduje dane wejściowe.<br> <!--6. System wysyła wiadomość potwierdzającą na adres e-mail artysty.<br>7. System wyświetla komunikat: "Sprawdź swoją skrzynkę e-mailową, aby potwierdzić konto".<br>8. Artysta klika link potwierdzający w wiadomości e-mail.<br> TO DO - czy my chcemy potweirdzenie email --> 6. System aktywuje konto i kieruje artystę na stronę główną. |
| **Wyjątki i scenariusze alternatywne** | **Błąd walidacji danych:**<br>5a. Adres e-mail jest już zarejestrowany, hasło jest zbyt słabe lub format danych jest nieprawidłowy. System podświetla błędne pola i wyświetla odpowiedni komunikat. <br><br> <!--**Brak potwierdzenia e-mail:**<br>  6a. Link potwierdzający wygasa po 24 godzinach. System wyświetla opcję wysłania nowego linku potwierdzającego. --> |
| **Warunki końcowe** | Konto artysty zostaje pomyślnie utworzone i aktywowane. Artysta może zalogować się i przystąpić do konfiguracji profilu. |
| **Komentarze** | Wymagania bezpieczeństwa dla hasła: minimum 8 znaków, co najmniej jedno duże litery, cyfra i znak specjalny. |
<br><br>

<!-- PU5 -->
| **Nazwa** | Dodawanie pracy |
| :--- | :--- |
| **Warunki wstępne** | Artysta jest zalogowany. |
| **Podstawowy scenariusz interakcji** | 1. Artysta przechodzi do sekcji "Moje Prace".<br>2. System wyświetla listę istniejących prac z przyciskiem "Dodaj pracę".<br>3. Artysta klika przycisk "Dodaj pracę".<br>4. System otwiera formularz do wypełniania detali pracy (przypadek użycia *Wypełnianie detali pracy* - PU7). |
| **Wyjątki i scenariusze alternatywne** | --- |
| **Warunki końcowe** | Artysta przechodzi do formularza PU7 w celu wypełniania informacji o nowej pracy. |
| **Komentarze** | |
<br><br>

<!-- PU6 -->
| **Nazwa** | Edytowanie pracy |
| :--- | :--- |
| **Warunki wstępne** | Artysta jest zalogowany. Posiada co najmniej jedną pracę w portfolio. |
| **Podstawowy scenariusz interakcji** | 1. Artysta przechodzi do sekcji "Moje Prace".<br>2. System wyświetla listę prac artysty.<br>3. Artysta klika na pracę, którą chce edytować, lub klika ikonę "edytuj" obok pracy.<br>4. System otwiera formularz do edytowania detali pracy (patrz przypadek użycia *Wypełnianie detali pracy* - PU7). |
| **Wyjątki i scenariusze alternatywne** | --- |
| **Warunki końcowe** | Artysta przechodzi do formularza PU7 w celu edytowania informacji o pracy. |
| **Komentarze** | |
<br><br>

<!-- PU7 -->
| **Nazwa** | Wypełnianie detali pracy |
| :--- | :--- |
| **Warunki wstępne** | Artysta przechodzi z przypadku PU5 (*Dodawanie pracy*) lub PU6 (*Edytowanie pracy*). System wyświetla formularz do wypełniania/edytowania pracy. |
| **Podstawowy scenariusz interakcji** | 1. System wyświetla formularz do dodawania/edytowania pracy ze wszystkimi polami:<br>   - Zdjęcie/Obraz (wymagane) - drag-and-drop lub selektor<br>   - Tytuł (wymagane) - pole tekstowe<br>   - Kategoria (wymagane) - lista rozwijalna<br>   - Opis pracy (opcjonalnie) - pole tekstowe z formatowaniem<br>   - Technika/Metoda (opcjonalnie) - pole tekstowe<br>   - Wymiary (opcjonalnie) - wysokość × szerokość × głębokość (cm)<br>   - Materiały użyte (opcjonalnie) - pole tekstowe<br>   - Rok wykonania (opcjonalnie) - pole daty/liczby<br> 2. Artysta wypełnia wymagane pola (zdjęcie, tytuł, kategoria) i opcjonalne pola, które chce dodać.<br> 3. System automatycznie zapisuje wersje robocze podczas pisania (auto-save co 5 sekund) - wyświetla komunikat "Zapisywanie..." a następnie "Zapisano".<br> 4. Artysta klika przycisk "Zapisz pracę" lub "Zapisz zmiany".<br>5. System waliduje dane (sprawdza obowiązkowe pola, format zdjęcia).<br>6. System przesyła obraz na serwer, zapisuje dane w bazie danych i wyświetla komunikat o sukcesie. |
| **Wyjątki i scenariusze alternatywne** | **Błąd walidacji:**<br>6a. Podczas walidacji: plik je zbyt duży (max ...), format nie obsługiwany (...), pole obowiązkowe jest puste lub format danych jest nieprawidłowy. System wyświetla komunikat z wymogami i wyróżnia błędne pola, umożliwiając poprawę danych.<br><br>**Brak połączenia internetowego:**<br>4a. Jeśli połączenie zostanie przerwane, system przechowuje dane w pamięci lokalnej przeglądarki i automatycznie synchronizuje po przywróceniu połączenia. Wyświetla komunikat "Pracujesz w trybie offline - zmiany zostaną wysłane".<br><br>**Anulowanie:**<br>5a. Artysta klika przycisk "Anuluj". W trybie dodawania - powraca do listy prac bez zapisania. W trybie edytowania - System pyta o potwierdzenie ("Jeśli wyjdziesz, niezapisane zmiany zostaną utracone") i powraca do listy prac bez zmian.<br><br>**Tworzenie nowej kategorii:**<br>3a. Jeśli wymagana kategoria nie istnieje, artysta może wybrać "Nowa kategoria" z listy, co otwiera (patrz PU9), po czym powraca do formularza pracy z nową kategorią wybraną. |
| **Warunki końcowe** | W trybie dodawania: Nowa praca zostaje dodana do galerii artysty ze wszystkimi wypełnionymi informacjami. Praca jest widoczna dla odbiorców.<br>W trybie edytowania: Zmiany w pracy są zapisywane. Aktualizowana praca jest natychmiast widoczna dla odbiorców. |
| **Komentarze** | Formularz jest uniwersalny - używany zarówno do dodawania (PU5) jak i edytowania (PU6). Dozwolone formaty obrazów: ... . Maksymalny rozmiar: ... . Wymiary - format: liczba × liczba × liczba (cm). |
<br><br>

<!-- PU8 -->
| **Nazwa** | Usuwanie pracy |
| :--- | :--- |
| **Warunki wstępne** | Artysta jest zalogowany. Praca istnieje w galerii artysty. |
| **Podstawowy scenariusz interakcji** | 1. Artysta przechodzi do sekcji "Moje Prace".<br>2. System wyświetla listę prac z paskami akcji (edytuj, usuń) dla każdej pracy.<br>3. Artysta klika przycisk "Usuń" na wybranej pracy.<br>4. System wyświetla okno potwierdzenia: "Jesteś pewny, że chcesz usunąć tę pracę? Tej akcji nie można cofnąć."<br>5. Artysta klika "Tak, usuń".<br>6. System usuwuje pracę z bazy danych i z serwera (w tym wszystkie zdjęcia i metadane).<br>7. System wyświetla komunikat "Praca została usunięta" i powraca do listy prac. |
| **Wyjątki i scenariusze alternatywne** | **Anulowanie usunięcia:**<br>5a. Artysta klika "Anuluj" lub zamyka okno potwierdzenia. Praca pozostaje w systemie bez zmian.<br><br> |
| **Warunki końcowe** | Praca jest trwale usunięta z galerii. Niewidoczna dla odbiorców i artysty. Miejsce na serwerze jest zwalniane. |
| **Komentarze** | |
<br><br>

<!-- PU9 -->
| **Nazwa** | Dodawanie kategorii prac |
| :--- | :--- |
| **Warunki wstępne** | Artysta jest zalogowany. |
| **Podstawowy scenariusz interakcji** | 1. Artysta przechodzi do sekcji "Kategorie".<br>2. System wyświetla listę istniejących kategorii z przyciskiem "Dodaj kategorię".<br>3. Artysta klika przycisk "Dodaj kategorię".<br>4. System otwiera formularz z polami: Nazwa kategorii, Opis kategorii (opcjonalnie), Ikona/Obraz kategorii (opcjonalnie).<br>5. Artysta wypełnia nazwę kategorii (wymagane).<br>6. Artysta opcjonalnie dodaje ikonę reprezentującą kategorię.<br>7. Artysta klika "Zapisz".<br>8. System waliduje, że nazwa kategorii jest unikalna .<br>9. System dodaje nową kategorię i wyświetla ją na liście. |
| **Wyjątki i scenariusze alternatywne** | **Błąd duplikatu:**<br>8a. Kategoria o tej nazwie już istnieje. System wyświetla komunikat "Kategoria o tej nazwie już istnieje" i sugeruje opcję edycji istniejącej kategorii.<br><br> |
| **Warunki końcowe** | Nowa kategoria jest dostępna dla artysty przy dodawaniu/edytowaniu prac. Kategoria jest widoczna  dla odbiorców. |
| **Komentarze** | Każda kategoria powinna mieć unikalną nazwę. Maksymalna liczba kategorii: 50. |
<br><br>

<!-- PU10 -->
| **Nazwa** | Edytowanie kategorii prac |
| :--- | :--- |
| **Warunki wstępne** | Artysta jest zalogowany. Co najmniej jedna kategoria istnieje w systemie. |
| **Podstawowy scenariusz interakcji** | 1. Artysta przechodzi do sekcji "Kategorie".<br>2. System wyświetla listę kategorii.<br>3. Artysta klika na kategorię, którą chce edytować, lub klika ikonę "edytuj" obok nazwy kategorii.<br>4. System otwiera formularz edycji kategorii ze wszystkimi istniejącymi danymi.<br>5. Artysta zmienia potrzebne informacje (nazwę, opis, ikonę).<br>6. Artysta klika "Zapisz zmiany".<br>7. System waliduje dane (sprawdza unikalność nazwy).<br>8. System aktualizuje kategorię.<br>9. System wyświetla komunikat potwierdzający i powraca do listy kategorii. |
| **Wyjątki i scenariusze alternatywne** | **Błąd duplikatu nazwy:**<br>7a. Zmieniona nazwa kategorii już istnieje. System wyświetla komunikat błędu i umożliwia zmianę nazwy.<br><br>**Usuwanie kategorii:**<br>9a. Jeśli kategoria zawiera prace, artysta może wybrać opcję przeniesienia prac do innej kategorii przed usunięciem kategorii. |
| **Warunki końcowe** | Zmiany w kategorii są zapisywane. Wszystkie prace przypisane do kategorii mają zaktualizowane informacje. |
| **Komentarze** | Nie powinno być możliwe usunięcie kategorii, jeśli zawiera prace, bez uprzedniego przeniesienia prac do innej kategorii. |
<br><br>

<!-- PU11 -->
| **Nazwa** | Dodawanie/edytowanie informacji o sobie |
| :--- | :--- |
| **Warunki wstępne** | Artysta jest zalogowany. Profil artysty istnieje w systemie. |
| **Podstawowy scenariusz interakcji** | 1. Artysta przechodzi do sekcji "Mój profil" lub "Ustawienia profilu".<br>2. System wyświetla formularz profilu z polami: Zdjęcie profilowe, Imię i Nazwisko, Biografia (pole tekstowe), Specjalizacja/Gatunek artystyczny, Edukacja, Doświadczenie, Linki do mediów społecznościowych (Instagram, Facebook, itp.).<br>3. Artysta wypełnia/aktualizuje pola z informacjami o sobie.<br>4. Artysta przesyła lub zmienia zdjęcie profilowe.<br>5. Artysta klika "Zapisz profil".<br>6. System waliduje dane.<br>7. System aktualizuje profil artysty.<br>8. System wyświetla komunikat potwierdzający zmianę. |
| **Wyjątki i scenariusze alternatywne** | **Błąd walidacji zdjęcia:**<br>6a. Zdjęcie profilowe jest zbyt duże lub ma niedozwolony format. System wyświetla komunikat o wymaganiach i umożliwia ponowne przesłanie.<br><br> |
| **Warunki końcowe** | Informacje artysty są aktualizowane w systemie. Zmiany są natychmiast widoczne dla odbiorców na publicznym profilu artysty. |
| **Komentarze** | Biografia powinna mieć maksymalnie 1000 znaków. Zdjęcie profilowe powinno być w wysokiej rozdzielczości. |
<br><br>

<!-- PU12 -->
| **Nazwa** | Zmienianie layoutu strony głównej |
| :--- | :--- |
| **Warunki wstępne** | Artysta jest zalogowany. Ma dostęp do sekcji "Ustawienia" > "Układ galerii" lub "Wygląd strony". |
| **Podstawowy scenariusz interakcji** | 1. Artysta przechodzi do sekcji "Ustawienia" > "Układ galerii".<br>2. System wyświetla edytor Bento Box z kafelkami zawierającymi pracami artysty.<br>3. Artysta widzi siatkę, gdzie każdy kafelek pracy ma rozmiar (1x1, 2x1, 1x2, 2x2, itp.).<br>4. Artysta może zmieniać rozmiary kafelków poprzez:<br>   - Resize handles (uchwyty) na krawędziach kafelków - przeciąganie aby zmienić rozmiar<br>   - Klikanie na kafelek i wybór predefiniowanych rozmiarów (mały, średni, duży, extra duży)<br>   - Drag-and-drop aby zmienić pozycję kafelku<br>5. System automatycznie dopasowuje pozycje pozostałych kafelków.<br>6. Artysta może wybrać temat kolorystyczny (jasny/ciemny) i typ czcionki z menu.<br>7. System wyświetla podgląd na żywo zmian.<br>8. Artysta klika "Zapisz układ" aby zatwierdzić zmiany.<br>9. System zapisuje nowy układ kafelków i wyświetla komunikat potwierdzający. |
| **Wyjątki i scenariusze alternatywne** | **Anulowanie zmian:**<br>8a. Artysta klika "Anuluj" lub zamyka edytor bez zapisania. System pyta o potwierdzenie i powraca do poprzedniego układu bez zmian.<br><br>**Przywrócenie domyślnego układu:**<br>9a. Artysta może kliknąć "Resetuj do domyślnego" aby przywrócić automatycznie wygenerowany układ galerii. |
| **Warunki końcowe** | Nowy układ Bento Box jest zapisany i natychmiast widoczny dla wszystkich odbiorców na stronie portfolio artysty. |
| **Komentarze** | Układ powinno być responsywny na mobilu - kafelki automatycznie zmieniają rozmiary na mniejszych ekranach. |
<br><br>
