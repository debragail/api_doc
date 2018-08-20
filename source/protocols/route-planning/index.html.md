---
title: Route Planning

language_tabs: # must be one of https://git.io/vQNgJ
  - shell
  - javascript
  - python

toc_footers:
  - Documentation powered by <a href="https://github.com/lord/slate" target="blank">Slate</a>.

search: true
---

<p class="header-image"><img src="/images/route_planning/header.png" alt="Route Planning"></p>

# Route Planning Protocol

The following document describes the communication protocol for a route planning service provided by a route planner to a vehicle or a vehicle owner. It includes the format for both the request for a route plan (also referred to as `need`) and the response sent by route planners that `bid` on providing the service.

For example, an autonomous drone that needs to fly to a destination in the Nevada desert would send a request for a route plan for drones, along with the start and end coordinates, and the maximum altitude it can reach.

> Need

```shell
curl "discovery_endpoint_here" \
  --data "{ \
    \"start_at\": \"1513005534000\", \
    \"start_latitude\": \"38.802610\", \
    \"start_longitude\": \"-116.419389\", \
    \"end_latitude\": \"38.807643\", \
    \"end_longitude\": \"-116.587960\", \
    \"vehicle_type\": \"drone\", \
    \"max_altitude\": \"400\" \
  }"
```

```javascript
const discoveryEndPoint = "discovery_endpoint_here";

fetch(discoveryEndPoint, {
  method: "POST",
  body: JSON.stringify({
    "start_at": "1513005534000",
    "start_latitude": "38.802610",
    "start_longitude": "-116.419389",
    "end_latitude": "38.807643",
    "end_longitude": "-116.587960",
    "vehicle_type": "drone",
    "max_altitude": "400",
  })
});
```

```python
import requests
payload = {
    "start_at": "1513005534000",
    "start_latitude": "38.802610",
    "start_longitude": "-116.419389",
    "end_latitude": "38.807643",
    "end_longitude": "-116.587960",
    "vehicle_type": "drone",
    "max_altitude": "400",
  }
requests.post("discovery_endpoint_here", data=payload)
```

In response, a route planner might send back a bid with the price for the service, and the estimated time of when the route plan will be delivered.

> Bid

```shell
curl "bidding_endpoint_here" \
--data "{ \
    \"need_id\": \"ae7bd8f67f3089c\", \
    \"expires_at\": \"1513005539000\", \
    \"price\": \"100000000000000000\", \
    \"price_type\": \"flat\", \
    \"price_description\": \"Total price\", \
    \"eta\": \"1513178334000\" \
  }"
```

```javascript
const biddingEndPoint = "bidding_endpoint_here";

fetch(biddingEndPoint, {
  method: "POST",
  body: JSON.stringify({
    "need_id": "ae7bd8f67f3089c",
    "expires_at": "1513005539000",
    "price": "100000000000000000",
    "price_type": "flat",
    "price_description": "Total price",
    "eta": "1513178334000",
  })
});
```

```python
import requests
payload = {
    "need_id": "ae7bd8f67f3089c",
    "expires_at": "1513005539000",
    "price": "100000000000000000",
    "price_type": "flat",
    "price_description": "Total price",
    "eta": "1513178334000",
  }
requests.post("bidding_endpoint_here", data=payload)
```

# Need

A statement of need for a route planning service. Typically this will be sent by a vehicle or a vehicle owner that plans to travel from one point to another.

This request is sent to the decentralized discovery engine which responds with status `200` and a unique identifier for this request. The details of this request are then broadcasted to DAV entities that can provide this service. <a href="#bid">Bids</a> are later received as separate calls.

## Arguments

> Post request to a local/remote discovery endpoint

```shell
curl "discovery_endpoint_here" \
  --data "{ \
    \"start_at\": \"1513005534000\", \
    \"start_latitude\": \"38.802610\", \
    \"start_longitude\": \"-116.419389\", \
    \"end_latitude\": \"38.807643\", \
    \"end_longitude\": \"-116.587960\", \
    \"vehicle_type\": \"drone\", \
    \"max_altitude\": \"400\", \
    \"height\": \"11\", \
    \"width\": \"22\", \
    \"length\": \"28\", \
    \"weight\": \"2\" \
  }"
```

```javascript
const discoveryEndPoint = "discovery_endpoint_here";

fetch(discoveryEndPoint, {
  method: "POST",
  body: JSON.stringify({
    "start_at": "1513005534000",
    "start_latitude": "38.802610",
    "start_longitude": "-116.419389",
    "end_latitude": "38.807643",
    "end_longitude": "-116.587960",
    "vehicle_type": "drone",
    "max_altitude": "400",
    "height": "11",
    "width": "22",
    "length": "28",
    "weight": "2",
  })
});
```

```python
import requests
payload = {
    "start_at": "1513005534000",
    "start_latitude": "38.802610",
    "start_longitude": "-116.419389",
    "end_latitude": "38.807643",
    "end_longitude": "-116.587960",
    "vehicle_type": "drone",
    "max_altitude": "400",
    "height": "11",
    "width": "22",
    "length": "28",
    "weight": "2",
  }
requests.post("discovery_endpoint_here", data=payload)
```

<table class="arguments">
  <tr>
    <td>
      <code class="field">start_at</code>
      <div class="type">optional</div>
    </td>
    <td>
      The time at which the requester would like to start the trip (if undefined, start time will be set by the route planner). This should be Specified as time in milliseconds since <a href="https://en.wikipedia.org/wiki/Unix_time" target="blank">Epoch/Unix Time</a>
    </td>
  </tr>
  <tr>
    <td>
      <code class="field">start_latitude</code>
      <div class="type required">required</div>
    </td>
    <td>The latitude coordinate of the starting point, from where the vehicle plans to start the trip</td>
  </tr>
  <tr>
    <td>
      <code class="field">start_longitude</code>
      <div class="type required">required</div>
    </td>
    <td>The longitude coordinate of the starting point, from where the vehicle plans start the trip</td>
  </tr>
  <tr>
    <td>
      <code class="field">end_latitude</code>
      <div class="type required">required</div>
    </td>
    <td>The latitude coordinate of the ending point, where the vehicle plans end the trip</td>
  </tr>
  <tr>
    <td>
      <code class="field">end_longitude</code>
      <div class="type required">required</div>
    </td>
    <td>The longitude coordinate of the ending point, where the vehicle plans end the trip</td>
  </tr>
  <tr>
    <td>
      <code class="field">vehicle_type</code>
      <div class="type required">required</div>
    </td>
    <td>The type of vehicle used for the trip. See full list of options <a href="#vehicle-types">here</a>
    </td>
  </tr>
  <tr>
    <td>
      <code class="field">max_altitude</code>
      <div class="type">optional</div>
    </td>
    <td>In case the vehicle is a drone, <code>max_altitude</code> represents the maximum reachable altitude of the drone. Specified as an integer representing meters</a>
    </td>
  </tr>
  <tr>
    <td>
      <code class="field">height</code>
      <div class="type">optional</div>
    </td>
    <td>The height of the vehicle. Specified as an integer representing centimeters</td>
  </tr>
  <tr>
    <td>
      <code class="field">width</code>
      <div class="type">optional</div>
    </td>
    <td>The width of the vehicle. Specified as an integer representing centimeters</td>
  </tr>
  <tr>
    <td>
      <code class="field">length</code>
      <div class="type">optional</div>
    </td>
    <td>The length of the vehicle. Specified as an integer representing centimeters</td>
  </tr>
  <tr>
    <td>
      <code class="field">weight</code>
      <div class="type">optional</div>
    </td>
    <td>The weight of the vehicle. Specified as an integer representing kilograms</td>
  </tr>
</table>

# Bid

A bid to provide a route plan. Typically sent by a route planner to a vehicle or a vehicle owner.

## Arguments

> Post request to a local/remote bidding endpoint

```shell
curl "bidding_endpoint_here" \
  --data "{ \
    \"need_id\": \"ae7bd8f67f3089c\", \
    \"expires_at\": \"1513005539000\", \
    \"price\": \"100000000000000000\", \
    \"price_type\": \"flat\", \
    \"price_description\": \"Total price\", \
    \"eta\": \"1513178334000\" \
  }"
```

```javascript
const biddingEndPoint = "bidding_endpoint_here";

fetch(biddingEndPoint, {
  method: "POST",
  body: JSON.stringify({
    "need_id": "ae7bd8f67f3089c",
    "expires_at": "1513005539000",
    "price": "100000000000000000",
    "price_type": "flat",
    "price_description": "Total price",
    "eta": "1513178334000",
  })
});
```

```python
import requests
payload = {
    "need_id": "ae7bd8f67f3089c",
    "expires_at": "1513005539000",
    "price": "100000000000000000",
    "price_type": "flat",
    "price_description": "Total price",
    "eta": "1513178334000",
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
      <code class="field">eta</code>
      <div class="type required">required</div>
    </td>
    <td>The estimated time of when the route plan will be delivered. Specified as time in milliseconds since <a href="https://en.wikipedia.org/wiki/Unix_time" target="blank">Epoch/Unix Time</a></td>
  </tr>
</table>

# Vehicle Types

The type of vehicles and their unique identifier.

<table class="cargo_vehicles">
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
    <td><code>km</code></td>
    <td>The listed <code>price</code> is per km</td>
  </tr>
  <tr>
    <td><code>mile</code></td>
    <td>The listed <code>price</code> is per mile</td>
  </tr>
  <tr>
    <td><code>flat</code></td>
    <td>The listed <code>price</code> is a flat price</td>
  </tr>
</table>
