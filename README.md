Vorbereitung
============

* Mache die folgenden Abschnitte von http://guides.rubyonrails.org/index.html offline verfügbar:
    * Models
    * Views
    * Controllers
    * Digg Deeper
        * Active Support Core Extensions
        * Rails Internationalization API
        * Active Job Basics
        * Securing Rails Applications
        * Debugging Rails Applications
        * Configuring Rails Applications
        * Rails Command Line Tools and Rake Tasks
        * Asset Pipeline
        * Working with JavaScript in Rails

* Setze dein System auf und stelle sicher, dass der Test läuft und grün ist. (`rake test`)

* Diese Themen werden behandelt:
    * CSS-Selektoren
    * Scopes
    * Scaffolding
    * Session
    * Nested Forms


Anfangs Zustand
===============

* 0 von 27 Tests

Aufgabe
======

Lege die folgenden Model durch Scaffolding an.

Scaffold
-------

* Product
    * Name: string
    * price: float
    * weight: float
* Cart
    * hat einen Customer
* Customer
    * first_name: string
    * last_name: string
    * email: string
    * ship_address: Addresse
    * bill_address: Addresse
* Address
    * street: string
    * zip_code: string
    * city: string
    
Weiteres Vorgehen
-----------------

* Erzeuge die notwendigen Join-Tabellen
* Lege das Model Order < Cart an ("Order" erbt von "Cart") und den Controller "Order".
* Der `root_path` soll auf `'products#index'` zeigen.
* Hinweis: Frühzeitig `accepts_nested_attributes_for ...` in die entsprechenden Modelle einfügen, sonst kommt es zu merkwürdigen Fehlermeldungen.


Abgabe
======

Kopiere diesen ganzen Ordner auf den USB-Stick. Benenne den Ordner in deine Matrikelnummer um!