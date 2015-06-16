# Dagjeweg
[![Build Status](https://secure.travis-ci.org/henkm/dagjeweg.png)](http://travis-ci.org/henkm/dagjeweg)
[![Gem Version](https://badge.fury.io/rb/dagjeweg.svg)](http://badge.fury.io/rb/dagjeweg)
[![Dependency Status](https://gemnasium.com/henkm/dagjeweg.svg)](https://gemnasium.com/henkm/dagjeweg)
[![Code Climate](https://codeclimate.com/github/henkm/dagjeweg/badges/gpa.svg)](https://codeclimate.com/github/henkm/dagjeweg)

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

## Informatie

De volgende velden kunnen worden opgevraagd van iedere tip:

|Naam|Type|Omschrijving|
|----|----|-------------|
|id|Integer|DagjeWeg.NL ID, correspondeert met URL op www.dagjeweg.nl|
|name|String|Naam van het uitstapje|
|google_name|String|SEO geoptimaliseerde naam|
|description|Text|Korte omschrijving|
|long_description|Text|Langere omschrijving (soms met HTML)|
|genre|String|Genre|
|address|String|Adres|
|city|String|Plaatsnaam|
|email|String|E-mail adres|
|phone|String|Telefoonnummer|
|url|String|URL van het uitstapje|
|dwurl|String|URL van het uitstapje op DagjeWeg.NL|
|longitude|Float|Longitude coordinaat|
|latitude|Float|Latitude coordinaat|
|period|String|Geopend in periode (hele jaar, zomer,etc.)|
|ma, di, wo, do, vr, za, zo|Boolean|Open op deze dagen|
|from_time|String|Open vanaf (bijv. "10:00")|
|until_time|String|Open tot|
|open_comment|Text|Opmerking over openingstijden|
|price|Integer|Reguliere prijs in centen|
|price_kids|Integer|Kinderprijs in centen|
|price_toddlers|Integer|Baby/Peuterprijs in centen|
|price_seniors|Integer|Seniorenprijs in centen|
|show_price|String|Alle prijzen in HTML formaat|
|accessible|Boolean|Toengankelijk voor mindervaliden|
|accessible_comment|Text|Opmerkingen over toengankelijkheid|
|wheelchair|Boolean|Rolstoelvoorzieningen|
|wheelchair_toilet|Boolean|Invalidentoilet|
|number_of_reviews|Integer|Aantal beoordelingen|
|show_image|String|URL naar afbeelding (voorkeur)|
|image|String|evt. URL naar afbeelding|
|image2 .. image13|String|evt. URL naar afbeelding|
|distance|Decimal|Afstand naar dit uitstapje (alleen bij #near en #nearby)|


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