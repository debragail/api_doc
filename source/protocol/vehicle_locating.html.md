---
title: Vehicle Locating

language_tabs: # must be one of https://git.io/vQNgJ
  - shell
  - javascript
  - python

toc_footers:
  - Documentation powered by <a href="https://github.com/lord/slate" target="blank">Slate</a>.

search: true
---

<p class="header-image"><img src="/images/vehicle_locating/header.png" alt="Vehicle Locating"></p>

#  Vehicle Locating Protocol

The Vehicle Locating communication protocol describes the format of a request (also referred to as `need`) for locating a lost vehicle, and the response (`bid`) sent by other vehicles that are able to help locating it. The need would typically be sent by the vehicle owner, the vehicle itself, or a rescue service.

For example, a drone on a delivery mission runs out of battery and performs an emergency landing. The drone owner that lost the connection with their drone sends a request for locating assistance, along with the drone's last known coordinates, its model, color, and any other information that might help in finding it.

> Need

```shell
curl "discovery_endpoint_here" \
  --data "last_latitude=55.770279" \
  --data "last_longitude=37.781467" \
  --data "vehicle_type=drone" \
  --data "vehicle_manufacturer=Copter Express" \
  --data "vehicle_model=COPTEREXPRESS X1" \
  --data "vehicle_color=White" \
  --data "vehicle_contact=Andrei Ivanov, mobile: +7 555-338-5943"
```

```javascript
const discoveryEndPoint = "discovery_endpoint_here";

fetch(discoveryEndPoint, {
  method: "POST",
  body: JSON.stringify({
    "last_latitude": "55.770279",
    "last_longitude": "37.781467",
    "vehicle_type": "drone",
    "vehicle_manufacturer": "Copter Express",
    "vehicle_model": "COPTEREXPRESS X1",
    "vehicle_color": "White",
    "vehicle_contact": "Andrei Ivanov, mobile: +7 555-338-5943",
  })
});
```

```python
import requests
payload = {
    "last_latitude": "55.770279",
    "last_longitude": "37.781467",
    "vehicle_type": "drone",
    "vehicle_manufacturer": "Copter Express",
    "vehicle_model": "COPTEREXPRESS X1",
    "vehicle_color": "White",
    "vehicle_contact": "Andrei Ivanov, mobile: +7 555-338-5943",
  }
requests.post("discovery_endpoint_here", data=payload)
```

In response, an autonomous robot might send back a bid with a price for the mission, the distance from the lost vehicle's location and the estimated time of arrival at the location.

> Bid

```shell
curl "bidding_endpoint_here" \
  --data "request_uid=ae7bd8f67f3089c" \
  --data "expires_at=2017-12-11T15:18:59+03:00" \
  --data "price=20000000000000000,10000000000000" \
  --data "price_type=flat,minute" \
  --data "price_description=Finders fee,Price per minute" \
  --data "current_latitude=55.756951" \
  --data "current_longitude=37.633839" \
  --data "arrival_at=2017-12-11T15:18:54+03:00" \
  --data "vehicle_type=robot" \
  --data "vehicle_manufacturer=Husarion" \
  --data "vehicle_model=ROSBot"
```

```javascript
const biddingEndPoint = "bidding_endpoint_here";

fetch(biddingEndPoint, {
  method: "POST",
  body: JSON.stringify({
    "request_uid": "ae7bd8f67f3089c",
    "expires_at": "2017-12-11T15:18:59+03:00",
    "price": "20000000000000000,10000000000000",
    "price_type": "flat,minute",
    "price_description": "Finders fee,Price per minute",
    "current_latitude": "55.756951",
    "current_longitude": "37.633839",
    "arrival_at": "2017-12-11T15:18:54+03:00",
    "vehicle_type": "robot",
    "vehicle_manufacturer": "Husarion",
    "vehicle_model": "ROSBot",
  })
});
```

```python
import requests
payload = {
    "request_uid": "ae7bd8f67f3089c",
    "expires_at": "2017-12-11T15:18:59+03:00",
    "price": "20000000000000000,10000000000000",
    "price_type": "flat,minute",
    "price_description": "Finders fee,Price per minute",
    "current_latitude": "55.756951",
    "current_longitude": "37.633839",
    "arrival_at": "2017-12-11T15:18:54+03:00",
    "vehicle_type": "robot",
    "vehicle_manufacturer": "Husarion",
    "vehicle_model": "ROSBot",
  }
requests.post("bidding_endpoint_here", data=payload)
```

# Need

A statement of need for locating a vehicle. Typically this will be sent by a vehicle owner that is looking for assistance in finding their lost vehicle.

This request is sent to the decentralized discovery engine which responds with status `200` and a unique identifier for this request. The details of this request are then broadcasted to DAV entities that can provide this service. <a href="#bid">Bids</a> are later received as separate calls.

## Arguments

> Post request to a local/remote discovery endpoint

```shell
curl "discovery_endpoint_here" \
  --data "last_latitude=43.610159" \
  --data "last_longitude=-116.783196" \
  --data "vehicle_type=car" \
  --data "vehicle_manufacturer=Tesla" \
  --data "vehicle_model=Model S" \
  --data "vehicle_color=Black" \
  --data "vehicle_license_number=6GDG486" \
  --data "vehicle_contact=James McGill, mobile: 555-338-5943"
```

```javascript
const discoveryEndPoint = "discovery_endpoint_here";

fetch(discoveryEndPoint, {
  method: "POST",
  body: JSON.stringify({
    "last_latitude": "43.610159",
    "last_longitude": "-116.783196",
    "vehicle_type": "car",
    "vehicle_manufacturer": "Tesla",
    "vehicle_model": "Model S",
    "vehicle_color": "Black",
    "vehicle_license_number": "6GDG486",
    "vehicle_contact": "James McGill, mobile: 555-338-5943",
  })
});
```

```python
import requests
payload = {
    "last_latitude": "43.610159",
    "last_longitude": "-116.783196",
    "vehicle_type": "car",
    "vehicle_manufacturer": "Tesla",
    "vehicle_model": "Model S",
    "vehicle_color": "Black",
    "vehicle_license_number": "6GDG486",
    "vehicle_contact": "James McGill, mobile: 555-338-5943",
  }
requests.post("discovery_endpoint_here", data=payload)
```

<table class="arguments">
  <tr>
    <td>
      <code class="field">last_latitude</code>
      <div class="type required">required</div>
    </td>
    <td>The last recorded latitude coordinate of the lost vehicle</td>
  </tr>
  <tr>
    <td>
      <code class="field">last_longitude</code>
      <div class="type required">required</div>
    </td>
    <td>The last recorded longitude coordinate of the lost vehicle</td>
  </tr>
  <tr>
    <td>
      <code class="field">vehicle_type</code>
      <div class="type required">required</div>
    </td>
    <td>The type of vehicle that was lost. See full list of options <a href="#vehicle-types">here</a></td>
  </tr>
  <tr>
  <tr>
    <td>
      <code class="field">vehicle_manufacturer</code>
      <div class="type required">required</div>
    </td>
    <td>Name of the manufacturer of the lost vehicle</td>
  </tr>
  <tr>
    <td>
      <code class="field">vehicle_model</code>
      <div class="type required">required</div>
    </td>
    <td>Name of the model of the lost vehicle</td>
  </tr>
  <tr>
    <td>
      <code class="field">vehicle_color</code>
      <div class="type">optional</div>
    </td>
    <td>The color of the lost vehicle</td>
  </tr>
  <tr>
    <td>
      <code class="field">vehicle_license_number</code>
      <div class="type">optional</div>
    </td>
    <td>The license plate number of the lost vehicle</td>
  </tr>
  <tr>
    <td>
      <code class="field">vehicle_contact</code>
      <div class="type">optional</div>
    </td>
    <td>Human readable information regarding the lost vehicle (e.g., <code>Vehicle owner: James McGill, mobile: 555-338-5943</code>)</td>
  </tr>
</table>

# Bid

A bid to provide a vehicle locating service. Typically sent by a vehicle with locating capabilities, with the price for the mission, the distance from the lost vehicle's location and the estimated time of arrival.

## Arguments

> Post request to a local/remote endpoint representing the rider

```shell
curl "bidding_endpoint_here" \
  --data "request_uid=ae7bd8f67f3089c" \
  --data "expires_at=2017-12-11T15:18:59+03:00" \
  --data "price=20000000000000000,10000000000000" \
  --data "price_type=flat,minute" \
  --data "price_description=Finders fee,Price per minute" \
  --data "current_latitude=43.611626" \
  --data "current_longitude=-116.392593" \
  --data "arrival_at=2017-12-11T15:18:54+03:00" \
  --data "vehicle_type=drone" \
  --data "vehicle_manufacturer=Dronster" \
  --data "vehicle_model=Res-Q" \
  --data "vehicle_contact=Dronster Rescue Missions LTD. www.dronster.com"
```

```javascript
const biddingEndPoint = "bidding_endpoint_here";

fetch(biddingEndPoint, {
  method: "POST",
  body: JSON.stringify({
    "request_uid": "ae7bd8f67f3089c",
    "expires_at": "2017-12-11T15:18:59+03:00",
    "price": "20000000000000000,10000000000000",
    "price_type": "flat,minute",
    "price_description": "Finders fee,Price per minute",
    "current_latitude": "43.611626",
    "current_longitude": "-116.392593",
    "arrival_at": "2017-12-11T15:18:54+03:00",
    "vehicle_type": "drone",
    "vehicle_manufacturer": "Dronster",
    "vehicle_model": "Res-Q",
    "vehicle_contact": "Dronster Rescue Missions LTD. www.dronster.com",
  })
});
```

```python
import requests
payload = {
    "request_uid": "ae7bd8f67f3089c",
    "expires_at": "2017-12-11T15:18:59+03:00",
    "price": "20000000000000000,10000000000000",
    "price_type": "flat,minute",
    "price_description": "Finders fee,Price per minute",
    "current_latitude": "43.611626",
    "current_longitude": "-116.392593",
    "arrival_at": "2017-12-11T15:18:54+03:00",
    "vehicle_type": "drone",
    "vehicle_locating_technology": "Object Recognition Camera",
    "vehicle_manufacturer": "Dronster",
    "vehicle_model": "Res-Q",
    "vehicle_contact": "Dronster Rescue Missions LTD. www.dronster.com",
  }
requests.post("bidding_endpoint_here", data=payload)
```

<table class="arguments">
  <tr>
    <td>
      <code class="field">request_uid</code>
      <div class="type required">required</div>
    </td>
    <td>The UID of the request. This arrives as part of the request</td>
  </tr>
  <tr>
    <td>
      <code class="field">expires_at</code>
      <div class="type required">required</div>
    </td>
    <td>This bid will expire at this time. Specified in <a href="https://en.wikipedia.org/wiki/ISO_8601" target="blank">ISO 8601</a> including date, time, and time offset from UTC</td>
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
      <code class="field">arrival_at</code>
      <div class="type required">required</div>
    </td>
    <td>The estimated time of arrival at the location where the lost vehicle was last seen. Specified in <a href="https://en.wikipedia.org/wiki/ISO_8601" target="blank">ISO 8601</a> including date, time, and time offset from UTC</td>
  </tr>
  <tr>
    <td>
      <code class="field">vehicle_type</code>
      <div class="type required">required</div>
    </td>
    <td>The type of vehicle used for the locating mission. See full list of options <a href="#vehicle-types">here</a>
    </td>
  </tr>
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
      <code class="field">vehicle_contact</code>
      <div class="type">optional</div>
    </td>
    <td>Human readable information regarding the vehicle (e.g <code>James McGill, mobile: 555-338-5943</code>)</td>
  </tr>
</table>

# Vehicle Types

The type of vehicles and their unique identifier.

<table class="lost_vehicles">
  <tr>
    <th>Vehicle Type</th>
  </tr>
  <tr>
    <td><code>drone</code></td>
  </tr>
  <tr>
    <td><code>car</code></td>
  </tr>
  <tr>
    <td><code>truck</code></td>
  </tr>
  <tr>
    <td><code>van</code></td>
  </tr>
  <tr>
    <td><code>ship</code></td>
  </tr>
  <tr>
    <td><code>robot</code></td>
  </tr>
 <tr>
    <td><code>bike</code></td>
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
