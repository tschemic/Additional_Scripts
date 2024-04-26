#shiny #R #rhino 

# Tag1 - Workshops

## Rhino Masterclass Workshop
Unterlagen siehe: [GitHub - Appsilon/rhino-masterclass](https://github.com/Appsilon/rhino-masterclass)

Lokale Unterlagen siehe: "C:\Users\micha102\OneDrive - AGES\Kurse Schulungen\20240417_ShinyConf2024\Tag1_Workshops\Rhino Masterlcass"

Der Workshop zeigt, wie man Shiny Apps mit rhino entwickelt.
rhino benötigt für manche Funktionen nodejs. Falls nodejs nicht installiert werden kann, kann man im rhino.yml File "sass: r" statt dem Default "sass: node" eintragen und dann verwendet rhino nodejs aus R Package.

Öffnet man ein rhino Projekt, muss man zuerst immer renv::restore() ausführen um eventuell benötigte Packages zu installieren.
Startet man ein neues rhino Projekt, kann man das über den Punkt in RStudio (Neues Projekt) machen oder im aktuellen Working Directory mittels rhino::init(). Dann wird automatisch die Standardstruktur von rhino angelegt und man kann mit der Shiny-App Entwicklung starten.

Styling mit CSS (Task 4):
CSS direkt in main.R (oder app.R) nennt man in-line Style, das ist discouraged.
CSS sollte besser in separates File, bei rhino in main.scss

Testing mit Cypress (task 5):
Cypress ist zum Testen von Shiny Apps. Ist oft leichter als testthat oder shinytest2.
Die verschiedenen Tools können aber auch kombiniert werden.
`rhino::test_e2e()` testet die App end-to-end.
`rhino::test_e2e(interactive = TRUE)` öffnet eine Cypress Console.
Die Tests für Cypress können in app.cy.js definiert werden, unter tests/cypress/e2e.
Cypress kann Inputs in der App eingeben im Test und checken, ob die App richtig reagiert auf den Input.
Das muss alles im Test definiert werden.

## Shiny 101: The Modular App Blueprint
Unterlagen: https://github.com/hypebright/shinyconf2024-shiny101

Lokale Unterlagen siehe: "C:\Users\micha102\OneDrive - AGES\Kurse Schulungen\20240417_ShinyConf2024\Tag1_Workshops\Shiny101"

bindEvent() ist eine neue Funktion um Outputs zu binden an zB einen Input (zB Button). So kann man die eagerness von Outputs bremsen.
bindEvent() wird einfach per Pipe an den Output angehängt. (siehe 01_start.R)

Observers sind dazu da um side effects zu definieren - das sind events die außerhalb der App stattfinde - zB in eine DB schreiben oder print to console.
Observes sind ebenfalls "eager", so wie Outputs und können auch mit bindEvent() kontrolliert werden.
Das ist dann die neue Version aber identisch mit observeEvent().

Reactives sind "lazy" im Gegensatz zu zB Outputs. Sie aktualisieren nur dann, wenn sie von anderer Stelle gecalled werden **und** die Dependencies sich geändert haben.
Nur weil sich die Dependencies geändert haben, werden reactives noch nicht erneuert. Erst wenn sie von anderer Stelle benutzt werden. Das gilt für reactive(), reactiveValue() und reactiveValues().

Module:
Module sind abgetrennte Teile, die in der eigentlichen App verwendet werden können (auch öfters). Es sind eigentlich Funktionen, die aber aus einem UI Teil und einem Serverteil bestehen (so wie die App selbst).
Module haben ihren eigenen namespace - das heißt Ids müssen nur innerhalb eines Moduls unique sein. Dafür müssen Ids im UI Teil immer mittels ns() diesem namespace zugewiesen werden, wobei ns() einmal im Modul definiert werden muss mittels "ns <- NS(id)".
Somit werden alle Ids im Modul in den namspace der id gegeben, die beim Call des Moduls zB in der eigentlichen App angegeben wird in der Modulfunktion.

Wo kann man Modulcode hingeben? 
Entweder am Beginn des app.R Files (= die global Section, wo auch zB library() Calls und sonstige Imports sind), 
oder in einen Ordner mit Namen "R" (dieser wird von Shiny automatisch gesourced), 
oder in einem anderen Ordner im App-Ordner (diesen muss man dann im global Teil der app.R sourcen mit source(path_to_module.R)).

Module können auch nested sein, also ein Modul in einem anderen Modul verwendet werden.

Sharing data between Modules (and the main part of the app):
Das geht am besten mittels reactiveValues(). 
Man kann Objekte zum Sharen in reactiveValues() geben und diese dann als zusätzliches Argument (neben der id) an ein Modul übergeben um das Objekt dort zu nutzen.
Man sollte dabei nur darauf achten, dass man das reactiveValues() Objekt am Start der App initialisiert (zB mit NULL für die Teile im Objekt) - am besten am Beginn in der Server-Funktion der App direkt in app.R.

Dynamically calling modules:
Dafür muss immer lapply() verwendet werden und kein for() Loop - es funktioniert nicht mit dem for() Loop.
Das heißt, wenn man ein Modul mehrmals auf Komponenten einer Liste/eines Vektors callen möchte, dann immer mit lapply().



# Tag2

## How I Built an API for My Life
#plumber #API

Finance API:
In Google Sheets gibt es Funktion zum beziehen von Stock Price Data.
google4r erlaubt es Google sheets mit R auszulesen, wurde in pulmber API geleitet.

API calls wurden ale ganzes in tryCatch verpackt mit alternativem Output, falls Abfruf nicht möglich.

APIs wurden gesichert - man muss sich anmelden um API Antwort zu beziehen - geht mit plumber.

## Unlocking Shiny's Potential with httr2
#httr2 #API 

[GitHub - r-lib/httr2: Make HTTP requests and process their responses. A modern reimagining of httr.](https://github.com/r-lib/httr2)

RESTful architecture is a stateless communication. No state is saved upon API request - every request is identical.

Current version of httr2 is stable now, since a few months. Should replace httr in the future.
httr2 is tidyverse compatible (e.g. piping).
With shiny caching API calls is possible - for repeated identical calls.
Mit shiny kann man somit eine stateful architecture erzeugen.

Am besten immer tryCatch verwenden für API calls um Fehler abzufangen.
Je nach API Fehlercode kann man unterschiedliche Aktionen definieren bei Fehlermeldungen (zB Abbruch oder erneuter Versuch).

## Keynote: Shaping the Next 10: The Bright Future of Shiny

Shiny in Quarto erlaubt es in Quarto Dokumente Shiny Bestandteile einzubauen.
ShinyExpress erlaubt es App direkt im Browser der User laufen zu lassen ohne einen Shiny Server zu benötigen.
Man kann normale Shiny Apps konvertieren in ShinyExpress Apps. Das geht mit dem shinylive Package.
Es ist bereits möglich ChatGPT und CoPilot in RStudio zu verwenden.

## {shiny.tictoc} measuring Shiny performance

[GitHub - Appsilon/shiny.tictoc: Measuring shiny performance in the browser.](https://github.com/Appsilon/shiny.tictoc)

Problem mit shinyloadtest zur Performance-Messung von Apps ist, dass man zusätzliche Software braucht, die man installieren müsste. Ist oft nicht möglich.

Problem mit profvis um die Performance einer Shiny App zu messen (und auch shinyloadtest) ist, sie messen nicht den JS Code, der im Browser läuft.

shiny.tictoc inkludiert alles bei der Performance-Messung und braucht keine zusätzliche Installation - auch kein zusätzliches R Package. Man inkludiert nur einen tag in der App (mit der URL zu einer JS Datei).
Es ist eine Ergänzung zu den Tools für Performance Tests, die es sonst gibt.

## Road Mapping in Real Time

Haben redis verwendet zum Austausch von Daten zwischen Shiny App und anderen Programmen. redis ist ein in-memory data storage Programm. Es muss aber installiert werden und ist nur für Linux verfügbar.

## CougarStats: An R Shiny App for Statistical Data Analysis

Das ist eine öffentlich zugängliche, freie ShinyApp um statistische Analysen selbst durchzuführen. Der Code ist auf Github und man kann die App somit auch lokal laufen lassen.
Wurde entwickelt von einem Studenten an einer kanadischen Universität.
www.cougarstats.ca

## {litter}; dynamic inputs for Shiny

SLides: [{litter} (john-coene.com)](https://john-coene.com/talks/shinyconf2024/#/title-slide)
[GitHub - devOpifex/litter: :no_entry_sign: Lit components for shiny](https://github.com/devOpifex/litter)

litter addresiert das Problem, dass bei dynamisch erzeugten Inputs die Id eventuell nicht mehr unique ist, was nicht erlaubt ist in Shiny.

## Keynote: It's not just code: surviving and thriving as an open source maintainer

## Beyond Async: Intra-Session Concurrency in Shiny with ExtendedTask
#ExtendedTask
Joe Cheng CTO, Posit
Slides: https://rpubs.com/jcheng/beyond-async

Zuerst sollte man nach anderen Möglichkeiten suchen um eine App schneller zu machen (Code optimieren, Caching, ...). Aber manche Operationen sind einfach langsam (zB eine langsame API, Compiling einen großen Output ,...).
Für solche lang dauernden Operationen ist ExtendedTask gedacht.
Es erlaubt diese im Hintergrund auszuführen ohne dass die App unbenutzbar ist in der Zeit.
Man kann auch mehrere dieser lang dauernden Operationen parallel im Hintergrund laufen haben.
Anstatt in einem reactive({}) wird der Code dieser Operation in ein ExtendedTask Objekt (=S6 Objekt) gegeben und innerhalb einer future Funktion (aus future Package).
future Package ist ein generelles Packages um R Prozesse im Hintergrund laufen zu lassen.
Es gibt auch andere Packages, die das Gleiche machen mit Vor- und Nachteilen. (mirai, crew, future.mirai - combines both packages)

Shiny Async war ein erster Versuch dieses Problem zu lösen. Es war aber kompliziert und hat nicht alle Probleme gelöst. ExtendedTask ist nun deutlich einfacher und löst das Problem besser.

## Unlocking New Technologies With Shiny

Vorstellung eines Projektes, in dem AI calls in eine Shiny (for python) App eingebaut wurden.

## Shiny Express: a quicker, simpler way to develop Shiny applications

Shiny Express ist in Python, hat aber einen neuen Synthax verglichen mit dem Shiny for Python Core Synthax.
Vorteil: Es ist einfacher, braucht weniger Code, ist gut für Beginner
Nachteil: Nicht so gut für große, komplexe Apps; (noch) nicht geeignet für Module
Es wurde ursprünglich entwickelt für Shiny in Quarto, kann aber jetzt auch für ganze Shiny Apps verwendet werden.

## Keynote: Beyond the Hype: Real-World Use Cases for AI in Shiny

Vortragende verwendet ChatGPT um Code Snippets zu erstellen, aber auch für Code Übersetzungen (zB Python -> R) und automatische Kategorisierungen.
Weiters wird ChatGPT aus der Shiny App heraus verwendet für Recherchen basierend auf Daten aus der App. Die App erstellt den möglichst spezifischen Prompt für ChatGPT und fragt diesen dann ab.
ChatGPT Abfrage in Shiny: Mittels API call mit httr, Spezifikationen wurden einfach als key:value Paare übermittelt (comma separated).

## Modern Shiny Dashboards with bslib
#bslib

rstudio.github.io/bslib

bslib ermöglicht es in Shiny aktuelles Bootstrap 5 zu verwenden anstatt der Shiny Default Version 3.
bslib ist nützlich nicht nur für Shiny Apps, auch für Quarto/Markdown/Bookdown oder Shiny for Python. Es ist auch gut für Apps für mobile Geräte geeignet.
Es gibt eine App (build-a-box, Link in bslib doc) wo man zB Value Box Elemente von bslib interaktiv ausprobieren kann.

## login: User Authentication for Shiny Applications
[GitHub - jbryer/login: Shiny Login Module](https://github.com/jbryer/login)

Ist ein neues Package für login in Shiny Apps. shinymanager oder shinyauthr sind alternative Packages dafür.
login erlaubt es User, einen eigenen Account zu machen bzw. das eigene Passwort zu ändern.
Kann die Zugangsdaten in jeder DBI kompatiblen DB speichern.
Das ist der Vorteil gegenüber den bestehrenden Packages.
Cookie Support ist optional und User Aktivität wird geloggt (Einloggen/Ausloggen).
Der Shiny Server sieht nur das verschlüsselte Passwort, Verschlüsselung passiert auf der Client-Seite.

## The Rhinoverse Journey: Innovating with Open Source
#rhino

[Rhinoverse: Open-Source R Packages for Enterprise Shiny Apps](https://rhinoverse.dev/#rhino)

Rhinoverse ist eine Sammlung von Packages von Appsilon rund um das rhino Package.
Diese Packages erlauben es, professionelle Shiny Apps zu erstellen inkl. vorgegebener Strukturen und Tools zum Testen.

Neu im letzten Jahr darunter ist shiny.telemetry - ein Package um das User-Verhalten in der App zu tracken für Auswertungen.
Ebenfalls neu ist shiny.emptystate - ist ein Package, dass es erlaubt etwas anzuzeigen, wenn das vorgesehene Objekt leer ist (anstatt einer leeren Tabelle, weil noch nichts ausgewählt ist).
Das dritte neue Package ist reactable.extras - es erlaubt das Erstellen von interaktiven Tabellen in Shiny Apps.

Neuigkeiten im rhino Package im letzten Jahr:
RStudio Addins für rhino Funktionen wurden inkludiert (siehe Addins Drop-down Menü in RStudio).
Support für shiny.autoreload wurde inkludiert - App wird nach Speichern des Fies automatisch aktulaisiert.
rhino verwendet renv für das Package Management, hat aber zusätzlich noch eine dependencies.R Datei, in der neu installierte oder entfernte Packages eingetragen werden mussten. Jetzt gibt es die Funktionen rhino::package_install() bzw. rhino::package_remove(), die die Installation/Deinstallation ünernehmen und die dependencies.R Datei auch aktualisieren.

## Shinylive: Serverless Shiny apps
#shinylive

[GitHub - posit-dev/shinylive: Run Shiny on Python and R (compiled to wasm) in the browser](https://github.com/posit-dev/shinylive)

shinylive erlaubt es Shiny Apps im Browser des Users laufen zu lassen, ohne dass man einen Shiny Server braucht. Man braucht nur einen einfachen Webserver.
shinylive verwendet aktuelles bslib.
shinylive::export() kann normale Shiny App konvertieren. Der Export muss aber in einen {webr} Shiny app Ordner. Dieser muss gehostet sein um die App über einen Browser erreichen zu können (kann auch lokal sein).
Das Hosting kann aber zB auf GitHub Pages erfolgen mittels GitHub Actions - ist gratis für public repos.
GitHub Pages hostet nämlich statische Websites.
Aktivierung im GitHub Repo: Settings > Pages > Build and Deployment > Source > GutHub Actions



# Tag 3

## Tailoring Shiny for Modern Users

Wichtig ist ein Dashboard nicht zu überladen - wenig Text und wenige Charts auf Startseite.
Man kann ausklappbare Sektionen machen, um mehr Daten/Info zu zeigen in Shiny.
Karussell kann man auch verwenden in Shiny - schiebt nach links/rechts um zB unterschiedlichen Text zu zeigen.

## {RMarkdown2Quarto} Shiny App for Switching to Quarto
#Quarto

Es wurde eine Shiny App erstellt, in der man Markdown Files hochladen kann und diese werden dann in Quarto Files konvertiert. Die können dann wieder heruntergeladen werden.

Der Code liegt auf GitHub (MounaBelaid/RMarkdown2Quarto). Man kann die App also auch klonen und lokal laufen lassen.
Dann kann man auch ganze Ordner auswählen und alle Files dort im Patch konvertieren.

## JOBlikatoR: How R-Shiny & GPT-3.5 helps you to land your dream job

Shiny App zum Erstellen von CVs und Bewerbungen, die als Input neben den eigenen Daten auch die Stellenbeschreibung verwendet. Sie erstellt mit Hilfe von ChatGPT einen an die jeweilige Stellenbeschreibung und Firma angepassten CV und ein Bewerbungsschreiben.

## Elevating Software Development: Strategies for Quality Assurance Integration

Überblick über die Integration von Quality Assurance bei Appsilon.
## Persistent User Sessions in R Shiny: httpOnly Cookies and Custom Routing
#cookies

Mit Cookies kann man die App so machen, dass nach Login der User auf seine Seite kommt, so wie sie beim letzten Besuch war bzw. die User Einstellungen geladen werden.
Es wurden hier httpOnly Cookies verwendet - sind sicherer. Das geht mit {cookies} Package.
Das Setzen und Auslesen der Cookies erfolgt über JS Kommandos.

Beispiel App dafür:
github.com/ESCRI11/shinyCookiesToyApp

Es wird beim Login auch die E-mail als Cookie gespeichert um zB User-spezifische Einstellungen zu laden. Aus Sicherheitsgründen wird das Cookie verschlüsselt mit sodium.
Mit Cookies ist es auch möglich, dass das Login entfällt. Nach dem ersten Login wird ein Cookie im Browser gespeichert und dann erfolgt das Login automatisch.

## Keynote: Decade of Shiny in Action: Case Studies from Three Enterprises


## Getting The Most Out Of Test-Driven Development For Shiny

Bei Test-Driven Development (TDD) werden zuerst die Test geschrieben, die erfüllt werden müssen, bevor man den Code für die Software scheibt.
Dann schreibt und verbessert man den Code bis die Tests erfüllt sind.
In Shiny Apps werden zB Tests für einzelne Module geschrieben.


## Keynote: Reproducible data science with webR and Shinylive
#shinylive #Quarto

{p3m} ist der Posit Package Manager (hat auch Weboberfläche). Damit kann man Package Versionen zu einem bestimmten Zeitpunkt in der Vergangenheit abrufen.
Das kann hilfreich sein, wenn man bestimmte Versionen benötigt für zB alte Skripts, die man wieder ausführt.

WebAssembly ist ein portable binary Code Format. Es läuft im Browser und hat sehr gute Performance.
webR ist eine Version des R Interpreters, der im Browser läuft, also R Code im Browser ausführen kann.
Bsp Seite für webR: https://webr.r-wasm.org/v0.3.2
Mit webR kann man Code im Browser direkt in Quarto Dokumenten (zB Quarto HTML Präsentation im Browser) ausführen und damit wird die Präsentation interaktiv.
Shinylive nützt WebAssembly damit die Shiny App im Browser des Users läuft. Alles was man braucht ist ein statischer Webserver. Der liefert die Website mit der Shiny App inkludiert aus und diese läuft dann im Browser des Users. Damit gibt es auch nicht das Problem, dass der R Code den Server überlastet, weil zB viele User ihn gleichzeitig nutzen.

Für Quarto gibt es eine webR Extension um shinylive in Quarto Dokumente zu integrieren.
Man kann mit shinylive die Shiny App auch als binary exportieren. Die binary läuft dann überall, wo irgendwein Webserver zur Verfügung steht.

Mit der nächsten, jetzt kommenden Version von webR werden auch die verwendeten Packages mit inkludiert in die App (in der jeweiligen Version bei Erstellung der App).
Zur Zeit werden Packages noch jedes mal in der aktuellsten Version bezogen, wenn die shinylive App startet.

Nicht alle R Packages funktionieren zur Zeit in WebAssembly.
Innerhalb von shinylive kann man Files von Servern downloaden, aber nicht von allen Servern. Kommt auf den Server an. Das hat Sicherheitsgründe. Der Webserver muss es erlauben.

## Demystifying Shiny modules

Bei großen Apps empfiehlt es sich, diese in Module aufzuteilen.
Beim Konvertieren einer 1-File App ist der 1. Schritt das Decomposing.
Dabei identifiziert man die einzelnen Teile der App (= zusammenhängende UI und Server Bestandteile).
Diese Teile gibt man dann in einzelne Module.
In die eigentliche App gibt man dann nur die Funktionen, die die Module aufrufen (sowohl in UI als auch in Server Funktion).
Wichtig dabei ist, dass man Ids in Modulen immer in Namespaces gibt.
Die einzelnen Module werden gesourced am Beginn des App Codes.
Man kann die Module auch einfach öfters verwenden in der App.
