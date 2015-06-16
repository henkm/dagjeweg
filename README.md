# Dagjeweg
[![Build Status](https://secure.travis-ci.org/henkm/dagjeweg.png)](http://travis-ci.org/henkm/dagjeweg)
[![Gem Version](https://badge.fury.io/rb/dagjeweg.svg)](http://badge.fury.io/rb/dagjeweg)
[![Dependency Status](https://gemnasium.com/henkm/dagjeweg.svg)](https://gemnasium.com/henkm/dagjeweg)
[![Code Climate](https://codeclimate.com/github/henkm/dagjeweg/badges/gpa.svg)](https://codeclimate.com/github/henkm/dagjeweg)
[![Coverage Status](https://coveralls.io/repos/henkm/dagjeweg/badge.png?branch=master)](https://coveralls.io/r/henkm/dagjeweg)

Met deze gem kun je eenvoudig data opvragen via de DagjeWeg.NL API. *Let op:* het is een _read only_ API, dus het is niet mogelijk om data aan te passen.

## Installatie

Voeg deze regel toe aan je Gemfile:

    gem 'dagjeweg'

En voer uit:

    $ bundle

Of installeer het zelf:

    $ gem install dagjeweg

## Gebruik

Mogelijkheden:
- Tip zoeken op naam
- Alle tips voor een plaatsnaam opvragen
- Tips in een straal van x kilometer van een andere tip opvragen
- Lijst met genres opvragen
- Lijst met rubrieken opvragen
- Lijst met tips per genre of rubriek
- Recencies bij een tip opvragen

## Voorbeelden 

```ruby
	# Zoek 20 uitstapjes in de buurt van Amsterdam centrum
	@tips = Dagjeweg::Tip.near(52.3702160, 4.8951680, 20)

	# Zoek uitstapjes in een straal van 5km van een ander uitstapje
	@tips.first.nearby(5)

	# Vraag reviews van een uitstapje op
	@reviews = DagjeWeg::Tip.find(22).reviews
```

## API Key

Voor het gebruik van deze gem heb je een API Key nodig van DagjeWeg.NL. Een API Key kun je aanvragen door een verzoek te sturen naar redactie@dagjeweg.nl.