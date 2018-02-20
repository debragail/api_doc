---
title: Car Parking

language_tabs: # must be one of https://git.io/vQNgJ
  - shell
  - javascript
  - python

toc_footers:
  - Documentation powered by <a href="https://github.com/lord/slate" target="blank">Slate</a>.

search: true
---

<p class="header-image"><img src="/images/car_parking/header.png" alt="Car Parking"></p>

#  Car Parking Protocol

The communication protocol for car parking describes the format of a request for a parking space (also referred to as `need`) sent by a vehicle, and the response sent by a parking space, usually an automated parking management system (`bid`).

For example, a heavy goods truck might search for an available parking space within 1 km of a given coordinate that can fit a 12 meters long vehicle.

> Need

```shell
curl "discovery_endpoint_here" \
  --data "start_at=2017-12-11T15:18:54+03:00" \
  --data "latitude=32.787793" \
  --data "longitude=-79.935005" \
  --data "radius=1000" \
  --data "length=1200"
```

```javascript
const discoveryEndPoint = "discovery_endpoint_here";

fetch(discoveryEndPoint, {
  method: "POST",
  body: JSON.stringify({
    "start_at": "2017-12-11T15:18:54+03:00",
    "latitude": "32.787793",
    "longitude": "-79.935005",
    "radius": "1000",
    "length": "1200",
  })
});
```

```python
import requests
payload = {
    "start_at": "2017-12-11T15:18:54+03:00",
    "latitude": "32.787793",
    "longitude": "-79.935005",
    "radius": "1000",
    "length": "1200",
  }
requests.post("discovery_endpoint_here", data=payload)
```

In response, a parking space might send back a bid with a price per hour, and the full details of the additional services it offers.

> Bid

```shell
curl "bidding_endpoint_here" \
  --data "need_id=ae7bd8f67f3089c" \
  --data "expires_at=2017-12-11T15:18:59+03:00" \
  --data "price=300000000000000000,500000000000000000" \
  --data "price_type=hour,flat" \
  --data "price_description=Price per hour,City tax" \
  --data "latitude=32.785889" \
  --data "longitude=-79.935569" \
  --data "available_from=2017-12-11T15:18:54+03:00" \
  --data "available_until=2017-12-12T15:18:54+03:00" \
  --data "height=300" \
  --data "width=300" \
  --data "length=1900" \
  --data "weight=100000" \
  --data "amenities=2,3,8"
```

```javascript
const biddingEndPoint = "bidding_endpoint_here";

fetch(biddingEndPoint, {
  method: "POST",
  body: JSON.stringify({
    "need_id": "ae7bd8f67f3089c",
    "expires_at": "2017-12-11T15:18:59+03:00",
    "price": "300000000000000000,500000000000000000",
    "price_type": "hour,flat",
    "price_description": "Price per hour,City tax",
    "latitude": "32.785889",
    "longitude": "-79.935569",
    "available_from": "2017-12-11T15:18:54+03:00",
    "available_until": "2017-12-12T15:18:54+03:00",
    "height": "300",
    "width": "300",
    "length": "1900",
    "weight": "100000",
    "amenities": "2,3,8",
  })
});
```

```python
import requests
payload = {
    "need_id": "ae7bd8f67f3089c",
    "expires_at": "2017-12-11T15:18:59+03:00",
    "price": "300000000000000000,500000000000000000",
    "price_type": "hour,flat",
    "price_description": "Price per hour,City tax",
    "latitude": "32.785889",
    "longitude": "-79.935569",
    "available_from": "2017-12-11T15:18:54+03:00",
    "available_until": "2017-12-12T15:18:54+03:00",
    "height": "300",
    "width": "300",
    "length": "1900",
    "weight": "100000",
    "amenities": "2,3,8",
  }
requests.post("bidding_endpoint_here", data=payload)
```

<b>Note:</b> For charging while parking, see the <a href="../protocol/ev_charging.html">Electric Vehicle Charging Protocol</a>, as some charging stations include a parking service. If a `bid` is given in response to a Car Parking `need` from a location offering EV Charging, the `bid` price will not include any charging services.

# Need

A statement of need for parking spaces. Typically this will be sent by a vehicle that is looking for a parking space around certain coordinates.

This request is sent to the decentralized discovery engine which responds with status `200` and a unique identifier for this request. The details of this request are then broadcasted to DAV entities that can provide this service. <a href="#bid">Bids</a> are later received as separate calls.

## Arguments

> Post request to a local/remote discovery endpoint

```shell
curl "discovery_endpoint_here" \
  --data "start_at=2017-12-11T15:18:54+03:00" \
  --data "latitude=32.787793" \
  --data "longitude=-79.935005" \
  --data "radius=10000" \
  --data "height=200" \
  --data "width=120" \
  --data "length=330" \
  --data "weight=1200" \
  --data "amenities=2,3"
```

```javascript
const discoveryEndPoint = "discovery_endpoint_here";

fetch(discoveryEndPoint, {
  method: "POST",
  body: JSON.stringify({
    "start_at": "2017-12-11T15:18:54+03:00",
    "latitude": "32.787793",
    "longitude": "-79.935005",
    "radius": "10000",
    "height": "200",
    "width": "120",
    "length": "330",
    "weight": "1200",
    "amenities": "2,3",
  })
});
```

```python
import requests
payload = {
    "start_at": "2017-12-11T15:18:54+03:00",
    "latitude": "32.787793",
    "longitude": "-79.935005",
    "radius": "10000",
    "height": "200",
    "width": "120",
    "length": "330",
    "weight": "1200",
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
    <td>The time at which the requester would like to arrive at the parking space (if undefined, the arrival time will be ASAP). Specified as time in milliseconds since <a href="https://en.wikipedia.org/wiki/Unix_time">Epoch/Unix Time</a></td>
  </tr>
    <tr>
    <td>
      <code class="field">end_at</code>
      <div class="type">optional</div>
    </td>
    <td>The time at which the requester plans to leave the parking space. This parameter is optional but highly recommended, as it can affect how the service is priced. Specified as time in milliseconds since <a href="https://en.wikipedia.org/wiki/Unix_time">Epoch/Unix Time</a></td>
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
    <td>The height of this vehicle, and the minimum height clearance that this vehicle requires from the parking space. Specified as an integer representing centimeters</td>
  </tr>
  <tr>
    <td>
      <code class="field">width</code>
      <div class="type">optional</div>
    </td>
    <td>The width of this vehicle, and the minimum width clearance that this vehicle requires from the parking space. Specified as an integer representing centimeters</td>
  </tr>
  <tr>
    <td>
      <code class="field">length</code>
      <div class="type">optional</div>
    </td>
    <td>The length of this vehicle, and the minimum length clearance that this vehicle requires from the parking space. Specified as an integer representing centimeters</td>
  </tr>
  <tr>
    <td>
      <code class="field">weight</code>
      <div class="type">optional</div>
    </td>
    <td>The weight of this vehicle. Parking spaces that cannot support a vehicle weighing this much should not respond. Specified as an integer representing kilograms</td>
  </tr>
  <tr>
    <td>
      <code class="field">amenities</code>
      <div class="type">optional</div>
    </td>
    <td>A list of amenities that need to be present at the parking space. Specified as a comma separated list of amenity IDs. See <a href="#amenities">Amenities</a></td>
  </tr>
</table>

# Bid

A bid to provide a parking service. Typically sent from a parking management system to a vehicle.

## Arguments

> Post request to a local/remote endpoint representing the vehicle

```shell
curl "bidding_endpoint_here" \
  --data "need_id=ae7bd8f67f3089c" \
  --data "expires_at=2017-12-11T15:18:59+03:00" \
  --data "price=300000000000000000,500000000000000000" \
  --data "price_type=hour,flat" \
  --data "price_description=Price per hour,City tax" \
  --data "latitude=32.785889" \
  --data "longitude=-79.935569" \
  --data "entrance_latitude=32.785878" \
  --data "entrance_longitude=-79.935558" \
  --data "exit_latitude=32.785878" \
  --data "exit_longitude=-79.935558" \
  --data "location_floor=2" \
  --data "location_name=IKEA parking lot B" \
  --data "location_name_lang=eng" \
  --data "location_house_number=372" \
  --data "location_street=King" \
  --data "location_city=Charleston" \
  --data "location_postal_code=29401" \
  --data "location_county=Charleston" \
  --data "location_state=SC" \
  --data "location_country=USA" \
  --data "available_from=2017-12-11T15:18:54+03:00" \
  --data "available_until=2017-12-12T15:18:54+03:00" \
  --data "height=300" \
  --data "width=200" \
  --data "length=580" \
  --data "weight=10000" \
  --data "amenities=2,3,8"
```

```javascript
const biddingEndPoint = "bidding_endpoint_here";

fetch(biddingEndPoint, {
  method: "POST",
  body: JSON.stringify({
    "need_id": "ae7bd8f67f3089c",
    "expires_at": "2017-12-11T15:18:59+03:00",
    "price": "300000000000000000,500000000000000000",
    "price_type": "hour,flat",
    "price_description": "Price per hour,City tax",
    "latitude": "32.785889",
    "longitude": "-79.935569",
    "entrance_latitude": "32.785878",
    "entrance_longitude": "-79.935558",
    "exit_latitude": "32.785878",
    "exit_longitude": "-79.935558",
    "location_floor": "2",
    "location_name": "IKEA parking lot B",
    "location_name_lang": "eng",
    "location_house_number": "372",
    "location_street": "King",
    "location_city": "Charleston",
    "location_postal_code": "29401",
    "location_county": "Charleston",
    "location_state": "SC",
    "location_country": "USA",
    "available_from": "2017-12-11T15:18:54+03:00",
    "available_until": "2017-12-12T15:18:54+03:00",
    "height": "300",
    "width": "200",
    "length": "580",
    "weight": "10000",
    "amenities": "2,3,8",
  })
});
```

```python
import requests
payload = {
    "need_id": "ae7bd8f67f3089c",
    "expires_at": "2017-12-11T15:18:59+03:00",
    "price": "300000000000000000,500000000000000000",
    "price_type": "hour,flat",
    "price_description": "Price per hour,City tax",
    "latitude": "32.785889",
    "longitude": "-79.935569",
    "entrance_latitude": "32.785878",
    "entrance_longitude": "-79.935558",
    "exit_latitude": "32.785878",
    "exit_longitude": "-79.935558",
    "location_floor": "2",
    "location_name": "IKEA parking lot B",
    "location_name_lang": "eng",
    "location_house_number": "372",
    "location_street": "King",
    "location_city": "Charleston",
    "location_postal_code": "29401",
    "location_county": "Charleston",
    "location_state": "SC",
    "location_country": "USA",
    "available_from": "2017-12-11T15:18:54+03:00",
    "available_until": "2017-12-12T15:18:54+03:00",
    "height": "300",
    "width": "200",
    "length": "580",
    "weight": "10000",
    "amenities": "2,3,8",
  }
requests.post("bidding_endpoint_here", data=payload)
```

<table class="arguments">
  <tr>
    <td>
      <code class="field">need_id</code>
      <div class="type required">required</div>
    </td>
    <td>The UID of the request. This arrives as part of the request</td>
  </tr>
  <tr>
    <td>
      <code class="field">expires_at</code>
      <div class="type required">required</div>
    </td>
    <td>This bid will expire at this time. Specified as time in milliseconds since <a href="https://en.wikipedia.org/wiki/Unix_time">Epoch/Unix Time</a></td>
  </tr>
  <tr>
    <td>
      <code class="field">price</code>
      <div class="type required">required</div>
    </td>
    <td>A comma separated list of prices. Specified as an integer representing DAV tokens without the decimal point padded to 18 decimals (1 DAV is 1000000000000000000)</td>
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
    <td>The latitude coordinate of the parking space</td>
  </tr>
  <tr>
    <td>
      <code class="field">longitude</code>
      <div class="type required">required</div>
    </td>
    <td>The longitude coordinate of the parking space</td>
  </tr>
  <tr>
    <td>
      <code class="field">entrance_latitude</code>
      <div class="type">optional</div>
    </td>
    <td>The latitude coordinate of the entrance to the parking space</td>
  </tr>
  <tr>
    <td>
      <code class="field">entrance_longitude</code>
      <div class="type">optional</div>
    </td>
    <td>The longitude coordinate of the entrance to the parking space</td>
  </tr>
  <tr>
    <td>
      <code class="field">exit_latitude</code>
      <div class="type">optional</div>
    </td>
    <td>The latitude coordinate of the exit from the parking space</td>
  </tr>
  <tr>
    <td>
      <code class="field">exit_longitude</code>
      <div class="type">optional</div>
    </td>
    <td>The longitude coordinate of the exit from the parking space</td>
  </tr>
  <tr>
    <td>
      <code class="field">location_floor</code>
      <div class="type">optional</div>
    </td>
    <td>Which floor/level is the parking space located on (for multistory buildings)</td>
  </tr>
  <tr>
    <td>
      <code class="field">location_name</code>
      <div class="type">optional</div>
    </td>
    <td>A human readable name/description of the parking space location (e.g., Long Island Central Parking Lot)</td>
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
    <td>The house number where the parking space is located</td>
  </tr>
  <tr>
    <td>
      <code class="field">location_street</code>
      <div class="type">optional</div>
    </td>
    <td>The street name where the parking space is located</td>
  </tr>
  <tr>
    <td>
      <code class="field">location_city</code>
      <div class="type">optional</div>
    </td>
    <td>The city where the parking space is located</td>
  </tr>
  <tr>
    <td>
      <code class="field">location_postal_code</code>
      <div class="type">optional</div>
    </td>
    <td>The postal code where the parking space is located</td>
  </tr>
  <tr>
    <td>
      <code class="field">location_county</code>
      <div class="type">optional</div>
    </td>
    <td>The county where the parking space is located</td>
  </tr>
  <tr>
    <td>
      <code class="field">location_state</code>
      <div class="type">optional</div>
    </td>
    <td>The state where the parking space is located</td>
  </tr>
  <tr>
    <td>
      <code class="field">location_country</code>
      <div class="type">optional</div>
    </td>
    <td>The country where the parking space is located</td>
  </tr>
  <tr>
    <td>
      <code class="field">available_from</code>
      <div class="type required">required</div>
    </td>
    <td>The time from which the parking space can be made available. Specified as time in milliseconds since <a href="https://en.wikipedia.org/wiki/Unix_time">Epoch/Unix Time</a></td>
  </tr>
  <tr>
    <td>
      <code class="field">available_until</code>
      <div class="type required">required</div>
    </td>
    <td>The time until which the parking space can be made available. Specified as time in milliseconds since <a href="https://en.wikipedia.org/wiki/Unix_time">Epoch/Unix Time</a></td>
  </tr>
  <tr>
    <td>
      <code class="field">height</code>
      <div class="type">optional</div>
    </td>
    <td>The maximum vehicle height this parking space can accommodate. Specified as an integer representing centimeters</td>
  </tr>
  <tr>
    <td>
      <code class="field">width</code>
      <div class="type">optional</div>
    </td>
    <td>The maximum vehicle width this parking space can accommodate. Specified as an integer representing centimeters</td>
  </tr>
  <tr>
    <td>
      <code class="field">length</code>
      <div class="type">optional</div>
    </td>
    <td>The maximum vehicle length this parking space can accommodate. Specified as an integer representing centimeters</td>
  </tr>
  <tr>
    <td>
      <code class="field">weight</code>
      <div class="type">optional</div>
    </td>
    <td>The maximum vehicle weight this parking space can accommodate. Specified as an integer representing kilograms</td>
  </tr>
  <tr>
    <td>
      <code class="field">amenities</code>
      <div class="type">optional</div>
    </td>
    <td>A list of amenities that are present at this parking space. Specified as a comma separated list of amenity IDs. See <a href="#amenities">Amenities</a></td>
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
    <td><code>second</code></td>
    <td>The listed <code>price</code> is per second</td>
  </tr>
  <tr>
    <td><code>minute</code></td>
    <td>The listed <code>price</code> is per minute</td>
  </tr>
  <tr>
    <td><code>hour</code></td>
    <td>The listed <code>price</code> is per hour</td>
  </tr>
  <tr>
    <td><code>day</code></td>
    <td>The listed <code>price</code> is per day</td>
  </tr>
  <tr>
    <td><code>week</code></td>
    <td>The listed <code>price</code> is per week</td>
  </tr>
  <tr>
    <td><code>flat</code></td>
    <td>The listed <code>price</code> is a flat price</td>
  </tr>
</table>

# Amenities

A list of amentities can be included in both requests and responses.

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
    <td>EV Charging</td>
  </tr>
  <tr>
    <td><code>5</code></td>
    <td>Valet Parking</td>
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

