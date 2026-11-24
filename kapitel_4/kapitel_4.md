---
papersize: a4
geometry: margin=2cm
fontsize: 11pt
linestretch: 1
lang: de-CH
---

<!--
pandoc kapitel_4.md -o kapitel_1.pdf --pdf-engine=xelatex --lua-filter=encadres.lua
-->

# Polyalphabetische Substitution

## Aufgabe 1

### a) Begriffe

- Substitutionschiffre:
  Verschlüsselungsmethode, bei der ein Zeichen mit einem anderen ersetzt wird.
- Monoalphabetische Substitution:
  Substitutionschiffre, bei der jeder Buchstabe eindeutig zu einem anderen
  Buchstaben verschlüsselt wird.
- Homophone Substitution:
  Substitutionschiffre, bei der jeder Buchstabe in mehrere (gleichbleibende)
  Buchstaben verschlüsselt werden kann.
- Polyalphabetische Substitution:
  Substitutionschiffre, bei der jeder Buchstabe abhängig von seiner Position in
  verschiedene Buchstaben verschlüsselt werden kann.
- One-Time-Pad:
  Polyalphabetische Verschlüsselungsmethode, bei der der Schlüssel so lang ist
  wie der Text.
  Informationstechnisch sicher.
- Crib:
  Bekanntes Stück des Klartextes.

Monoalphabetische/homophone Substitutionen werden bereits in Kapitel 3 erklärt.
Polyalphabetische Substitution ist jedoch neu und eine Erweiterung der bereits
bekannten Prozesse.
Das One-Time-Pad ist eine theoretisch unknackbare Verschlüsselungsmethode, sie
ist aber nicht sehr praxistauglich.
Crib ist noch nicht bekannt, aber einfach zu verstehen.

// **TODO**: Zusammentragen in einem Dokument
// **TODO**: Abbildungen

### b) Leitidee

Moderne symmetrische Verschlüsselungsalgorithmen beruhen eigentlich auf der
polyalphabetischen Substitution (Blockchiffren mit den entsprechenden Modi haben
vereinfacht sehr grosse Alphabete, Stromchiffren sind vereinfacht
One-Time-Pads).
Fast jede Verbindung ins Internet erfolgt verschlüsselt mit einer Methode, die
auf der polyalphabetischen Substitution beruht.

Die Schüler*innen sollen lernen, wie diese simple, aber grundlegende
Verschlüsselungsmethode funktioniert und unter welchen Umständen die
Vertraulichkeit gewährleistet ist (oder eben nicht).

### c) Dispositionsziele

- Die Schüler*innen hinterfragen und analysieren selbstständig die Sicherheit
  von Verschlüsselungsmethoden.

// **TODO**: Min. 2 Dispositionsziele

### d) Operationalisierte Lernziele

- Die Schüler*innen können mithilfe der Vigenère-Chiffre einen kurzen, einfachen
  Text mit bekanntem Schlüssel ent-/verschlüsseln.
- Die Schüler*innen können mithilfe von Cribs und anderen Metadaten
  herausfiltern, welche Nachricht am ehesten zu einem bekannten Klartext gehört
  (z.B. bei der Enigma-Verschlüsselung).

\newpage

## Aufgabe 2

## Einführung

// **TODO**: AO?

Nachdem wir uns in der letzten Lektion mit der monoalphabetischen und der
homophonen Substitution beschäftigt haben, betrachten wir diese Woche die
sogenannte polyalphabetische Substitution.
Sie baut auf den vorherigen beiden Substitutionschiffren auf und liegt den
modernen Verschlüsselungsmethoden zugrunde, die ihr jedes Mal nutzt, wenn ihr
ins Internet geht.
Ebenfalls werden wir heute sehen, wie wir die neue Verschlüsselungsmethode
angreifen können indem wir z.B. Teile des Klartextes erraten.
Für mich ist es wichtig, dass Sie verstehen, wie die Methode funktioniert und
unter welchen Umständen sie geknackt werden kann.
Wir werden zuerst eine Variante davon anschauen, sie selber anwenden und
anschliessend anzugreifen versuchen.

## Die Vigenère-Chiffre

In der letzten Lektion haben wir uns mit der monoalphabetischen Substitution
beschäftigt.
Zur Erinnerung:
Die Familie der `ROT`-Verschlüsselungsmethoden können Sie mithilfe der
Alphabetdrehscheiben schnell anwenden.
Das Geheimnis, dass Sie zum verschlüsseln und entschlüsseln brauchen, ist die
Methode selbst und die Position der Drehscheiben.
Diese Verschlüsselungsmethoden sind aber sehr schwach, da Sie nach 26 Versuchen
alle möglichen Texte kennen.
Das Problem ist also, dass alle Buchstaben immer gleich verschlüsselt werden.

::: {.exercise}

**Frage 1:**

Überlegen Sie sich eine Art und Weise, wie sie die Alphabetdrehscheiben für eine
sicherere Verschlüsselungsmethode nutzen können.
Überlegen Sie sich auch, was Sie und die Empfänger*in wissen müssen, um den Text
zu entschlüsseln.
Man sollte den Text immer eindeutig entschlüsseln können.
Tauschen Sie sich hierfür mit einer Kolleg*in aus.

:::

Die Vigenère-Chiffre nutzt dieselbe Idee wie die `ROT`-Verschlüsselungsmethoden,
aber sie behält nicht immer dieselbe Rotation bei.
Stattdessen ändert sich die Ausrichtung der Alphabetdrehscheiben nach jedem
Buchstaben!
Aber wie wissen Sender*in und Empfänger*in, wie sie die Scheibe drehen müssen?
Dafür benötigen sie ein Passwort.

**Beispiel 1:**

Alice und Bob haben sich auf das Passwort `RAT` geeinigt.
Jetzt will Alice einen Brief an Bob schicken.
Der erste Buchstabe des Klartextes wird mit dem ersten Buchstaben des Passworts
verschlüsselt, der zweite Klartextbuchstabe mit dem zweiten Passwortbuchstaben,
etc.
Ist sie am Ende des Passworts angelangt, beginnt sie wieder am Anfang des
Passworts.
Wenn sie Bob also die Nachricht `HOLA` schicken möchte, macht sie das wie
folgt:
Sie nimmt den ersten Buchstaben des Passworts (`R`).
Sie stellt die Scheibe so ein, dass der Passwortbuchstabe `R` im inneren Kreis
unter dem Buchstaben `A` liegt.
Der innere Kreis ist das Klartextalphabet, der Äussere das Geheimtextalphabet.
Jetzt schaut sie, wo auf dem inneren Kreis der erste Buchstabe des Klartextes
liegt (`H`).
Der verschlüsselte Buchstabe ist der Buchstabe, der an derselben Stelle auf dem
äusseren Ring steht (`Y`).
Diesen kann sie aufschreiben.
Anschliessend macht sie dasselbe mit dem zweiten Buchstaben:
Der Passwortbuchstabe ist `A`, also dreht sie den Kreis so, dass das `A` des
inneren Kreises unter dem `A` des äusseren Kreises liegt.
Dann sucht sie auf dem inneren Kreis den zweiten Buchstaben des Klartextes und
schreibt den gegenüberliegenden Buchstaben des äusseren Kreises auf.
So macht Alice weiter, bis sie den ganzen Klartext in Geheimschrift umgewandelt
hat.

::: {.exercise}

**Übung 1:**

Verschlüsseln Sie den Klartext `GERONIMO` mit dem Schlüssel `KRYPTO`.

**Antwort:**

`QVPDGWWF`

**Frage 2:**

Was müssen Sie ändern, um zu entschlüsseln?

**Antwort:**

Kreis gleich ausrichten, aber den Geheimtextbuchstaben am äusseren Ring suchen
und den Buchstaben im inneren Ring aufschreiben.

**Übung 2:**

Versuchen Sie, den Geheimtext `YMLLINKRLWZUILAMOSKQHGPF` mit dem Schlüssel
`GEHEIM` zu entschlüsseln.

**Antwort:**

`SIEHABENESRICHTIGGEMACHT`

**Übung 3:**

Verschlüsseln Sie den Text `HALLOHERRAAL` einmal mit `ROT13` und einmal mit der
Vigenère-Chiffre mit dem Passwort `HAI`.
Was fällt Ihnen auf?

**Antwort:**

`UNYYBUREENYY`: `ROT13`
`OATSOPLRZHLT`: Vigenère

Wir haben viele doppelte Buchstaben im Klartext.
Dies sehen wir bei `ROT13`, aber nicht bei der Vigenère-Chiffre.

**Frage 3:**

Sie haben bisher vielleicht nach jedem Buchstaben die Alphabetdrehscheiben neu
eingestellt.
Gibt es einen Weg, wie Sie dies reduzieren können?

**Antwort:**

Wir können die Scheibe einmal einstellen und dann in Dreierschritten durch den
Klartext durchgehen.
Dann nochmals mit einem anderen Offset, und dann nochmals.
Voilà, wir mussten die Scheibe nur drei mal umstellen!

:::

## Angriffe auf die Vigenère-Chiffre

Eine einfache Häufigkeitsanalyse wie in der letzten Lektion funktioniert hier
nicht mehr.

::: {.exercise}

**Frage 4:**

Stellen Sie sich vor, sie haben einen sehr langen Text, bei der Buchstaben so
häufig vorkommen, wie es in der deutschen Sprache üblich ist.
Wie würden sie hier eine Häufigkeitsanalyse durchführen (vorausgesetzt, sie
kennen die Länge des Passworts)?
Tipp: Schauen Sie sich Frage 3 nochmals an.

**Antwort:**

Wir können die Häufigkeitsanalyse einfach auf jedem zweiten Buchstaben
durchführen.

**Frage 5:**

Wie können Sie die Vigenère-Chiffre sicher nutzen?
Unter welchen Umständen kann man sie einfach knacken?

**Antwort:**

Sicher:

- Langes, zufälliges Passwort
- Keine Abstände

Unsicher:

- Schwaches Passwort, welches man erraten kann
- Abstände zwischen den Wörtern machen es einfach

:::

## One-Time-Pad

Es stellt sich heraus, wenn man die Vigenère-Chiffre richtig verwendet, ist sie
absolut unknackbar.
Wenn das Passwort komplett zufällig ist, so lange wie der Klartext selber und
nie wiederverwendet wird, sagt man dem ganzen "One-Time-Pad".

::: {.exercise}

**Frage 6:**

Warum ist das One-Time-Pad sicher?

**Antwort:**

Es könnte jeder Klartext genutzt worden sein mit derselben Länge.

:::

Wenn man das One-Time-Pad falsch verwendet, kann es aber trotzdem zu Problemen
kommen.

::: {.exercise}

**Übung 6:**

Unterstreichen Sie die jeweils zustimmende Nachricht der folgenden Paare:

- `AQ`/`PRME`
- `SO,UESCY`/`SVIL,VNCJY`
- `AOVIAKYM?MDPK`/`JSEFNUNH?KL`

**Antwort:**

- Links ("JA")
- Links ("JA,GERNE")
- Rechts ("Wirklich?Ja")

**Übung 7:**

Ein Internetshop schickt ihnen den Preis, der über One-Time-Pad verschlüsselt
wurde.
Sie kennen den Preis und wissen, das der Klartext eigentlich `824.13` ist.
Der Geheimtext lautet aber: `238.59`.
Sie kennen den Schlüssel nicht.
Können Sie den Geheimtext so abändern, dass er zu `000.00` entschlüsselt wird?
Tipp: Nehmen Sie sich die Zahlendrehscheiben.

**Antwort:**

Wir können die Drehscheiben so drehen, dass der Klartext den Geheimtext erzeugt.
Dann können wir einfach die Zahl eingeben, die neben der Klartext `0` liegt.

:::

## Die Enigma

Die Enigma ist der Name der Verschlüsselungsmaschine, die von Deutschland im
zweiten Weltkrieg verwendet wurde.
Sie rotierende Walzen mit Drähten darin, um das momentane Substitutionsalphabet
zu bestimmen.
Sie hatte aber eine sehr prägnanten Schwachstelle:
Ein Buchstabe im Klartext konnte nicht auf sich selbst verschlüsselt werden.
D.h., ein Klartext von 100 `A`s würde im Geheimtext niemals auch nur ein
einziges `A` haben.

::: {.exercise}

**Übung 8:**

Die Alliierten wussten, dass früh morgens ein Funk herausging, der den täglichen
Wetterbericht meldete.
Er begann immer mit dem Wort `WETTERBERICHT`.
Einer solchen bekannten Teilnachricht sagt man "Crib"
Welcher der folgenden Geheimtexte könnte den Wetterbericht enthalten?

- `WZGKPXBKBKTGQ`...
- `ASWKVIUBPFNBZ`...
- `FZXWPRXWEOZWX`...
- `CVMQDPQVBFGWY`...
- `MQCMWMQNMBXPI`...
- `AZPCJVGFPWPET`...

**Antwort:**

- Nein (`W` am Anfang)
- Ja
- Nein (`R` in der Mitte)
- Ja
- Nein (`T` am Schluss)

:::
