---
title: Cargo Insurance

language_tabs: # must be one of https://git.io/vQNgJ
  - shell
  - javascript
  - python

toc_footers:
  - Documentation powered by <a href="https://github.com/lord/slate" target="blank">Slate</a>.

search: true
---

<p class="header-image"><img src="/images/cargo_insurance/header.png" alt="Cargo Insurance"></p>

# Cargo Insurance Protocol

The following document describes the communication protocol for a cargo insurance service provided by an insurance provider to a user or a courier. It includes the format for both the request for insurance (also referred to as `need`) and the response sent by insurance providers that `bid` on providing the service.

For example, an autonomous drone that is about to deliver an expensive diamond ring would send a request for an insurance service, along with the estimated value of the ring, and the delivery path.

> Need

```shell
curl "discovery_endpoint_here" \
  --data "start_at=1519093577681" \
  --data "end_at=2017-12-11T16:00:00+03:00" \
  --data "pickup_latitude=40.958123" \
  --data "pickup_longitude=-74.169388" \
  --data "dropoff_latitude=40.875103" \
  --data "dropoff_longitude=-74.570389" \
  --data "planned_path=40.958123,-74.169388,40.7899,-74.463272,40.875103,-74.570389" \
  --data "vehicle_type=drone" \
  --data "cargo_type=11" \
  --data "insured_value=3000.00" \
  --data "insured_value_currency=USD"
```

```javascript
const discoveryEndPoint = "discovery_endpoint_here";

fetch(discoveryEndPoint, {
  method: "POST",
  body: JSON.stringify({
    "start_at": "1519093577681",
    "end_at": "1519093577681",
    "pickup_latitude": "40.958123",
    "pickup_longitude": "-74.169388",
    "dropoff_latitude": "40.875103",
    "dropoff_longitude": "-74.570389",
    "planned_path": "40.958123,-74.169388,40.7899,-74.463272,40.875103,-74.570389",
    "vehicle_type": "drone",
    "cargo_type": "11",
    "insured_value": "3000.00",
    "insured_value_currency": "USD",
  })
});
```

```python
import requests
payload = {
    "start_at": "1519093577681",
    "end_at": "1519093577681",
    "pickup_latitude": "40.958123",
    "pickup_longitude": "-74.169388",
    "dropoff_latitude": "40.875103",
    "dropoff_longitude": "-74.570389",
    "planned_path": "40.958123,-74.169388,40.7899,-74.463272,40.875103,-74.570389",
    "vehicle_type": "drone",
    "cargo_type": "11",
    "insured_value": "3000.00",
    "insured_value_currency": "USD",
  }
requests.post("discovery_endpoint_here", data=payload)
```

In response, an insurance provider might send back a bid with the policy price, the type of coverage, and the deductible amount required.

> Bid

```shell
curl "bidding_endpoint_here" \
  --data "need_id=ae7bd8f67f3089c" \
  --data "expires_at=2017-12-11T15:18:59+03:00" \
  --data "coverage_type=all_risk" \
  --data "price=100000000000000000" \
  --data "price_type=flat" \
  --data "price_description=Policy cost" \
  --data "deductible=1400000000000000000"
```

```javascript
const biddingEndPoint = "bidding_endpoint_here";

fetch(biddingEndPoint, {
  method: "POST",
  body: JSON.stringify({
    "need_id": "ae7bd8f67f3089c",
    "expires_at": "1519093577681",
    "coverage_type": "all_risk",
    "price": "100000000000000000",
    "price_type": "flat",
    "price_description": "Policy cost",
    "deductible": "1400000000000000000",
  })
});
```

```python
import requests
payload = {
    "need_id": "ae7bd8f67f3089c",
    "expires_at": "2017-12-11T15:18:59+03:00",
    "coverage_type": "all_risk",
    "price": "100000000000000000",
    "price_type": "flat",
    "price_description": "Policy cost",
    "deductible": "1400000000000000000",
  }
requests.post("bidding_endpoint_here", data=payload)
```

# Need

A statement of need for a cargo insurance service. Typically this will be sent by a user or a courier that plans to deliver a package from one point to another.

This request is sent to the decentralized discovery engine which responds with status `200` and a unique identifier for this request. The details of this request are then broadcasted to DAV entities that can provide this service. <a href="#bid">Bids</a> are later received as separate calls.

## Arguments

> Post request to a local/remote discovery endpoint

```shell
curl "discovery_endpoint_here" \
  --data "start_at=1519093577681" \
  --data "end_at=2017-12-11T16:00:00+03:00" \
  --data "start_latitude=40.746217" \
  --data "start_longitude=-73.970261" \
  --data "pickup_latitude=40.958123" \
  --data "pickup_longitude=-74.169388" \
  --data "dropoff_latitude=40.875103" \
  --data "dropoff_longitude=-74.570389" \
  --data "end_latitude=40.746217" \
  --data "end_longitude=-73.970261" \
  --data "planned_path=40.958123,-74.169388,40.7899,-74.463272,40.875103,-74.570389" \
  --data "requester_name=Megadronix" \
  --data "requester_phone_number=+31-338-594332" \
  --data "external_reference_id=200982447" \
  --data "vehicle_type=drone,ship,drone" \
  --data "vehicle_is_autonomous=true,false,true" \
  --data "cargo_type=11" \
  --data "hazardous_goods=8" \
  --data "ip_protection_level=68" \
  --data "height=8" \
  --data "width=2" \
  --data "length=2" \
  --data "weight=50" \
  --data "insured_value=3000.00" \
  --data "insured_value_currency=USD"
```

```javascript
const discoveryEndPoint = "discovery_endpoint_here";

fetch(discoveryEndPoint, {
  method: "POST",
  body: JSON.stringify({
    "start_at": "1519093577681",
    "end_at": "1519093577681",
    "start_latitude": "40.746217",
    "start_longitude": "-73.970261",
    "pickup_latitude": "40.958123",
    "pickup_longitude": "-74.169388",
    "dropoff_latitude": "40.875103",
    "dropoff_longitude": "-74.570389",
    "end_latitude": "40.746217",
    "end_longitude": "-73.970261",
    "planned_path": "40.958123,-74.169388,40.7899,-74.463272,40.875103,-74.570389",
    "requester_name": "Megadronix",
    "requester_phone_number": "+31-338-594332",
    "external_reference_id": "200982447",
    "vehicle_type": "drone,ship,drone",
    "vehicle_is_autonomous": "true,false,true",
    "cargo_type": "11",
    "hazardous_goods": "8",
    "ip_protection_level": "68",
    "height": "8",
    "width": "2",
    "length": "2",
    "weight": "50",
    "insured_value": "3000.00",
    "insured_value_currency": "USD",
  })
});
```

```python
import requests
payload = {
    "start_at": "1519093577681",
    "end_at": "1519093577681",
    "start_latitude": "40.746217",
    "start_longitude": "-73.970261",
    "pickup_latitude": "40.958123",
    "pickup_longitude": "-74.169388",
    "dropoff_latitude": "40.875103",
    "dropoff_longitude": "-74.570389",
    "end_latitude": "40.746217",
    "end_longitude": "-73.970261",
    "planned_path": "40.958123,-74.169388,40.7899,-74.463272,40.875103,-74.570389",
    "requester_name": "Megadronix",
    "requester_phone_number": "+31-338-594332",
    "external_reference_id": "200982447",
    "vehicle_type": "drone,ship,drone",
    "vehicle_is_autonomous": "true,false,true",
    "cargo_type": "11",
    "hazardous_goods": "8",
    "ip_protection_level": "68",
    "height": "8",
    "width": "2",
    "length": "2",
    "weight": "50",
    "insured_value": "3000.00",
    "insured_value_currency": "USD",
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
      The time at which the requester would like the insurance to be activated (if undefined, the activation will be immediate). This should be Specified as time in milliseconds since <a href="https://en.wikipedia.org/wiki/Unix_time">Epoch/Unix Time</a>
    </td>
  </tr>
  <tr>
    <td>
      <code class="field">end_at</code>
      <div class="type required">required</div>
    </td>
    <td>
      The time at which the requester would like the insurance to stop. This should be Specified as time in milliseconds since <a href="https://en.wikipedia.org/wiki/Unix_time">Epoch/Unix Time</a>
    </td>
  </tr>
  <tr>
    <td>
      <code class="field">start_latitude</code>
      <div class="type">optional</div>
    </td>
    <td>The latitude coordinate of the take off location, prior to the arrival at the pickup location</td>
  </tr>
  <tr>
    <td>
      <code class="field">start_longitude</code>
      <div class="type">optional</div>
    </td>
    <td>The longitude coordinate of the take off location, prior to the arrival at the pickup location</td>
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
      <code class="field">dropoff_latitude</code>
      <div class="type required">required</div>
    </td>
    <td>The latitude coordinate of the dropoff destination</td>
  </tr>
  <tr>
    <td>
      <code class="field">dropoff_longitude</code>
      <div class="type required">required</div>
    </td>
    <td>The longitude coordinate of the dropoff destination</td>
  </tr>
  <tr>
    <td>
      <code class="field">end_latitude</code>
      <div class="type">optional</div>
    </td>
    <td>The latitude coordinate of the end location, after the departure from the dropoff destination</td>
  </tr>
  <tr>
    <td>
      <code class="field">end_longitude</code>
      <div class="type">optional</div>
    </td>
    <td>The longitude coordinate of the end location, after the departure from the dropoff destination</td>
  </tr>
  <tr>
    <td>
      <code class="field">planned_path</code>
      <div class="type">optional</div>
    </td>
    <td>The planned trip described as a polyline using geodesic geometry. Specified as a comma separated list of coordinates (e.g., "lat,long,lat,long,lat,long")</td>
  </tr>
  <tr>
    <td>
      <code class="field">requester_name</code>
      <div class="type">optional</div>
    </td>
    <td>The name of the person or the company requesting the insurance service</td>
  </tr>
  <tr>
    <td>
      <code class="field">requester_phone_number</code>
      <div class="type">optional</div>
    </td>
    <td>The phone number of the person or the company requesting the insurance service</td>
  </tr>
  <tr>
    <td>
      <code class="field">external_reference_id</code>
      <div class="type">optional</div>
    </td>
    <td>An identification string that might be needed for providing the insurance service</td>
  </tr>
  <tr>
    <td>
      <code class="field">vehicle_type</code>
      <div class="type required">required</div>
    </td>
    <td>The type of vehicle (one or more) used for the trip, specified as a comma separated list. See full list of options <a href="#vehicle-types">here</a>
    </td>
  </tr>
  <tr>
    <td>
      <code class="field">vehicle_is_autonomous</code>
      <div class="type">optional</div>
    </td>
    <td>A boolean or a comma separated list of booleans, stating if the vehicle used for the trip is autonomous (<code>true</code>) or human controlled (<code>false</code>). Default is <code>true</code></a>
    </td>
  </tr>
  <tr>
    <td>
      <code class="field">cargo_type</code>
      <div class="type required">required</div>
    </td>
    <td>The type of cargo to be delivered. See the full list of options <a href="#cargo-types">here</a>
    </td>
  </tr>
  <tr>
    <td>
      <code class="field">hazardous_goods</code>
      <div class="type">optional</div>
    </td>
    <td>If the cargo contains hazardous goods, the hazardous goods class must be included. See the full list of options <a href="#hazardous-goods">here</a></td>
  </tr>
  <tr>
    <td>
      <code class="field">ip_protection_level</code>
      <div class="type">optional</div>
    </td>
    <td>A certain level of protection that may be provided to the cargo (see full list of options <a href="#ip-protection-level">here</a>). This is optional but recommended as it may affect the price of policy</td>
  </tr>
  <tr>
    <td>
      <code class="field">height</code>
      <div class="type">optional</div>
    </td>
    <td>The height of the cargo. Specified as an integer representing centimeters</td>
  </tr>
  <tr>
    <td>
      <code class="field">width</code>
      <div class="type">optional</div>
    </td>
    <td>The width of the cargo. Specified as an integer representing centimeters</td>
  </tr>
  <tr>
    <td>
      <code class="field">length</code>
      <div class="type">optional</div>
    </td>
    <td>The length of the cargo. Specified as an integer representing centimeters</td>
  </tr>
  <tr>
    <td>
      <code class="field">weight</code>
      <div class="type">optional</div>
    </td>
    <td>The weight of the cargo. Specified as an integer representing grams</td>
  </tr>
  <tr>
    <td>
      <code class="field">insured_value</code>
      <div class="type required">required</div>
    </td>
    <td>The declared value of the cargo to be insured. Specified as a float</td>
  </tr>
  <tr>
    <td>
      <code class="field">insured_value_currency</code>
      <div class="type required">required</div>
    </td>
    <td>The currency in which the declared value is denoted. This should be specified as a 3-letter <a href="https://en.wikipedia.org/wiki/ISO_4217" target="blank">ISO 4217</a> code or <code>DAV</code></td>
  </tr>
</table>

# Bid

A bid to provide cargo insurance. Typically sent from an insurance provider to a user or a courier that plans to deliver a package from one point to another.

## Arguments

> Post request to a local/remote endpoint representing the insurance requester

```shell
curl "bidding_endpoint_here" \
  --data "need_id=ae7bd8f67f3089c" \
  --data "expires_at=2017-12-11T15:18:59+03:00" \
  --data "coverage_type=all_risk" \
  --data "price=20000000000000000,100000000000000000" \
  --data "price_type=minute,flat" \
  --data "price_description=Price per minute,City tax" \
  --data "deductible=1400000000000000000" \
  --data "insurer_contact=Airsurance LTD, Tel: +1 415 982 3342" \
  --data "insurer_dav_id=0x17325a469aef3472aa58dfdcf672881d79b31d58"
```

```javascript
const biddingEndPoint = "bidding_endpoint_here";

fetch(biddingEndPoint, {
  method: "POST",
  body: JSON.stringify({
    "need_id": "ae7bd8f67f3089c",
    "expires_at": "1519093577681",
    "coverage_type": "all_risk",
    "price": "20000000000000000,100000000000000000",
    "price_type": "minute,flat",
    "price_description": "Price per minute,City tax",
    "deductible": "1400000000000000000",
    "insurer_contact": "Airsurance LTD, Tel: +1 415 982 3342",
    "insurer_dav_id": "0x17325a469aef3472aa58dfdcf672881d79b31d58",
  })
});
```

```python
import requests
payload = {
    "need_id": "ae7bd8f67f3089c",
    "expires_at": "2017-12-11T15:18:59+03:00",
    "coverage_type": "all_risk",
    "price": "20000000000000000,100000000000000000",
    "price_type": "minute,flat",
    "price_description": "Price per minute,City tax",
    "deductible": "1400000000000000000",
    "insurer_contact": "Airsurance LTD, Tel: +1 415 982 3342",
    "insurer_dav_id": "0x17325a469aef3472aa58dfdcf672881d79b31d58",
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
      <code class="field">coverage_type</code>
      <div class="type required">required</div>
    </td>
    <td>The type of coverage provided in the insurance policy. See full list of options <a href="#insurance-coverage-types">here</td>
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
      <code class="field">deductible</code>
      <div class="type required">required</div>
    </td>
    <td>The amount that must be paid by the policy holder before an insurance provider will pay any expenses. Specified as an integer representing DAV tokens without the decimal point padded to 18 decimals (1 DAV is 1000000000000000000)</td>
  </tr>
  <tr>
    <td>
      <code class="field">insurer_contact</code>
      <div class="type">optional</div>
    </td>
    <td>Human readable information regarding the insurance company (e.g., <code>Airsurance LTD, Tel: +1 415 982 3342</code>)</td>
  </tr>
  <tr>
    <td>
      <code class="field">insurer_dav_id</code>
      <div class="type">optional</div>
    </td>
    <td>If the insurer is a registered DAV member, include their ID here</td>
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
  <tr>
    <td><code>rail</code></td>
  </tr>
</table>

# Cargo Types

The following table describes the different types of cargo according to international delivery standards.

<table class="cargo">
  <tr>
    <th>Class ID</th>
    <th>Type</th>
  </tr>
  <tr>
    <td><code>1</code></td>
    <td>Satchel 500g</td>
  </tr>
  <tr>
    <td><code>2</code></td>
    <td>Satchel 1kg</td>
  </tr>
  <tr>
    <td><code>3</code></td>
    <td>Satchel 3kg</td>
  </tr>
  <tr>
    <td><code>4</code></td>
    <td>Satchel 5kg</td>
  </tr>
  <tr>
    <td><code>5</code></td>
    <td>Unpackaged</td>
  </tr>
  <tr>
    <td><code>6</code></td>
    <td>Other/Misc</td>
  </tr>
  <tr>
    <td><code>7</code></td>
    <td>Envelope</td>
  </tr>
  <tr>
    <td><code>8</code></td>
    <td>Bag</td>
  </tr>
  <tr>
    <td><code>9</code></td>
    <td>Satchel</td>
  </tr>
  <tr>
    <td><code>10</code></td>
    <td>Crate</td>
  </tr>
  <tr>
    <td><code>11</code></td>
    <td>Tube</td>
  </tr>
  <tr>
    <td><code>12</code></td>
    <td>Pallet</td>
  </tr>
  <tr>
    <td><code>13</code></td>
    <td>Skid</td>
  </tr>
  <tr>
    <td><code>14</code></td>
    <td>Heavy Carton</td>
  </tr>
  <tr>
    <td><code>15</code></td>
    <td>Carton containing glass</td>
  </tr>
  <tr>
    <td><code>16</code></td>
    <td>Carton containing liquids</td>
  </tr>
  <tr>
    <td><code>17</code></td>
    <td>wine/beer/liquor carton</td>
  </tr>
  <tr>
    <td><code>18</code></td>
    <td>Carton</td>
  </tr>
</table>

# Hazardous Goods

The following table describes the different types of hazardous goods according to international delivery standards.

<table class="hazardous">
  <tr>
    <th>Class ID</th>
    <th>Type</th>
  </tr>
  <tr>
    <td><code>1</code></td>
    <td>Explosives</td>
  </tr>
  <tr>
    <td><code>2</code></td>
    <td>Gases</td>
  </tr>
  <tr>
    <td><code>3</code></td>
    <td>Flammable and combustible liquids</td>
  </tr>
  <tr>
    <td><code>4</code></td>
    <td>Flammable solids</td>
  </tr>
  <tr>
    <td><code>5</code></td>
    <td>Oxidizing substances, organic peroxides</td>
  </tr>
  <tr>
    <td><code>6</code></td>
    <td>Toxic and infectious substances</td>
  </tr>
  <tr>
    <td><code>7</code></td>
    <td>Radioactive materials</td>
  </tr>
  <tr>
    <td><code>8</code></td>
    <td>Corrosives</td>
  </tr>
  <tr>
    <td><code>9</code></td>
    <td>Misc Hazardous</td>
  </tr>
</table>

# Insurance Coverage Types

The type of coverage provided in the insurance policy to the cargo, according to international cargo insurance standards.

<table class="reference">
  <tr>
    <th>Coverage ID</th>
    <th>Coverage Type</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><code>general</code></td>
    <td>General Average</td>
    <td>Basic coverage, only covering partial losses</td>
  </tr>
  <tr>
    <td><code>fpa</code></td>
    <td>Free From Particular Average</td>
    <td>Limited coverage, only covering losses caused from stranding, sinking, burning, or collision</td>
  </tr>
  <tr>
    <td><code>all_risk</code></td>
    <td>All Risk</td>
    <td>Extensive coverage, including damage or loss due to external factors</td>
  </tr>
</table>

# IP Protection Level

A drone may provide a certain level of protection from solids and/or liquids (mainly water and dust). The following table describes the standard levels of protection according to the International Protection Marking, IEC standard 60529.

The first digit indicates the level of protection that the enclosure provides against access to hazardous parts (e.g., electrical conductors, moving parts) and the ingress of solid foreign objects.

The second digit indicates the level of protection that the enclosure provides against harmful ingress of water.

For a full listing of all available codes, read more about <a href="https://en.wikipedia.org/wiki/IP_Code" target="_blank">International Protection Marking, IEC standard 60529</a>.

<table class="iplevel">
  <tr>
    <th>Rating Code</th>
    <th>IP Rating</th>
    <th>Solid Particle Protection</th>
    <th>Liquid Ingress Protection</th>
  </tr>
  <tr>
    <td><code>54</code></td>
    <td>IP54</td>
    <td>Protected from limited dust ingress</td>
    <td>Protected from water spray from any direction, limited ingress protection</td>
  </tr>
  <tr>
    <td><code>55</code></td>
    <td>IP55</td>
    <td>Protected from limited dust ingress</td>
    <td>Protected from low pressure water jets from any direction, limited ingress protection</td>
  </tr>
  <tr>
    <td><code>56</code></td>
    <td>IP56</td>
    <td>Protected from limited dust ingress</td>
    <td>Protected from high pressure water jets from any direction, limited ingress protection</td>
  </tr>
  <tr>
    <td><code>57</code></td>
    <td>IP57</td>
    <td>Protected from limited dust ingress</td>
    <td>Protected from immersion between 15 centimetres and 1 metre in depth, limited ingress protection</td>
  </tr>
  <tr>
    <td><code>58</code></td>
    <td>IP58</td>
    <td>Protected from limited dust ingress</td>
    <td>Protected from long term immersion up to a specified pressure, limited ingress protection</td>
  </tr>
  <tr>
    <td><code>60</code></td>
    <td>IP60</td>
    <td>Protected from total dust ingress</td>
    <td>Not protected from liquids, limited ingress protection</td>
  </tr>
  <tr>
    <td><code>61</code></td>
    <td>IP61</td>
    <td>Protected from total dust ingress</td>
    <td>Protected from condensation, limited ingress protection</td>
  </tr>
  <tr>
    <td><code>62</code></td>
    <td>IP62</td>
    <td>Protected from total dust ingress</td>
    <td>Protected from water spray less than 15 degrees from vertical, limited ingress protection</td>
  </tr>
  <tr>
    <td><code>63</code></td>
    <td>IP63</td>
    <td>Protected from total dust ingress</td>
    <td>Protected from water spray less than 60 degrees from vertical, limited ingress protection</td>
  </tr>
    <tr>
    <td><code>64</code></td>
    <td>IP64</td>
    <td>Protected from total dust ingress</td>
    <td>Protected from water spray from any direction, limited ingress protection</td>
  </tr>
    <tr>
    <td><code>65</code></td>
    <td>IP65</td>
    <td>Protected from total dust ingress</td>
    <td>Protected from low pressure water jets from any direction, limited ingress protection</td>
  </tr>
    <tr>
    <td><code>66</code></td>
    <td>IP66</td>
    <td>Protected from total dust ingress</td>
    <td>Protected from high pressure water jets from any direction, limited ingress protection</td>
  </tr>
    <tr>
    <td><code>67</code></td>
    <td>IP67</td>
    <td>Protected from total dust ingress</td>
    <td>Protected from immersion between 15 centimetres and 1 metre in depth, limited ingress protection</td>
  </tr>
    <tr>
    <td><code>68</code></td>
    <td>IP68</td>
    <td>Protected from total dust ingress</td>
    <td>Protected from long term immersion up to a specified pressure, limited ingress protection</td>
  </tr>
    <tr>
    <td><code>69k</code></td>
    <td>IP69K</td>
    <td>Protected from total dust ingress</td>
    <td>Protected from steam-jet cleaning, limited ingress protection</td>
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
