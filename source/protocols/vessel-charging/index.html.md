---
title: Vessel Charging

language_tabs: # must be one of https://git.io/vQNgJ
  - javascript
  - typescript

toc_footers:
  - Documentation powered by <a href="https://github.com/lord/slate" target="blank">Slate</a>.

search: true
---

<p class="header-image"><img src="/images/vessel_charging/header.png" alt="Vessel Charging"></p>

# Vessel Charging Protocol

The communication protocol for vessel charging describes the format of a request for a charging service (`need`), and the response sent by a charging provider (`bid`).

For example, an autonomous boat might search for charging stations within 2 km of the given coordinates that are capable of docking a 1200 kg boat.

In response, a charging station might send back a bid with a price for the service, the opening and closing times, and the full list of services it offers.

# Need

A statement of need for charging services. Typically this will be sent by an electric boat that is looking for a charging station around certain coordinates.

This request is sent to the discovery engine which broadcasts the need to DAV identities that can provide this service. <a href="#bid">Bids</a> are later received in response.

## Arguments

```javascript
const { SDKFactory } = require('dav-js');
const { NeedParams, enums } = require('dav-js/dist/vessel-charging');
const DAV = SDKFactory({
  apiSeedUrls,
  kafkaSeedUrls,
});
const boat = await DAV.getIdentity(boatDavId);

const needParams = new NeedParams({
  location: {
    lat: 32.050382,
    long: 34.766149,
  },
  radius: 20,
  startAt: 1538995253092,
  dimensions: {
    length: 50,
    width: 15,
    height: 20,
  },
  weight: 50000,
  batteryCapacity: 4,
  currentBatteryCharge: 45,
  energySource: enums.EnergySources.Solar,
  amenities: [enums.Amenities.Docking],
});
const need = await boat.publishNeed(needParams);
```

```typescript
const { SDKFactory } = require('dav-js');
const { NeedParams, enums } = require('dav-js/dist/vessel-charging');
const DAV = SDKFactory({
  apiSeedUrls,
  kafkaSeedUrls,
});
const boat = await DAV.getIdentity(boatDavId);

const needParams = new NeedParams({
  location: {
    lat: 32.050382,
    long: 34.766149,
  },
  radius: 20,
  startAt: 1538995253092,
  dimensions: {
    length: 50,
    width: 15,
    height: 20,
  },
  weight: 50000,
  batteryCapacity: 4,
  currentBatteryCharge: 45,
  energySource: enums.EnergySources.Solar,
  amenities: [enums.Amenities.Docking],
});
const need = await boat.publishNeed(needParams);
```

<table class="arguments">
  <tr>
    <td>
      <code class="field">location</code>
      <div class="type required">required</div>
    </td>
    <td>The coordinates around which to search</td>
  </tr>
  <tr>
    <td>
      <code class="field">radius</code>
      <div class="type required">required</div>
    </td>
    <td>Radius in meters around the coordinates in which to listen for bids. Specified as an integer</td>
  </tr>
  <tr>
    <td>
      <code class="field">startAt</code>
      <div class="type">optional</div>
    </td>
    <td>The time at which the requester would like to arrive at charger (if undefined, the arrival time will be ASAP). Specified as time in seconds since <a href="https://en.wikipedia.org/wiki/Unix_time" target="blank">Epoch/Unix Time</a></td>
  </tr>
  <tr>
    <td>
      <code class="field">dimensions</code>
      <div class="type">optional</div>
    </td>
    <td>The minimum length, width, and height clearance that this vessel requires from the charger. Specified as an object containing integers representing centimeters</td>
  </tr>
  <tr>
    <td>
      <code class="field">weight</code>
      <div class="type">optional</div>
    </td>
    <td>The weight of this vessel. Specified as an integer representing grams</td>
  </tr>
  <tr>
    <td>
      <code class="field">batteryCapacity</code>
      <div class="type">optional</div>
    </td>
    <td>The vessel's total battery capacity, specified in kWh</td>
  </tr>
  <tr>
    <td>
      <code class="field">currentBatteryCharge</code>
      <div class="type">optional</div>
    </td>
    <td>The vessel's current battery charge level, as it was at the time the request was sent. Specified as an integer denoting percentage of full capacity</td>
  </tr>
  <tr>
    <td>
      <code class="field">energySource</code>
      <div class="type">optional</div>
    </td>
    <td>Limit the request to only receive bids from chargers using a specific source of energy. Specified as an energy source id. See <a href="#energy-sources">Energy Sources</a></td>
  </tr>
  <tr>
    <td>
      <code class="field">amenities</code>
      <div class="type">optional</div>
    </td>
    <td>A list of amenities that need to be present at charging station. Specified as an array of amenity ids. See <a href="#amenities">Amenities</a></td>
  </tr>
</table>

# Need filter

Begin listening for incoming needs that match certain requirements. Typically this will be a charging station subscribing to incoming needs from electric boats.

## Arguments

```javascript
const { SDKFactory } = require('dav-js');
const { NeedFilterParams } = require('dav-js/dist/vessel-charging');
const DAV = SDKFactory({
  apiSeedUrls,
  kafkaSeedUrls,
});
const charger = await DAV.getIdentity(chargerDavId);

const needFilterParams = new NeedFilterParams({
  location: {
    lat: 32.050382,
    long: 34.766149,
  },
  radius: 1000,
  dimensions: {
    length: 120,
    width: 80,
    height: 100,
  },
});
const needs = await charger.needsForType(needFilterParams);
```

```typescript
const { SDKFactory } = require('dav-js');
const { NeedFilterParams } = require('dav-js/dist/vessel-charging');
const DAV = SDKFactory({
  apiSeedUrls,
  kafkaSeedUrls,
});
const charger = await DAV.getIdentity(chargerDavId);

const needFilterParams = new NeedFilterParams({
  location: {
    lat: 32.050382,
    long: 34.766149,
  },
  radius: 1000,
  dimensions: {
    length: 120,
    width: 80,
    height: 100,
  },
});
const needs = await charger.needsForType(needFilterParams);
```

<table class="arguments">
  <tr>
    <td>
      <code class="field">location</code>
      <div class="type required">required</div>
    </td>
    <td>The coordinates around which to listen for bids</td>
  </tr>
  <tr>
    <td>
      <code class="field">radius</code>
      <div class="type required">required</div>
    </td>
    <td>Radius in meters around the coordinates in which to listen for bids. Specified as an integer</td>
  </tr>
  <tr>
    <td>
      <code class="field">maxDimensions</code>
      <div class="type required">required</div>
    </td>
    <td>The maximum length, width, and height clearance that this charger can accomodate. Specified as an object containing integers representing centimeters</td>
</table>

# Bid

A bid to provide a charging service. Typically sent from a charger to an electric boat.

## Arguments

```javascript
const { BidParams } = require('dav-js/dist/vessel-charging');

needs.subscribe(need => {
  const bidParams = new BidParams({
    ttl: Date.now() + 3600000,
    price: [
      '15000000000000000000',
      { amount: '1000000000000000000', type: 'flat', description: 'Tax' },
    ],
    entranceLocation: {
      lat: 32.050382,
      long: 34.766149,
    },
    exitLocation: {
      lat: 32.050382,
      long: 34.766149,
    },
    locationName: 'Marine Programs Naval Science'
    locationNameLang: 'eng'
    locationCity: 'Vallejo',
    locationPostalCode: '94590',
    locationCounty: 'Solano',
    locationState: 'CA',
    locationCountry: 'USA',
    availableFrom: Date.now(),
    availableUntil: Date.now() + 3600000,
    energySource: EnergySources.Hydro,
    amenities: [Amenities.Park],
    provider: 'HoldenCharge',
    manufacturer: 'Holden Tech LLC',
    model: 'MegaBolt',
  });
  const bid = await need.createBid(bidParams);
});
```

```typescript
const { BidParams } = require('dav-js/dist/vessel-charging');

needs.subscribe(need => {
  const bidParams = new BidParams({
    ttl: Date.now() + 3600000,
    price: [
      '15000000000000000000',
      { amount: '1000000000000000000', type: 'flat', description: 'Tax' },
    ],
    entranceLocation: {
      lat: 32.050382,
      long: 34.766149,
    },
    exitLocation: {
      lat: 32.050382,
      long: 34.766149,
    },
    locationName: 'Marine Programs Naval Science'
    locationNameLang: 'eng'
    locationCity: 'Vallejo',
    locationPostalCode: '94590',
    locationCounty: 'Solano',
    locationState: 'CA',
    locationCountry: 'USA',
    availableFrom: Date.now(),
    availableUntil: Date.now() + 3600000,
    energySource: EnergySources.Hydro,
    amenities: [Amenities.Park],
    provider: 'HoldenCharge',
    manufacturer: 'Holden Tech LLC',
    model: 'MegaBolt',
  });
  const bid = await need.createBid(bidParams);
});
```

<table class="arguments">
  <tr>
    <td>
      <code class="field">ttl</code>
      <div class="type">optional</div>
    </td>
    <td>This bid will expire at this time. Specified as time in seconds since <a href="https://en.wikipedia.org/wiki/Unix_time" target="blank">Epoch/Unix Time</a></td>
  </tr>
  <tr>
    <td>
      <code class="field">price</code>
      <div class="type required">required</div>
    </td>
    <td>A single price or an array containing prices. If an array is given, all the prices will be charged (e.g., a price per kWh plus a flat rate tax). Each price is specified as either an string representing Vinci, or a price object containing amount, <a href="#price-types">price type</a>, and an optional description
    <br>1 DAV == 1e18 Vinci == 1000000000000000000 Vinci</td>
  </tr>
  <tr>
    <td>
      <code class="field">entranceLocation</code>
      <div class="type">optional</div>
    </td>
    <td>The coordinates of the charger entrance</td>
  </tr>
  <tr>
    <td>
      <code class="field">exitLocation</code>
      <div class="type">optional</div>
    </td>
    <td>The coordinates of the exit from to the charger</td>
  </tr>
  <tr>
    <td>
      <code class="field">locationName</code>
      <div class="type">optional</div>
    </td>
    <td>A human readable name/description of the charger location (e.g., Cal Maritime Dock C)</td>
  </tr>
  <tr>
    <td>
      <code class="field">locationNameLang</code>
      <div class="type">optional</div>
    </td>
    <td>The language used in <code>location_name</code>. Specified using the 3 letter <a href="https://en.wikipedia.org/wiki/ISO_639-3" target="blank">ISO 639-3</a> language code</td>
  </tr>
  <tr>
    <td>
      <code class="field">locationHouseNumber</code>
      <div class="type">optional</div>
    </td>
    <td>The house number where the station is located</td>
  </tr>
  <tr>
    <td>
      <code class="field">locationStreet</code>
      <div class="type">optional</div>
    </td>
    <td>The street name where the station is located</td>
  </tr>
  <tr>
    <td>
      <code class="field">locationCity</code>
      <div class="type">optional</div>
    </td>
    <td>The city where the station is located</td>
  </tr>
  <tr>
    <td>
      <code class="field">locationPostalCode</code>
      <div class="type">optional</div>
    </td>
    <td>The postal code where the station is located</td>
  </tr>
  <tr>
    <td>
      <code class="field">locationCounty</code>
      <div class="type">optional</div>
    </td>
    <td>The county where the charger is located</td>
  </tr>
  <tr>
    <td>
      <code class="field">locationState</code>
      <div class="type">optional</div>
    </td>
    <td>The state where the charger is located</td>
  </tr>
  <tr>
    <td>
      <code class="field">locationCountry</code>
      <div class="type">optional</div>
    </td>
    <td>The country where the charger is located</td>
  </tr>
  <tr>
    <td>
      <code class="field">availableFrom</code>
      <div class="type required">required</div>
    </td>
    <td>The time from which the charger can be made available for the vessel requesting a charge. Specified as time in seconds since <a href="https://en.wikipedia.org/wiki/Unix_time" target="blank">Epoch/Unix Time</a></td>
  </tr>
  <tr>
    <td>
      <code class="field">availableUntil</code>
      <div class="type">optional</div>
    </td>
    <td>The time until which the charger can be made available for the vessel requesting a charge. Specified as time in seconds since <a href="https://en.wikipedia.org/wiki/Unix_time" target="blank">Epoch/Unix Time</a></td>
  </tr>
  <tr>
    <td>
      <code class="field">energySource</code>
      <div class="type">optional</div>
    </td>
    <td>The source of the energy used by this charger. Specified as an energy source id. See <a href="#energy-sources">Energy Sources</a></td>
  </tr>
  <tr>
    <td>
      <code class="field">amenities</code>
      <div class="type">optional</div>
    </td>
    <td>A list of amenities that are present at this charger. Specified as an array of amenity ids. See <a href="#amenities">Amenities</a></td>
  </tr>
  <tr>
    <td>
      <code class="field">provider</code>
      <div class="type">optional</div>
    </td>
    <td>Name of the service provider or charging network operating this charger</td>
  </tr>
  <tr>
    <td>
      <code class="field">manufacturer</code>
      <div class="type">optional</div>
    </td>
    <td>Name of the manufacturer of this charger</td>
  </tr>
  <tr>
    <td>
      <code class="field">model</code>
      <div class="type">optional</div>
    </td>
    <td>Name of the model of this charger</td>
  </tr>
</table>

# Starting

A message sent by the service provider (the charger) to the service requester, notifying it that the mission has started

## Arguments

```javascript
const { StartingMessageParams } = require('dav-js/dist/vessel-charging');

const startingMessage = new StartingMessageParams();
mission.sendMessage(startingMessage);
```

```typescript
const { StartingMessageParams } = require('dav-js/dist/vessel-charging');

const startingMessageParams = new StartingMessageParams();
mission.sendMessage(startingMessage);
```

<table class="arguments">
  <tr>
    <td>None</td>
  </tr>
</table>

# Request Status

A request message sent by either party, asking the other a status update

## Arguments

> Using the vessel-charging/messages/StatusRequestMessageParams class

```javascript
const statusRequestMessageParams = new StatusRequestMessageParams({});
mission.sendMessage(statusRequestMessageParams);
```

```typescript
const statusRequestMessageParams = new StatusRequestMessageParams({});
mission.sendMessage(statusRequestMessageParams);
```

<table class="arguments">
  <tr>
    <td>None</td>
  </tr>
</table>

# Provider Status

A status update sent by the service provider to the service requester

## Arguments

> Using the vessel-charging/messages/ProviderStatusMessageParams class

```javascript
const providerStatusMessageParams = new ProviderStatusMessageParams({
  finishEta: Date.now() + 5000,
});
mission.sendMessage(providerStatusMessageParams);
```

```typescript
const providerStatusMessageParams = new ProviderStatusMessageParams({
  finishEta: Date.now() + 5000,
});
mission.sendMessage(providerStatusMessageParams);
```

<table class="arguments">
  <tr>
    <td>
      <code class="field">finishEta</code>
      <div class="type required">required</div>
    </td>
    <td>The estimated time at which charging will be complete. Specified as time in seconds since <a href="https://en.wikipedia.org/wiki/Unix_time" target="blank">Epoch/Unix Time</a></td>
  </tr>
</table>

# Vessel Status

A status update sent by the service requester (the vessel) to the service provider (charger)

## Arguments

> Using the vessel-charging/messages/VesselStatusMessageParams class

```javascript
const vesselStatusMessageParams = new VesselStatusMessageParams({
  location: {
    lat: 32.050382,
    long: 34.766149,
  },
});
mission.sendMessage(vesselStatusMessageParams);
```

```typescript
const vesselStatusMessageParams = new VesselStatusMessageParams({
  location: {
    lat: 32.050382,
    long: 34.766149,
  },
});
mission.sendMessage(vesselStatusMessageParams);
```

<table class="arguments">
  <tr>
    <td>
      <code class="field">location</code>
      <div class="type required">required</div>
    </td>
    <td>The coordinates of the vehicle's current location</td>
  </tr>
</table>

# Charging Arrival

A message sent by the service requester to the service provider, notifying it that the vessel has arrived at the charger's location

## Arguments

> Using the vessel-charging/messages/ChargingArrivalMessageParams class

```javascript
const chargingArrivalMessageParams = new ChargingArrivalMessageParams({});
mission.sendMessage(chargingArrivalMessageParams);
```

```typescript
const chargingArrivalMessageParams = new ChargingArrivalMessageParams({});
mission.sendMessage(chargingArrivalMessageParams);
```

<table class="arguments">
  <tr>
    <td>None</td>
  </tr>
</table>

# Charging Started

A message sent by the service provider to the service requester, notifying it that charging has begun and is now in progress

## Arguments

> Using the vessel-charging/messages/ChargingStartedMessageParams class

```typescript
const chargingStartedMessageParams = new ChargingStartedMessageParams({});
mission.sendMessage(chargingStartedMessageParams);
```

```javascript
const chargingStartedMessageParams = new ChargingStartedMessageParams({});
mission.sendMessage(chargingStartedMessageParams);
```

<table class="arguments">
  <tr>
    <td>None</td>
  </tr>
</table>

# Charging Complete

A message sent by the service provider to the service requester, notifying it that charging has completed

## Arguments

> Using the vessel-charging/messages/ChargingCompleteMessageParams class

```javascript
const chargingCompleteMessageParams = new ChargingCompleteMessageParams({});
mission.sendMessage(chargingCompleteMessageParams);
```

```typescript
const chargingCompleteMessageParams = new ChargingCompleteMessageParams({});
mission.sendMessage(chargingCompleteMessageParams);
```

<table class="arguments">
  <tr>
    <td>None</td>
  </tr>
</table>

# Energy Sources

The energy source used by the charger.

<table class="energy_sources">
  <tr>
    <th>Level</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><code>grid</code></td>
    <td>Connected to the electrical grid and using an unspecified energy source, or an unspecified mix of energy source</td>
  </tr>
  <tr>
    <td><code>renewable</code></td>
    <td>Uses 100% renewable energy of an unspecified source, or a mix of different renewable energy sources</td>
  </tr>
  <tr>
    <td><code>solar</code></td>
    <td>Uses 100% solar energy</td>
  </tr>
  <tr>
    <td><code>wind</code></td>
    <td>Uses 100% wind energy</td>
  </tr>
  <tr>
    <td><code>hydro</code></td>
    <td>Uses 100% hydro power energy</td>
  </tr>
  <tr>
    <td><code>geothermal</code></td>
    <td>Uses 100% geothermal energy</td>
  </tr>
</table>

# Amenities

A list of amenities can be included in both requests and responses.

<table class="reference">
  <tr>
    <th>ID</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><code>1</code></td>
    <td>Lodging</td>
  </tr>
  <tr>
    <td><code>2</code></td>
    <td>Dining</td>
  </tr>
  <tr>
    <td><code>3</code></td>
    <td>Restrooms</td>
  </tr>
  <tr>
    <td><code>4</code></td>
    <td>Docking</td>
  </tr>
  <tr>
    <td><code>5</code></td>
    <td>Park</td>
  </tr>
  <tr>
    <td><code>6</code></td>
    <td>WiFi</td>
  </tr>
  <tr>
    <td><code>7</code></td>
    <td>Shopping</td>
  </tr>
  <tr>
    <td><code>8</code></td>
    <td>Grocery</td>
  </tr>
</table>

# Price Types

Price types and their unique identifier.

<table class="price_types">
  <tr>
    <th>Price Type</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><code>kwh</code></td>
    <td>Cost per kWh</td>
  </tr>
  <tr>
    <td><code>second</code></td>
    <td>Cost per second</td>
  </tr>
  <tr>
    <td><code>minute</code></td>
    <td>Cost per minute</td>
  </tr>
  <tr>
    <td><code>hour</code></td>
    <td>Cost per hour</td>
  </tr>
  <tr>
    <td><code>day</code></td>
    <td>Cost per day</td>
  </tr>
  <tr>
    <td><code>week</code></td>
    <td>Cost per week</td>
  </tr>
  <tr>
    <td><code>flat</code></td>
    <td>The listed <code>price</code> is a flat price</td>
  </tr>
</table>
