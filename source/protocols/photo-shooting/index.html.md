---
title: Photo Shooting

language_tabs: # must be one of https://git.io/vQNgJ
  - shell
  - javascript
  - python

toc_footers:
  - Documentation powered by <a href="https://github.com/lord/slate" target="blank">Slate</a>.

search: true
---

<p class="header-image"><img src="/images/photo_shooting/header.png" alt="Photo Shooting"></p>

# Photo Shooting Protocol

The communication protocol for photo shooting describes the format of a request for a photo shoot (also referred to as `need`) sent by a user, and the response (`bid`) sent by the photographer (can be a human controlled device or an autonomous one).

For example, an insurance company that wants to estimate the damage caused to a building's windows by a hail storm, might search for photo-shooting drones that can take HD photos at 80 meters high.

> Need

```shell
curl "discovery_endpoint_here" \
  --data "{ \
    \"start_at\": \"1513005534000\", \
    \"end_at\": \"1513008000000\", \
    \"object_latitude\": \"32.787793\", \
    \"object_longitude\": \"-79.935005\", \
    \"object_altitude\": \"80\", \
    \"azimuth_angle\": \"15\", \
    \"elevation_angle\": \"-20\", \
    \"distance\": \"30\", \
    \"min_resolution\": \"1366,768\" \
  }"
```

```javascript
const discoveryEndPoint = 'discovery_endpoint_here';

fetch(discoveryEndPoint, {
  method: 'POST',
  body: JSON.stringify({
    start_at: '1513005534000',
    end_at: '1513008000000',
    object_latitude: '32.787793',
    object_longitude: '-79.935005',
    object_altitude: '80',
    azimuth_angle: '15',
    elevation_angle: '-20',
    distance: '30',
    min_resolution: '1366,768',
  }),
});
```

```python
import requests
payload = {
    "start_at": "1513005534000",
    "end_at": "1513008000000",
    "object_latitude": "32.787793",
    "object_longitude": "-79.935005",
    "object_altitude": "80",
    "azimuth_angle": "15",
    "elevation_angle": "-20",
    "distance": "30",
    "min_resolution": "1366,768",
  }
requests.post("discovery_endpoint_here", data=payload)
```

In response, a drone owner might send back a bid with the drone type and model, the camera model, and the price for this task.

> Bid

```shell
curl "bidding_endpoint_here" \
  --data "{ \
    \"need_id\": \"ae7bd8f67f3089c\", \
    \"expires_at\": \"1513005539000\", \
    \"price\": \"20000000000000000,4000000000000000\", \
    \"price_type\": \"flat,flat\", \
    \"price_description\": \"Total price,VAT\", \
    \"eta\": \"1513005534000\", \
    \"camera_model\": \"ZENMUSE X5S\", \
    \"photo_resolution\": \"2720,1530\", \
    \"camera_operator\": \"controlled_drone\", \
    \"operator_model\": \"DJI Matrice 210\" \
  }"
```

```javascript
const biddingEndPoint = 'bidding_endpoint_here';

fetch(biddingEndPoint, {
  method: 'POST',
  body: JSON.stringify({
    need_id: 'ae7bd8f67f3089c',
    expires_at: '1513005539000',
    price: '20000000000000000,4000000000000000',
    price_type: 'flat,flat',
    price_description: 'Total price,VAT',
    eta: '1513005534000',
    camera_model: 'ZENMUSE X5S',
    photo_resolution: '2720,1530',
    camera_operator: 'controlled_drone',
    operator_model: 'DJI Matrice 210',
  }),
});
```

```python
import requests
payload = {
    "need_id": "ae7bd8f67f3089c",
    "expires_at": "1513005539000",
    "price": "20000000000000000,4000000000000000",
    "price_type": "flat,flat",
    "price_description": "Total price,VAT",
    "eta": "1513005534000",
    "camera_model": "ZENMUSE X5S",
    "photo_resolution": "2720,1530",
    "camera_operator": "controlled_drone",
    "operator_model": "DJI Matrice 210",
  }
requests.post("bidding_endpoint_here", data=payload)
```

# Need

A statement of need for a photo shoot. Typically this will be sent by a user that is looking to photograph a certain object.

This request is sent to the decentralized discovery engine which responds with status `200` and a unique identifier for this request. The details of this request are then broadcasted to DAV entities that can provide this service. <a href="#bid">Bids</a> are later received as separate calls.

## Arguments

> Post request to a local/remote discovery endpoint

```shell
curl "discovery_endpoint_here" \
  --data "{ \
    \"start_at\": \"1513005534000\", \
    \"end_at\": \"1513008000000\", \
    \"object_latitude\": \"32.787793\", \
    \"object_longitude\": \"-79.935005\", \
    \"object_altitude\": \"80\", \
    \"azimuth_angle\": \"15\", \
    \"elevation_angle\": \"-20\", \
    \"distance\": \"30\", \
    \"min_resolution\": \"1366,768\" \
  }"
```

```javascript
const discoveryEndPoint = 'discovery_endpoint_here';

fetch(discoveryEndPoint, {
  method: 'POST',
  body: JSON.stringify({
    start_at: '1513005534000',
    end_at: '1513008000000',
    object_latitude: '32.787793',
    object_longitude: '-79.935005',
    object_altitude: '80',
    azimuth_angle: '15',
    elevation_angle: '-20',
    distance: '30',
    min_resolution: '1366,768',
  }),
});
```

```python
import requests
payload = {
    "start_at": "1513005534000",
    "end_at": "1513008000000",
    "object_latitude": "32.787793",
    "object_longitude": "-79.935005",
    "object_altitude": "80",
    "azimuth_angle": "15",
    "elevation_angle": "-20",
    "distance": "30",
    "min_resolution": "1366,768",
  }
requests.post("discovery_endpoint_here", data=payload)
```

<table class="arguments">
  <tr>
    <td>
      <code class="field">start_at</code>
      <div class="type">optional</div>
    </td>
    <td>The earliest time at which the photo shoot can start (if undefined, photo shoot can start immediately). Specified as time in seconds since <a href="https://en.wikipedia.org/wiki/Unix_time" target="blank">Epoch/Unix Time</a></td>
  </tr>
  <tr>
    <td>
      <code class="field">end_at</code>
      <div class="type required">required</div>
    </td>
    <td>The latest time at which the photo shoot should end. Specified as time in seconds since <a href="https://en.wikipedia.org/wiki/Unix_time" target="blank">Epoch/Unix Time</a></td>
  </tr>
  <tr>
    <td>
      <code class="field">object_latitude</code>
      <div class="type required">required</div>
    </td>
    <td>The latitude coordinate of the object that needs to be photographed</td>
  </tr>
  <tr>
    <td>
      <code class="field">object_longitude</code>
      <div class="type required">required</div>
    </td>
    <td>The longitude coordinate of the object that needs to be photographed</td>
  </tr>
  <tr>
    <td>
      <code class="field">object_altitude</code>
      <div class="type required">required</div>
    </td>
    <td>The altitude of the object that needs to be photographed. Specified as meters above sea level. For example, if the object is located 50 meters above sea level, the <code>object_altitude</code> will be <code>50</code></td>
  </tr>
  <tr>
    <td>
      <code class="field">azimuth_angle</code>
      <div class="type required">required</div>
    </td>
    <td>The horizontal angle of the camera pointing at the object. Specified as an integer representing degrees. For example, if the camera should be directly south of the photographed object, the <code>azimuth_angle</code> will be <code>0</code></td>
  </tr>
  <tr>
    <td>
      <code class="field">elevation_angle</code>
      <div class="type required">required</div>
    </td>
    <td>The vertical angle of the camera pointing at the object. Specified as an integer representing degrees, positive above the horizon, and negative below the horizon. For example, to photograph a rooftop from above, the <code>elevation_angle</code> might be <code>-90</code></td>
  </tr>
  <tr>
    <td>
      <code class="field">distance</code>
      <div class="type required">required</div>
    </td>
    <td>The distance of the camera from the photographed object. Specified as an integer representing meters</td>
  </tr>
  <tr>
    <td>
      <code class="field">min_resolution</code>
      <div class="type required">optional</div>
    </td>
    <td>The minimum required dimensions for the photos. Specified as integers representing pixels, in a comma separated list of two integers (e.g., <code>1366,768</code> for HD photos)</td>
  </tr>
</table>

# Bid

A bid to provide a photo shoot service. Typically sent by a camera owner such as a human photographer or a drone with an integrated camera. The bid arrives with the price for the service, the type of camera, the operator (e.g., human, autonomous drone), and the estimated time of arrival.

## Arguments

> Post request to a local/remote bidding endpoint

```shell
curl "bidding_endpoint_here" \
  --data "{ \
    \"need_id\": \"ae7bd8f67f3089c\", \
    \"expires_at\": \"1513005539000\", \
    \"price\": \"20000000000000000,4000000000000000\", \
    \"price_type\": \"flat,flat\", \
    \"price_description\": \"Total price,VAT\", \
    \"eta\": \"1513005534000\", \
    \"camera_model\": \"ZENMUSE X5S\", \
    \"photo_resolution\": \"2720,1530\", \
    \"camera_operator\": \"controlled_drone\", \
    \"operator_model\": \"DJI Matrice 210\" \
  }"
```

```javascript
const biddingEndPoint = 'bidding_endpoint_here';

fetch(biddingEndPoint, {
  method: 'POST',
  body: JSON.stringify({
    need_id: 'ae7bd8f67f3089c',
    expires_at: '1513005539000',
    price: '20000000000000000,4000000000000000',
    price_type: 'flat,flat',
    price_description: 'Total price,VAT',
    eta: '1513005534000',
    camera_model: 'ZENMUSE X5S',
    photo_resolution: '2720,1530',
    camera_operator: 'controlled_drone',
    operator_model: 'DJI Matrice 210',
  }),
});
```

```python
import requests
payload = {
    "need_id": "ae7bd8f67f3089c",
    "expires_at": "1513005539000",
    "price": "20000000000000000,4000000000000000",
    "price_type": "flat,flat",
    "price_description": "Total price,VAT",
    "eta": "1513005534000",
    "camera_model": "ZENMUSE X5S",
    "photo_resolution": "2720,1530",
    "camera_operator": "controlled_drone",
    "operator_model": "DJI Matrice 210",
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
    <td>This bid will expire at this time. Specified as time in seconds since <a href="https://en.wikipedia.org/wiki/Unix_time" target="blank">Epoch/Unix Time</a></td>
  </tr>
  <tr>
    <td>
      <code class="field">price</code>
      <div class="type required">required</div>
    </td>
    <td>A comma separated list of prices. Each price is specified as an integer representing Vinci
    <br>1 DAV == 1e18 Vinci == 1000000000000000000 Vinci</td>
  </tr>
    <tr>
    <td>
      <code class="field">price_type</code>
      <div class="type required">required</div>
    </td>
    <td>A list of price types describing the <code>price</code> parameter(s). Specified as a comma separated list. Currently the only supported price type is <code>flat</code></td>
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
    <td>The estimated time of arrival at the photo shoot location. Specified as time in seconds since <a href="https://en.wikipedia.org/wiki/Unix_time" target="blank">Epoch/Unix Time</a></td>
  </tr>
  <tr>
    <td>
      <code class="field">camera_model</code>
      <div class="type required">required</div>
    </td>
    <td>A human readable name/description of the camera used for the photo shooting (e.g., <code>DJI ZENMUSE X5S</code>)</td>
  </tr>
  <tr>
    <td>
      <code class="field">photo_resolution</code>
      <div class="type required">required</div>
    </td>
    <td>The dimensions of the photos that will be taken. Specified as integers representing pixels, in a comma separated list of two integers (e.g., <code>1366,768</code> for HD photos)</td>
  </tr>
  <tr>
    <td>
      <code class="field">camera_operator</code>
      <div class="type required">required</div>
    </td>
    <td>The operator of the camera during the photo shoot (e.g., <code>human</code>, <code>drone</code>) See full list of options <a href="#camera-operators">here</a></td>
  </tr>
  <tr>
  <tr>
    <td>
      <code class="field">operator_model</code>
      <div class="type">optional</div>
    </td>
    <td>A human readable name/description of the vehicle that may be used to carry the camera and perform the photo shoot (e.g., <code>DJI Matrice 210</code>)</td>
  </tr>
</table>

# Camera Operator

The operator of the camera during the photo shoot.

<table class="lost_vehicles">
  <tr>
    <th>Camera Operator</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><code>handheld</code></td>
    <td>Good ol' human photographer</td>
  </tr>
  <tr>
    <td><code>uav</code></td>
    <td>Unmanned aerial vehicle, commonly known as a drone. An aircraft without a human pilot aboard</td>
  </tr>
  <tr>
    <td><code>usv</code></td>
    <td>Unmanned surface vehicle. A vehicle that operates on the surface of the water (watercraft) without a crew
    </td>
  </tr>
  <tr>
    <td><code>uuv</code></td>
    <td>Unmanned underwater vehicle, sometimes known as underwater drones. Any vehicles that are able to operate underwater without a human occupant
    </td>
  </tr>
  <tr>
    <td><code>ugv</code></td>
    <td>Unmanned ground vehicle. A vehicle that operates while in contact with the ground and without an on board human presence
    </td>
  </tr>
</table>
