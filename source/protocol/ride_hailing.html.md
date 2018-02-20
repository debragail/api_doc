---
title: Ride Hailing

language_tabs: # must be one of https://git.io/vQNgJ
  - shell
  - javascript
  - python

toc_footers:
  - Documentation powered by <a href="https://github.com/lord/slate" target="blank">Slate</a>.

search: true
---

<p class="header-image"><img src="/images/ride_hailing/header.png" alt="Ride Hailing"></p>

#  Ride Hailing Protocol

The communication protocol for ride hailing describes the format of a request for a ride (also referred to as `need`) sent by a user, and the response (`bid`) sent by vehicle, driver, or car owner.

For example, a user might search for a ride together with her pet dog, within a radius of 3 km of a given coordinate to a destination 2 km away.

> Need

```shell
curl "discovery_endpoint_here" \
  --data "pickup_at=1519093577681" \
  --data "pickup_latitude=32.787793" \
  --data "pickup_longitude=-79.935005" \
  --data "destination_latitude=32.7693531" \
  --data "destination_longitude=-79.9296352" \
  --data "radius=3000" \
  --data "additional_features=pet_transport"
```

```javascript
const discoveryEndPoint = "discovery_endpoint_here";

fetch(discoveryEndPoint, {
  method: "POST",
  body: JSON.stringify({
    "pickup_at": "2017-12-11T15:18:54+03:00",
    "pickup_latitude": "32.787793",
    "pickup_longitude": "-79.935005",
    "destination_latitude": "32.7693531",
    "destination_longitude": "-79.9296352",
    "radius": "3000",
    "additional_features": "pet_transport",
  })
});
```

```python
import requests
payload = {
    "pickup_at": "1519093577681",
    "pickup_latitude": "32.787793",
    "pickup_longitude": "-79.935005",
    "destination_latitude": "32.7693531",
    "destination_longitude": "-79.9296352",
    "radius": "3000",
    "additional_features": "pet_transport",
  }
requests.post("discovery_endpoint_here", data=payload)
```

In response, an autonomous vehicle might send back a bid with a price for the ride, the vehicle type and model, and the estimated time of arrival.

> Bid

```shell
curl "bidding_endpoint_here" \
  --data "need_id=ae7bd8f67f3089c" \
  --data "expires_at=2017-12-11T15:18:59+03:00" \
  --data "price=20000000000000000,20000000000000000" \
  --data "price_type=km,flat" \
  --data "price_description=Price per km,City tax" \
  --data "current_latitude=32.785889" \
  --data "current_longitude=-79.935569" \
  --data "pickup_at=2017-12-11T15:18:54+03:00" \
  --data "vehicle_type=suv" \
  --data "vehicle_manufacturer=Luxor" \
  --data "vehicle_model=Suave" \
  --data "vehicle_color=Sapphire" \
  --data "vehicle_license_number=92 321 87" \
```

```javascript
const biddingEndPoint = "bidding_endpoint_here";

fetch(biddingEndPoint, {
  method: "POST",
  body: JSON.stringify({
    "need_id": "ae7bd8f67f3089c",
    "expires_at": "2017-12-11T15:18:59+03:00",
    "price": "20000000000000000,20000000000000000",
    "price_type": "km,flat",
    "price_description": "Price per km,City tax",
    "current_latitude": "32.785889",
    "current_longitude": "-79.935569",
    "pickup_at": "2017-12-11T15:18:54+03:00",
    "vehicle_type": "suv",
    "vehicle_manufacturer": "Luxor",
    "vehicle_model": "Suave",
    "vehicle_color": "Sapphire",
    "vehicle_license_number": "92 321 87",
  })
});
```

```python
import requests
payload = {
    "need_id": "ae7bd8f67f3089c",
    "expires_at": "2017-12-11T15:18:59+03:00",
    "price": "20000000000000000,20000000000000000",
    "price_type": "km,flat",
    "price_description": "Price per km,City tax",
    "current_latitude": "32.785889",
    "current_longitude": "-79.935569",
    "pickup_at": "2017-12-11T15:18:54+03:00",
    "vehicle_type": "suv",
    "vehicle_manufacturer": "Luxor",
    "vehicle_model": "Suave",
    "vehicle_color": "Sapphire",
    "vehicle_license_number": "92 321 87",
  }
requests.post("bidding_endpoint_here", data=payload)
```

# Need

A statement of need for a ride. Typically this will be sent by a user that is looking for a ride to a certain destination.

This request is sent to the decentralized discovery engine which responds with status `200` and a unique identifier for this request. The details of this request are then broadcasted to DAV entities that can provide this service. <a href="#bid">Bids</a> are later received as separate calls.

## Arguments

> Post request to a local/remote discovery endpoint

```shell
curl "discovery_endpoint_here" \
  --data "pickup_at=2017-12-11T15:18:54+03:00" \
  --data "pickup_latitude=32.787793" \
  --data "pickup_longitude=-79.935005" \
  --data "pickup_street=King" \
  --data "pickup_house_number=372" \
  --data "pickup_city=Charleston" \
  --data "pickup_postal_code=29401" \
  --data "pickup_county=Charleston" \
  --data "pickup_state=SC" \
  --data "pickup_country=USA" \
  --data "pickup_location_name=IKEA parking lot B" \
  --data "pickup_location_name_lang=eng" \
  --data "radius=1500" \
  --data "destination_latitude=32.7693531" \
  --data "destination_longitude=-79.9296352" \
  --data "destination_street=Murray Blvd" \
  --data "destination_house_number=2" \
  --data "destination_city=Charleston" \
  --data "destination_postal_code=29401" \
  --data "destination_county=Charleston" \
  --data "destination_state=SC" \
  --data "destination_country=USA" \
  --data "destination_location_name=Oyster Point" \
  --data "destination_location_name_lang=eng" \
  --data "vehicle_type=suv" \
  --data "passengers=3" \
  --data "additional_features=assisted"
```

```javascript
const discoveryEndPoint = "discovery_endpoint_here";

fetch(discoveryEndPoint, {
  method: "POST",
  body: JSON.stringify({
    "pickup_at": "2017-12-11T15:18:54+03:00",
    "pickup_latitude": "32.787793",
    "pickup_longitude": "-79.935005",
    "pickup_street": "King",
    "pickup_house_number": "372",
    "pickup_city": "Charleston",
    "pickup_postal_code": "29401",
    "pickup_county": "Charleston",
    "pickup_state": "SC",
    "pickup_country": "USA",
    "pickup_location_name": "IKEA parking lot B",
    "pickup_location_name_lang": "eng",
    "radius": "1500",
    "destination_latitude": "32.7693531",
    "destination_longitude": "-79.9296352",
    "destination_street": "Murray Blvd",
    "destination_house_number": "2",
    "destination_city": "Charleston",
    "destination_postal_code": "29401",
    "destination_county": "Charleston",
    "destination_state": "SC",
    "destination_country": "USA",
    "destination_location_name": "Oyster Point",
    "destination_location_name_lang": "eng",
    "vehicle_type": "suv",
    "passengers": "3",
    "additional_features": "assisted",
  })
});
```

```python
import requests
payload = {
    "pickup_at": "2017-12-11T15:18:54+03:00",
    "pickup_latitude": "32.787793",
    "pickup_longitude": "-79.935005",
    "pickup_street": "King",
    "pickup_house_number": "372",
    "pickup_city": "Charleston",
    "pickup_postal_code": "29401",
    "pickup_county": "Charleston",
    "pickup_state": "SC",
    "pickup_country": "USA",
    "pickup_location_name": "IKEA parking lot B",
    "pickup_location_name_lang": "eng",
    "radius": "1500",
    "destination_latitude": "32.7693531",
    "destination_longitude": "-79.9296352",
    "destination_street": "Murray Blvd",
    "destination_house_number": "2",
    "destination_city": "Charleston",
    "destination_postal_code": "29401",
    "destination_county": "Charleston",
    "destination_state": "SC",
    "destination_country": "USA",
    "destination_location_name": "Oyster Point",
    "destination_location_name_lang": "eng",
    "vehicle_type": "suv",
    "passengers": "3",
    "additional_features": "assisted",
  }
requests.post("discovery_endpoint_here", data=payload)
```

<table class="arguments">
  <tr>
    <td>
      <code class="field">pickup_at</code>
      <div class="type">optional</div>
    </td>
    <td>The time at which the requester would like to be picked up (if undefined, pick up time will be ASAP). Specified as time in milliseconds since <a href="https://en.wikipedia.org/wiki/Unix_time">Epoch/Unix Time</a></td>
  </tr>
  <tr>
    <td>
      <code class="field">pickup_latitude</code>
      <div class="type required">required</div>
    </td>
    <td>The latitude coordinate of the pickup location</td>
  </tr>
  <tr>
    <td>
      <code class="field">pickup_longitude</code>
      <div class="type required">required</div>
    </td>
    <td>The longitude coordinate of the pickup location</td>
  </tr>
  <tr>
    <td>
      <code class="field">pickup_street</code>
      <div class="type">optional</div>
    </td>
    <td>The street name of the pick up location</td>
  </tr>
  <tr>
    <td>
      <code class="field">pickup_house_number</code>
      <div class="type">optional</div>
    </td>
    <td>The house number of the pick up location</td>
  </tr>
  <tr>
    <td>
      <code class="field">pickup_city</code>
      <div class="type">optional</div>
    </td>
    <td>The city of the pick up location</td>
  </tr>
  <tr>
    <td>
      <code class="field">pickup_postal_code</code>
      <div class="type">optional</div>
    </td>
    <td>The postal code of the pick up location</td>
  </tr>
  <tr>
    <td>
      <code class="field">pickup_county</code>
      <div class="type">optional</div>
    </td>
    <td>The county of the pick up location</td>
  </tr>
  <tr>
    <td>
      <code class="field">pickup_state</code>
      <div class="type">optional</div>
    </td>
    <td>The state of the pick up location</td>
  </tr>
  <tr>
    <td>
      <code class="field">pickup_country</code>
      <div class="type">optional</div>
    </td>
    <td>The country of the pick up location</td>
  </tr>
  <tr>
    <td>
      <code class="field">pickup_location_name</code>
      <div class="type">optional</div>
    </td>
    <td>A human readable name/description of the pick up location (e.g., Bayonne Crossing Shopping Center New Jersey)</td>
  </tr>
  <tr>
    <td>
      <code class="field">pickup_location_name_lang</code>
      <div class="type">optional</div>
    </td>
    <td>The language used in <code>pickup_location_name</code>. Specified using the 3 letter <a href="https://en.wikipedia.org/wiki/ISO_639-3" target="blank">ISO 639-3</a> language code</td>
  </tr>
  <tr>
    <td>
      <code class="field">radius</code>
      <div class="type">optional</div>
    </td>
    <td>Radius in meters around the search coordinates to limit the search to. Specified as an integer</td>
  </tr>
  <tr>
    <td>
      <code class="field">destination_latitude</code>
      <div class="type required">required</div>
    </td>
    <td>The latitude coordinate of the dropoff destination</td>
  </tr>
  <tr>
    <td>
      <code class="field">destination_longitude</code>
      <div class="type required">required</div>
    </td>
    <td>The longitude coordinate of the dropoff destination</td>
  </tr>
  <tr>
    <td>
      <code class="field">destination_street</code>
      <div class="type">optional</div>
    </td>
    <td>The street name of the destination</td>
  </tr>
  <tr>
    <td>
      <code class="field">destination_house_number</code>
      <div class="type">optional</div>
    </td>
    <td>The house number of the destination</td>
  </tr>
  <tr>
    <td>
      <code class="field">destination_city</code>
      <div class="type">optional</div>
    </td>
    <td>The city of the destination</td>
  </tr>
  <tr>
    <td>
      <code class="field">destination_postal_code</code>
      <div class="type">optional</div>
    </td>
    <td>The postal code of the destination</td>
  </tr>
  <tr>
    <td>
      <code class="field">destination_county</code>
      <div class="type">optional</div>
    </td>
    <td>The county of the destination</td>
  </tr>
  <tr>
    <td>
      <code class="field">destination_state</code>
      <div class="type">optional</div>
    </td>
    <td>The state of the destination</td>
  </tr>
  <tr>
    <td>
      <code class="field">destination_country</code>
      <div class="type">optional</div>
    </td>
    <td>The country of the destination</td>
  </tr>
  <tr>
    <td>
      <code class="field">destination_location_name</code>
      <div class="type">optional</div>
    </td>
    <td>A human readable name/description of the destination location (e.g., Stadium Plaza Shopping Center New Jersey)</td>
  </tr>
  <tr>
    <td>
      <code class="field">destination_location_name_lang</code>
      <div class="type">optional</div>
    </td>
    <td>The language used in <code>destination_location_name_lang</code>. Specified using the 3 letter <a href="https://en.wikipedia.org/wiki/ISO_639-3" target="blank">ISO 639-3</a> language code</td>
  </tr>
  <tr>
    <td>
      <code class="field">vehicle_type</code>
      <div class="type">optional</div>
    </td>
    <td>The type of vehicle required for the ride. See full list of options <a href="#vehicle-types">here</a></td>
  </tr>
    <tr>
    <td>
      <code class="field">passengers</code>
      <div class="type required">required</div>
    </td>
    <td>The total number of passengers the vehicle should accommodate</td>
  </tr>
  <tr>
    <td>
      <code class="field">additional_features</code>
      <div class="type">optional</div>
    </td>
    <td>Vehicles may provide additional features. See full list of options <a href="#additional-features">here</a></td>
  </tr>
</table>

# Bid

A bid to provide a ride service. Typically sent by a car owner with the price for the ride, the distance from the pick up location and the estimated time of arrival.

## Arguments

> Post request to a local/remote endpoint representing the rider

```shell
curl "bidding_endpoint_here" \
  --data "need_id=ae7bd8f67f3089c" \
  --data "expires_at=2017-12-11T15:18:59+03:00" \
  --data "price=20000000000000000,4000000000000000" \
  --data "price_type=km,km" \
  --data "price_description=Price per km,VAT per km" \
  --data "current_latitude=32.785889" \
  --data "current_longitude=-79.935569" \
  --data "pickup_at=2017-12-11T15:18:54+03:00" \
  --data "vehicle_type=suv" \
  --data "vehicle_manufacturer=Luxor" \
  --data "vehicle_model=Suave" \
  --data "vehicle_color=Sapphire" \
  --data "vehicle_license_number=92 321 87" \
  --data "vehicle_contact=James McGill, mobile: 555-338-5943" \
  --data "additional_features=assisted"
```

```javascript
const biddingEndPoint = "bidding_endpoint_here";

fetch(biddingEndPoint, {
  method: "POST",
  body: JSON.stringify({
    "need_id": "ae7bd8f67f3089c",
    "expires_at": "2017-12-11T15:18:59+03:00",
    "price": "20000000000000000,4000000000000000",
    "price_type": "km,km",
    "price_description": "Price per km,VAT per km",
    "current_latitude": "32.785889",
    "current_longitude": "-79.935569",
    "pickup_at": "2017-12-11T15:18:54+03:00",
    "vehicle_type": "suv",
    "vehicle_manufacturer": "Luxor",
    "vehicle_model": "Suave",
    "vehicle_color": "Sapphire",
    "vehicle_license_number": "92 321 87",
    "vehicle_contact": "James McGill, mobile: 555-338-5943",
    "additional_features": "assisted",
  })
});
```

```python
import requests
payload = {
    "need_id": "ae7bd8f67f3089c",
    "expires_at": "2017-12-11T15:18:59+03:00",
    "price": "20000000000000000,4000000000000000",
    "price_type": "km,km",
    "price_description": "Price per km,VAT per km",
    "current_latitude": "32.785889",
    "current_longitude": "-79.935569",
    "pickup_at": "2017-12-11T15:18:54+03:00",
    "vehicle_type": "suv",
    "vehicle_manufacturer": "Luxor",
    "vehicle_model": "Suave",
    "vehicle_color": "Sapphire",
    "vehicle_license_number": "92 321 87",
    "vehicle_contact": "James McGill, mobile: 555-338-5943",
    "additional_features": "assisted",
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
      <code class="field">current_latitude</code>
      <div class="type required">required</div>
    </td>
    <td>The latitude coordinate of of where the vehicle is currently located</td>
  </tr>
  <tr>
    <td>
      <code class="field">current_longitude</code>
      <div class="type required">required</div>
    </td>
    <td>The longitude coordinate of where the vehicle is currently located</td>
  </tr>
  <tr>
    <td>
      <code class="field">pickup_at</code>
      <div class="type required">required</div>
    </td>
    <td>The estimated time of arrival at the pick up location. Specified as time in milliseconds since <a href="https://en.wikipedia.org/wiki/Unix_time">Epoch/Unix Time</a></td>
  </tr>
  <tr>
    <td>
      <code class="field">vehicle_type</code>
      <div class="type required">required</div>
    </td>
    <td>The type of vehicle used for the ride. See full list of options <a href="#vehicle-types">here</a></td>
  </tr>
  <tr>
  <tr>
    <td>
      <code class="field">vehicle_manufacturer</code>
      <div class="type">optional</div>
    </td>
    <td>Name of the manufacturer of the vehicle</td>
  </tr>
  <tr>
    <td>
      <code class="field">vehicle_model</code>
      <div class="type">optional</div>
    </td>
    <td>Name of the model of the vehicle</td>
  </tr>
  <tr>
    <td>
      <code class="field">vehicle_color</code>
      <div class="type">optional</div>
    </td>
    <td>The color of the vehicle</td>
  </tr>
  <tr>
    <td>
      <code class="field">vehicle_license_number</code>
      <div class="type">optional</div>
    </td>
    <td>The license plate number of the vehicle</td>
  </tr>
  <tr>
    <td>
      <code class="field">vehicle_contact</code>
      <div class="type">optional</div>
    </td>
    <td>Human readable information regarding the vehicle (e.g <code>James McGill, mobile: 555-338-5943</code>)</td>
  </tr>
  <tr>
    <td>
      <code class="field">additional_features</code>
      <div class="type">optional</div>
    </td>
    <td>Vehicles may provide additional features. See full list of options <a href="#additional-features">here</a></td>
  </tr>
</table>

# Vehicle Types

The type of vehicles and their unique identifier.

<table class="vehicle_types">
  <tr>
    <th>Vehicle Type</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><code>sedan</code></td>
    <td>Standard private car</td>
  </tr>
  <tr>
    <td><code>station</code></td>
    <td>Extended Sedan with extra room for luggage</td>
  </tr>
  <tr>
    <td><code>suv</code></td>
    <td>A kind of station wagon with off-road vehicle features such as raised ground clearance and ruggedness</td>
  </tr>
  <tr>
    <td><code>luxury</code></td>
    <td>A vehicle with higher quality equipment, better performance and enhanced comfort</td>
  </tr>
</table>

# Additional Features

Vehicles may provide additional features such as wheelchair access etc., below are the available features and their unique identifier.

<table class="vehicle_types">
  <tr>
    <th>Requirement</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><code>assisted</code></td>
    <td>Wheelchair access available</td>
  </tr>
  <tr>
    <td><code>pet_transport</code></td>
    <td>Pet transport is allowed</td>
  </tr>
  <tr>
    <td><code>ride_share</code></td>
    <td>Ride sharing is allowed</td>
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
  <tr>
    <td><code>km</code></td>
    <td>The listed <code>price</code> is per km</td>
  </tr>
  <tr>
    <td><code>mile</code></td>
    <td>The listed <code>price</code> is per mile</td>
  </tr>
</table>
