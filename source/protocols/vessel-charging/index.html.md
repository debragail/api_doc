---
title: Vessel Charging

language_tabs: # must be one of https://git.io/vQNgJ
  - shell
  - javascript
  - python

toc_footers:
  - Parts of the Vessel Charging API were
  - inspired by the <a href="https://github.com/PlugShare/slate" target="blank">PlugShare API</a>.
  - Documentation powered by <a href="https://github.com/lord/slate" target="blank">Slate</a>.

search: true
---

<p class="header-image"><img src="/images/vessel_charging/header.png" alt="Vessel Charging"></p>

# Vessel Charging Protocol

The communication protocol for vessel charging describes the format of a request for a charging service (`need`), and the response sent by a charging provider (`bid`).

For example, an autonomous boat might search for charging stations within 2 km of a given coordinate that are capable of docking a 1200 kg boat.

> Need

```shell
curl "discovery_endpoint_here" \
  --data "{ \
    \"start_at\": \"1513005534000\", \
    \"latitude\": \"38.066516\", \
    \"longitude\": \"-122.240688\", \
    \"radius\": \"2000\", \
    \"height\": \"200\", \
    \"width\": \"120\", \
    \"length\": \"330\", \
    \"weight\": \"1200\" \
  }"
```

```javascript
const discoveryEndPoint = "discovery_endpoint_here";

fetch(discoveryEndPoint, {
  method: "POST",
  body: JSON.stringify({
    "start_at": "1513005534000",
    "latitude": "38.066516",
    "longitude": "-122.240688",
    "radius": "2000",
    "height": "200",
    "width": "120",
    "length": "330",
    "weight": "1200",
  })
});
```

```python
import requests
payload = {
    "start_at": "1513005534000",
    "latitude": "38.066516",
    "longitude": "-122.240688",
    "radius": "2000",
    "height": "200",
    "width": "120",
    "length": "330",
    "weight": "1200",
  }
requests.post("discovery_endpoint_here", data=payload)
```

In response, a charging station might send back a bid with a price for the service, the opening and closing times, and the full list of services it offers.

> Bid

```shell
curl "bidding_endpoint_here" \
  --data "{ \
    \"need_id\": \"ae7bd8f67f3089c\", \
    \"expires_at\": \"1513005539000\", \
    \"price\": \"2300000000000000000,30000000000000000\", \
    \"price_type\": \"flat,flat\", \
    \"price_description\": \"Total price,Tax\", \
    \"latitude\": \"38.066088\", \
    \"longitude\": \"-122.230219\", \
    \"available_from\": \"1513005534000\", \
    \"available_until\": \"1513091934000\", \
    \"amenities\": \"2,3,4,6,8\" \
  }"
```

```javascript
const biddingEndPoint = "bidding_endpoint_here";

fetch(biddingEndPoint, {
  method: "POST",
  body: JSON.stringify({
    "need_id": "ae7bd8f67f3089c",
    "expires_at": "1513005539000",
    "price": "2300000000000000000,30000000000000000",
    "price_type": "flat,flat",
    "price_description": "Total price,Tax",
    "latitude": "38.066088",
    "longitude": "-122.230219",
    "available_from": "1513005534000",
    "available_until": "1513091934000",
    "amenities": "2,3,4,6,8",
  })
});
```

```python
import requests
payload = {
    "need_id": "ae7bd8f67f3089c",
    "expires_at": "1513005539000",
    "price": "2300000000000000000,30000000000000000",
    "price_type": "flat,flat",
    "price_description": "Total price,Tax",
    "latitude": "38.066088",
    "longitude": "-122.230219",
    "available_from": "1513005534000",
    "available_until": "1513091934000",
    "amenities": "2,3,4,6,8",
  }
requests.post("bidding_endpoint_here", data=payload)
```

# Need

A statement of need for charging services. Typically this will be sent by an electric boat that is looking for a charging station around certain coordinates.

This request is sent to the decentralized discovery engine which responds with status `200` and a unique identifier for this request. The details of this request are then broadcasted to DAV entities that can provide this service. <a href="#bid">Bids</a> are later received as separate calls.

## Arguments

> Post request to a local/remote discovery endpoint

```shell
curl "discovery_endpoint_here" \
  --data "{ \
    \"start_at\": \"1513005534000\", \
    \"latitude\": \"38.066516\", \
    \"longitude\": \"-122.240688\", \
    \"radius\": \"2000\", \
    \"height\": \"200\", \
    \"width\": \"120\", \
    \"length\": \"330\", \
    \"weight\": \"1200\", \
    \"battery_capacity\": \"56\", \
    \"current_battery_charge\": \"26\", \
    \"energy_source\": \"hydro\", \
    \"amenities\": \"2,3\" \
  }"
```

```javascript
const discoveryEndPoint = "discovery_endpoint_here";

fetch(discoveryEndPoint, {
  method: "POST",
  body: JSON.stringify({
    "start_at": "1513005534000",
    "latitude": "38.066516",
    "longitude": "-122.240688",
    "radius": "2000",
    "height": "200",
    "width": "120",
    "length": "330",
    "weight": "1200",
    "battery_capacity": "56",
    "current_battery_charge": "26",
    "energy_source": "hydro",
    "amenities": "2,3",
  })
});
```

```python
import requests
payload = {
    "start_at": "1513005534000",
    "latitude": "38.066516",
    "longitude": "-122.240688",
    "radius": "2000",
    "height": "200",
    "width": "120",
    "length": "330",
    "weight": "1200",
    "battery_capacity": "56",
    "current_battery_charge": "26",
    "energy_source": "hydro",
    "amenities": "2,3",
  }
requests.post("discovery_endpoint_here", data=payload)
```

<table class="arguments">
  <tr>
    <td>
      <code class="field">start_at</code>
      <div class="type">optional</div>
    </td>
    <td>The time at which the requester would like to arrive at charger (if undefined, the arrival time will be ASAP). Specified as time in milliseconds since <a href="https://en.wikipedia.org/wiki/Unix_time" target="blank">Epoch/Unix Time</a></td>
  </tr>
  <tr>
    <td>
      <code class="field">latitude</code>
      <div class="type required">required</div>
    </td>
    <td>The latitude coordinate around which to search</td>
  </tr>
  <tr>
    <td>
      <code class="field">longitude</code>
      <div class="type required">required</div>
    </td>
    <td>The longitude coordinate around which to search</td>
  </tr>
  <tr>
    <td>
      <code class="field">radius</code>
      <div class="type required">required</div>
    </td>
    <td>Radius in meters around the search coordinates to limit the search to. Specified as an integer</td>
  </tr>
  <tr>
    <td>
      <code class="field">height</code>
      <div class="type">optional</div>
    </td>
    <td>The minimum height clearance that this vessel requires from the charger. Specified as an integer representing centimeters</td>
  </tr>
  <tr>
    <td>
      <code class="field">width</code>
      <div class="type">optional</div>
    </td>
    <td>The minimum width clearance that this vessel requires from the charger. Specified as an integer representing centimeters</td>
  </tr>
  <tr>
    <td>
      <code class="field">length</code>
      <div class="type">optional</div>
    </td>
    <td>The minimum length clearance that this vessel requires from the charger. Specified as an integer representing centimeters</td>
  </tr>
  <tr>
    <td>
      <code class="field">weight</code>
      <div class="type">optional</div>
    </td>
    <td>The weight of this vessel. Chargers that cannot support vessels weighing this much should not respond. Specified as an integer representing kilograms</td>
  </tr>
  <tr>
    <td>
      <code class="field">battery_capacity</code>
      <div class="type">optional</div>
    </td>
    <td>The vessel's total battery capacity, specified in kWh</td>
  </tr>
  <tr>
    <td>
      <code class="field">current_battery_charge</code>
      <div class="type">optional</div>
    </td>
    <td>The vessel's current battery charge level, as it was at the time the request was sent. Specified as an integer denoting percentage of full capacity</td>
  </tr>
  <tr>
    <td>
      <code class="field">energy_source</code>
      <div class="type">optional</div>
    </td>
    <td>Limit the request to only receive bids from chargers using a specific source of the energy. Specified as an energy source id. See <a href="#energy-sources">Energy Sources</a></td>
  </tr>
  <tr>
    <td>
      <code class="field">amenities</code>
      <div class="type">optional</div>
    </td>
    <td>A list of amenities that need to be present at charging station. Specified as a comma separated list of amenity ids. See <a href="#amenities">Amenities</a></td>
  </tr>
</table>

# Bid

A bid to provide a charging service. Typically sent from a charger to an electric boat.

## Arguments

> Post request to a local/remote bidding endpoint

```shell
curl "bidding_endpoint_here" \
  --data "{ \
    \"need_id\": \"ae7bd8f67f3089c\", \
    \"expires_at\": \"1513005539000\", \
    \"price\": \"2300000000000000000,30000000000000000\", \
    \"price_type\": \"flat,flat\", \
    \"price_description\": \"Total price,Tax\", \
    \"latitude\": \"38.066088\", \
    \"longitude\": \"-122.230219\", \
    \"entrance_latitude\": \"38.066088\", \
    \"entrance_longitude\": \"-122.230219\", \
    \"exit_latitude\": \"38.066088\", \
    \"exit_longitude\": \"-122.230219\", \
    \"location_name\": \"Marine Programs Naval Science\", \
    \"location_name_lang\": \"eng\", \
    \"location_house_number\": \"5\", \
    \"location_street\": \"Morrow Cove Drive\", \
    \"location_city\": \"Vallejo\", \
    \"location_postal_code\": \"94590\", \
    \"location_county\": \"Solano\", \
    \"location_state\": \"CA\", \
    \"location_country\": \"USA\", \
    \"available_from\": \"1513005534000\", \
    \"available_until\": \"1513091934000\", \
    \"height\": \"300\", \
    \"width\": \"200\", \
    \"length\": \"580\", \
    \"weight\": \"10000\", \
    \"energy_source\": \"hydro\", \
    \"amenities\": \"2,3,4,6,8\", \
    \"provider\": \"General Dynamics\", \
    \"manufacturer\": \"General Dynamics\", \
    \"model\": \"100\" \
  }"
```

```javascript
const biddingEndPoint = "bidding_endpoint_here";

fetch(biddingEndPoint, {
  method: "POST",
  body: JSON.stringify({
    "need_id": "ae7bd8f67f3089c",
    "expires_at": "1513005539000",
    "price": "2300000000000000000,30000000000000000",
    "price_type": "flat,flat",
    "price_description": "Total price,Tax",
    "latitude": "38.066088",
    "longitude": "-122.230219",
    "entrance_latitude": "38.066088",
    "entrance_longitude": "-122.230219",
    "exit_latitude": "38.066088",
    "exit_longitude": "-122.230219",
    "location_name": "Marine Programs Naval Science",
    "location_name_lang": "eng",
    "location_house_number": "5",
    "location_street": "Morrow Cove Drive",
    "location_city": "Vallejo",
    "location_postal_code": "94590",
    "location_county": "Solano",
    "location_state": "CA",
    "location_country": "USA",
    "available_from": "1513005534000",
    "available_until": "1513091934000",
    "height": "300",
    "width": "200",
    "length": "580",
    "weight": "10000",
    "energy_source": "hydro",
    "amenities": "2,3,4,6,8",
    "provider": "General Dynamics",
    "manufacturer": "General Dynamics",
    "model": "100",
  })
});
```

```python
import requests
payload = {
    "need_id": "ae7bd8f67f3089c",
    "expires_at": "1513005539000",
    "price": "2300000000000000000,30000000000000000",
    "price_type": "flat,flat",
    "price_description": "Total price,Tax",
    "latitude": "38.066088",
    "longitude": "-122.230219",
    "entrance_latitude": "38.066088",
    "entrance_longitude": "-122.230219",
    "exit_latitude": "38.066088",
    "exit_longitude": "-122.230219",
    "location_name": "Marine Programs Naval Science",
    "location_name_lang": "eng",
    "location_house_number": "5",
    "location_street": "Morrow Cove Drive",
    "location_city": "Vallejo",
    "location_postal_code": "94590",
    "location_county": "Solano",
    "location_state": "CA",
    "location_country": "USA",
    "available_from": "1513005534000",
    "available_until": "1513091934000",
    "height": "300",
    "width": "200",
    "length": "580",
    "weight": "10000",
    "energy_source": "hydro",
    "amenities": "2,3,4,6,8",
    "provider": "General Dynamics",
    "manufacturer": "General Dynamics",
    "model": "100",
  }
requests.post("bidding_endpoint_here", data=payload)
```

<table class="arguments">
  <tr>
    <td>
      <code class="field">need_id</code>
      <div class="type required">required</div>
    </td>
    <td>The unique identifier of the 'need' this bid is for. This ID arrives as part of the 'need' request</td>
  </tr>
  <tr>
    <td>
      <code class="field">expires_at</code>
      <div class="type required">required</div>
    </td>
    <td>This bid will expire at this time. Specified as time in milliseconds since <a href="https://en.wikipedia.org/wiki/Unix_time" target="blank">Epoch/Unix Time</a></td>
  </tr>
  <tr>
    <td>
      <code class="field">price</code>
      <div class="type required">required</div>
    </td>
    <td>A comma separated list of prices. Each price is specified as an integer representing Vinci (1 DAV token equals 1000000000000000000 Vinci equals 1e18 Vinci)</td>
  </tr>
  <tr>
    <td>
      <code class="field">price_type</code>
      <div class="type required">required</div>
    </td>
    <td>A list of price types describing the <code>price</code> parameter(s). Specified as a comma separated list. See <a href="#price-types">Price Types</a> for available values</td>
  </tr>
  <tr>
    <td>
      <code class="field">price_description</code>
      <div class="type required">required</div>
    </td>
    <td>A comma separated list of strings describing the <code>price</code> parameter(s) in human readable terms</td>
  </tr>
  <tr>
    <td>
      <code class="field">latitude</code>
      <div class="type required">required</div>
    </td>
    <td>The latitude coordinate of the charger</td>
  </tr>
  <tr>
    <td>
      <code class="field">longitude</code>
      <div class="type required">required</div>
    </td>
    <td>The longitude coordinate of the charger</td>
  </tr>
  <tr>
    <td>
      <code class="field">entrance_latitude</code>
      <div class="type">optional</div>
    </td>
    <td>The latitude coordinate of the entrance to the charger</td>
  </tr>
  <tr>
    <td>
      <code class="field">entrance_longitude</code>
      <div class="type">optional</div>
    </td>
    <td>The longitude coordinate of the entrance to the charger</td>
  </tr>
  <tr>
    <td>
      <code class="field">exit_latitude</code>
      <div class="type">optional</div>
    </td>
    <td>The latitude coordinate of the exit from the charger</td>
  </tr>
  <tr>
    <td>
      <code class="field">exit_longitude</code>
      <div class="type">optional</div>
    </td>
    <td>The longitude coordinate of the exit from the charger</td>
  </tr>
  <tr>
    <td>
      <code class="field">location_name</code>
      <div class="type">optional</div>
    </td>
    <td>A human readable name/description of the charger location (e.g., Cal Maritime Dock C)</td>
  </tr>
  <tr>
    <td>
      <code class="field">location_name_lang</code>
      <div class="type">optional</div>
    </td>
    <td>The language used in <code>location_name</code>. Specified using the 3 letter <a href="https://en.wikipedia.org/wiki/ISO_639-3" target="blank">ISO 639-3</a> language code</td>
  </tr>
  <tr>
    <td>
      <code class="field">location_house_number</code>
      <div class="type">optional</div>
    </td>
    <td>The house number where the station is located</td>
  </tr>
  <tr>
    <td>
      <code class="field">location_street</code>
      <div class="type">optional</div>
    </td>
    <td>The street name where the station is located</td>
  </tr>
  <tr>
    <td>
      <code class="field">location_city</code>
      <div class="type">optional</div>
    </td>
    <td>The city where the station is located</td>
  </tr>
  <tr>
    <td>
      <code class="field">location_postal_code</code>
      <div class="type">optional</div>
    </td>
    <td>The postal code where the station is located</td>
  </tr>
  <tr>
    <td>
      <code class="field">location_county</code>
      <div class="type">optional</div>
    </td>
    <td>The county where the charger is located</td>
  </tr>
  <tr>
    <td>
      <code class="field">location_state</code>
      <div class="type">optional</div>
    </td>
    <td>The state where the charger is located</td>
  </tr>
  <tr>
    <td>
      <code class="field">location_country</code>
      <div class="type">optional</div>
    </td>
    <td>The country where the charger is located</td>
  </tr>
  <tr>
    <td>
      <code class="field">available_from</code>
      <div class="type required">required</div>
    </td>
    <td>The time from which the charger can be made available for the vessel requesting a charge. Specified as time in milliseconds since <a href="https://en.wikipedia.org/wiki/Unix_time" target="blank">Epoch/Unix Time</a></td>
  </tr>
  <tr>
    <td>
      <code class="field">available_until</code>
      <div class="type">optional</div>
    </td>
    <td>The time until which the charger can be made available for the vessel requesting a charge. Specified as time in milliseconds since <a href="https://en.wikipedia.org/wiki/Unix_time" target="blank">Epoch/Unix Time</a></td>
  </tr>
  <tr>
    <td>
      <code class="field">height</code>
      <div class="type">optional</div>
    </td>
    <td>The maximum vessel height this charger can accommodate. Specified as an integer representing centimeters</td>
  </tr>
  <tr>
    <td>
      <code class="field">width</code>
      <div class="type">optional</div>
    </td>
    <td>The maximum vessel width this charger can accommodate. Specified as an integer representing centimeters</td>
  </tr>
  <tr>
    <td>
      <code class="field">length</code>
      <div class="type">optional</div>
    </td>
    <td>The maximum vessel length this charger can accommodate. Specified as an integer representing centimeters</td>
  </tr>
  <tr>
    <td>
      <code class="field">weight</code>
      <div class="type">optional</div>
    </td>
    <td>The maximum vessel weight this charger can accommodate. Specified as an integer representing kilograms</td>
  </tr>
  <tr>
    <td>
      <code class="field">energy_source</code>
      <div class="type">optional</div>
    </td>
    <td>The source of the energy used by this charger. Specified as an energy source id. See <a href="#energy-sources">Energy Sources</a></td>
  </tr>
  <tr>
    <td>
      <code class="field">amenities</code>
      <div class="type">optional</div>
    </td>
    <td>A list of amenities that are present at this charger. Specified as a comma separated list of amenity ids. See <a href="#amenities">Amenities</a></td>
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

# Select Bid

A selection of one bid that wins over the rest. Sent by the service requester (a vessel looking for charging)

## Arguments

> Post request to a local/remote endpoint representing the service provider

```shell
curl "discovery_endpoint_here" \
  --data "{ \
    \"bid_id\": \"bv43nmw65eef03e\" \
  }"
```

```javascript
const discoveryEndPoint = "discovery_endpoint_here";

fetch(discoveryEndPoint, {
  method: "POST",
  body: JSON.stringify({
    "bid_id": "bv43nmw65eef03e",
  })
});
```

```python
import requests
payload = {
    "bid_id": "bv43nmw65eef03e",
  }
requests.post("discovery_endpoint_here", data=payload)
```

<table class="arguments">
  <tr>
    <td>
      <code class="field">bid_id</code>
      <div class="type required">required</div>
    </td>
    <td>The unique identifier of the selected 'bid'. This ID arrives as part of the 'bid' request</td>
  </tr>
</table>

# Starting

A message sent by the service provider (the charger) to the service requester, notifying it that the mission has started

## Arguments

> Post request to a local/remote endpoint representing the service requester

```shell
curl "bidding_endpoint_here" \
  --data "{ \
    \"bid_id\": \"bv43nmw65eef03e\" \
  }"
```

```javascript
const biddingEndPoint = "bidding_endpoint_here";

fetch(biddingEndPoint, {
  method: "POST",
  body: JSON.stringify({
    "bid_id": "bv43nmw65eef03e"
  })
});
```

```python
import requests
payload = {
    "bid_id": "bv43nmw65eef03e"
  }
requests.post("bidding_endpoint_here", data=payload)
```

<table class="arguments">
  <tr>
    <td>
      <code class="field">bid_id</code>
      <div class="type required">required</div>
    </td>
    <td>The unique identifier of the 'bid' that initiated the mission</td>
  </tr>
</table>

# Decline

A cancellation message sent by the service provider (the charger) to the service requester, notifying it that the mission has been declined

## Arguments

> Post request to a local/remote endpoint representing the service requester

```shell
curl "bidding_endpoint_here" \
  --data "{ \
    \"bid_id\": \"bv43nmw65eef03e\" \
  }"
```

```javascript
const biddingEndPoint = "bidding_endpoint_here";

fetch(biddingEndPoint, {
  method: "POST",
  body: JSON.stringify({
    "bid_id": "bv43nmw65eef03e",
  })
});
```

```python
import requests
payload = {
    "bid_id": "bv43nmw65eef03e",
  }
requests.post("bidding_endpoint_here", data=payload)
```

<table class="arguments">
  <tr>
    <td>
      <code class="field">bid_id</code>
      <div class="type required">required</div>
    </td>
    <td>The unique identifier of the 'bid' that declined the mission</td>
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
