## Wstęp
<p>Aplikacja składa się z przykładowej strony internetowej stworzonej za pomocą Bootstrapa, oraz zarządzanej pythonowym 
Flaskiem. Przygotowana została pod konteneryzację Dockerem i gotowej do postawienia na App Service Azure z poniżej 
spisanymi komendami do Azure CLI. </p>
<p>Została zaopatrzona w plik Makefile pozwalający aktualizować wymagane przez aplikację, potencjalnie aktualizowane 
frameworki, automatycznie instalować je do wirtualnego środowiska aplikacji i ją uruchamiać.</p>
<p>Dołączona została również funkcjonalność Sentry w pliku run.py pozwalająca monitorować m.in. zasoby i błędy 
oprogramowania.</p>
<br>
<p>Komentarze zawarte w plikach aplikacji są w języku angielskim.</p>

## Wykorzystane zasoby
- Makefile 
- Python i jego frameworki (requirements.txt)
- Sentry
- Docker
- Azure CLI 
- subskrypcja portalu Azure

## Instrukcja

### Zasoby Azure oraz Docker aplikacji internetowej
  1. Logujemy się na nasze konto Azure i tworzymy grupę zasobów z pomocą Azure CLI:
```bash
  az login
_________________________________________________________________

  az group create -l eastus --name caaad79114
```

  2. Możemy wrzucić naszą aplikację do kontenera samego Dockera. Logujemy się do niego lokalną konsolą, tworzymy obraz z
pomocą Dockerfile i uruchamiamy go.
```bash
docker login
_________________________________________________________________

docker image build -t miseiyume/caaad79114 .
_________________________________________________________________

docker container run --detach --publish 8081:5000 --name caaad79114 miseiyume/caaad79114
```
W tym momencie Docker uruchamia instalację, a nasza strona powinna się już poprawnie wyświetlać pod adresem 

"http://localhost:8081".

  3. Następnie tworzymy plan do naszego App Service'u, a następnie samą aplikację mającą zawierać nasz kontener.
```bash
az appservice plan create --name caaad79114plan --resource-group caaad79114 --location eastus --is-linux
_________________________________________________________________

az webapp create --name caaad79114 --plan caaad79114plan --resource-group caaad79114 --deployment-container-image-name miseiyume/caaad79114:latest
```
<p>Adres pod którym możemy od teraz korzystać z naszej strony:</p>

https://caaad79114.azurewebsites.net

### Monitorowanie Sentry
<p>Nasza strona jest objęta monitorowaniem błędów dzięki funkcjonalności Sentry, która działa w tym miejscu:</p>

[Panel Kontrolny Sentry](https://sentry.io/organizations/wsb-wrocaw/issues/?project=6357816) 
<br>

### Funkcjonalność Makefile
<p>W przypadku aktualizacji naszej aplikacji w folderze PiAAC lub zmianie wersji bibliotek możemy użyć funkcji
zapisanych w pliku Makefile wywołując w konsoli funkcjonalność "make" + < komenda ></p>
Komendy są następujące:

- $(VENV)/bin/activate - po zmianie pliku ma za zadanie stworzenie środowiska wirtualnego w aplikacji i pobranie wymagań
 dot. bibliotek.
- run - zależna od $(VENV)/bin/activate - odpowiada za aktywację wirtualnego środowiska aplikacji z pobranymi bibliotekami.
- rerun - jeśli jakikolwiek z plików w folderze /PiAAC/ został zmodyfikowany przerywa działanie aplikacji i uruchamia ją
 na nowo aby wprowadzić zmiany.
- clean - czyści nasze środowisko z pycache i venv.