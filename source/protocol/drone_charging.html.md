---
title: Drone Charging

language_tabs: # must be one of https://git.io/vQNgJ
  - shell
  - javascript
  - python

toc_footers:
  - Documentation powered by <a href="https://github.com/lord/slate" target="blank">Slate</a>.

search: true
---

<p class="header-image"><img src="/images/drone_charging/header.png" alt="Drone Charging"></p>

# Drone Charging Protocol

The following document describes the communication protocol for drone charging. It includes the format for both the request for a charging service sent by the drone (also referred to as `need`) and the response sent by a charging provider (`bid`).

For example, a drone may look for a charging station that supports 2mm bullet connectors within 2 km of its current location.

> Need

```shell
curl "discovery_endpoint_here" \
  --data "start_at=1519093577681" \
  --data "latitude=32.787793" \
  --data "longitude=-79.935005" \
  --data "radius=2000" \
  --data "plug_type=bullet_2mm"
```

```javascript
const discoveryEndPoint = "discovery_endpoint_here";

fetch(discoveryEndPoint, {
  method: "POST",
  body: JSON.stringify({
    "start_at": "2017-12-11T15:18:54+03:00",
    "latitude": "32.787793",
    "longitude": "-79.935005",
    "radius": "2000",
    "plug_type": "bullet_2mm",
  })
});
```

```python
import requests
payload = {
    "start_at": "1519093577681",
    "latitude": "32.787793",
    "longitude": "-79.935005",
    "radius": "2000",
    "plug_type": "bullet_2mm",
  }
requests.post("discovery_endpoint_here", data=payload)
```

In response, a charging station might send back a bid with a price per kWh.

> Bid

```shell
curl "bidding_endpoint_here" \
  --data "need_id=ae7bd8f67f3089c" \
  --data "expires_at=2017-12-11T15:18:59+03:00" \
  --data "price=2300000000000000000,30000000000000000" \
  --data "price_type=kwh,kwh" \
  --data "price_description=Price per kWh,VAT per kWh" \
  --data "latitude=32.785889" \
  --data "longitude=-79.935569" \
  --data "available_from=1519093577681" \
  --data "available_until=2017-12-12T15:18:54+03:00"
```

```javascript
const biddingEndPoint = "bidding_endpoint_here";

fetch(biddingEndPoint, {
  method: "POST",
  body: JSON.stringify({
    "need_id": "ae7bd8f67f3089c",
    "expires_at": "1519093577681",
    "price": "2300000000000000000,30000000000000000",
    "price_type": "kwh,kwh",
    "price_description": "Price per kWh,VAT per kWh",
    "latitude": "32.785889",
    "longitude": "-79.935569",
    "available_from": "1519093577681",
    "available_until": "2017-12-12T15:18:54+03:00",
  })
});
```

```python
import requests
payload = {
    "need_id": "ae7bd8f67f3089c",
    "expires_at": "1519093577681",
    "price": "2300000000000000000,30000000000000000",
    "price_type": "kwh,kwh",
    "price_description": "Price per kWh,VAT per kWh",
    "latitude": "32.785889",
    "longitude": "-79.935569",
    "available_from": "1519093577681",
    "available_until": "1519093577681",
  }
requests.post("bidding_endpoint_here", data=payload)
```

# Need

A statement of need for drone charging services. Typically this will be sent by a drone that is looking for a charging station around certain coordinates.

This request is sent to the decentralized discovery engine which responds with status `200` and a unique identifier for this request. The details of this request are then broadcasted to DAV entities that can provide this service. <a href="#bid">Bids</a> are later received as separate calls.

## Arguments

> Post request to a local/remote discovery endpoint

```shell
curl "discovery_endpoint_here" \
  --data "start_at=2017-12-11T15:18:54+03:00" \
  --data "latitude=32.787793" \
  --data "longitude=-79.935005" \
  --data "radius=10000" \
  --data "drone_type=DXY M6000" \
  --data "battery_capacity=4500" \
  --data "charge_level=23" \
  --data "plug_type=bullet_4mm" \
  --data "height=50" \
  --data "width=30" \
  --data "length=30" \
  --data "weight=2500" \
  --data "charge_pad_type=enclosed" \
  --data "droneport_protection_level=56" \
  --data "energy_source=solar"
```

```javascript
const discoveryEndPoint = "discovery_endpoint_here";

fetch(discoveryEndPoint, {
  method: "POST",
  body: JSON.stringify({
    "start_at": "1519093577681",
    "latitude": "32.787793",
    "longitude": "-79.935005",
    "radius": "10000",
    "drone_type": "DXY M6000",
    "battery_capacity": "4500",
    "charge_level": "23",
    "plug_type": "bullet_4mm",
    "height": "50",
    "width": "30",
    "length": "30",
    "weight": "2500",
    "charge_pad_type": "enclosed",
    "droneport_protection_level": "56"
    "energy_source": "solar",
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
    "drone_type": "DXY M6000",
    "battery_capacity": "4500",
    "charge_level": "23",
    "plug_type": "bullet_4mm",
    "height": "50",
    "width": "30",
    "length": "30",
    "weight": "2500",
    "charge_pad_type": "enclosed",
    "droneport_protection_level": "56"
    "energy_source": "solar",
  }
requests.post("discovery_endpoint_here", data=payload)
```

<table class="arguments">
  <tr>
    <td>
      <code class="field">start_at</code>
      <div class="type">optional</div>
    </td>
    <td>The time at which the requester would like to arrive at charging station (if undefined, the arrival time will be ASAP). Specified as time in milliseconds since <a href="https://en.wikipedia.org/wiki/Unix_time">Epoch/Unix Time</a></td>
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
      <code class="field">drone_type</code>
      <div class="type">optional</div>
    </td>
    <td>The manufacturer and/or the model number of the drone. An unformatted string</td>
  </tr>
    <tr>
    <td>
      <code class="field">battery_capacity</code>
      <div class="type">optional</div>
    </td>
    <td>The capacity of the drone's battery, specified in mAh</td>
  </tr>
      <tr>
    <td>
      <code class="field">charge_level</code>
      <div class="type">optional</div>
    </td>
    <td>The drone's current battery charge level, as it was by the time the request was sent. Specified in %</td>
  </tr>
  <tr>
    <td>
      <code class="field">plug_type</code>
      <div class="type required">required</div>
    </td>
    <td>The drone's plug type ID. See <a href="#plug-types">Plug Types</a> for possible values</td>
  </tr>
  <tr>
    <td>
      <code class="field">height</code>
      <div class="type">optional</div>
    </td>
    <td>The height of the drone and the minimum height clearance that it requires from the charging station. Specified as an integer representing centimeters</td>
  </tr>
  <tr>
    <td>
      <code class="field">width</code>
      <div class="type">optional</div>
    </td>
    <td>The width of the drone and the minimum width clearance that it requires from the charging station. Specified as an integer representing centimeters</td>
  </tr>
  <tr>
    <td>
      <code class="field">length</code>
      <div class="type">optional</div>
    </td>
    <td>The length of the drone and the minimum width clearance that it requires from the charging station. Specified as an integer representing centimeters</td>
  </tr>
  <tr>
    <td>
      <code class="field">weight</code>
      <div class="type">optional</div>
    </td>
    <td>The weight of the drone. Charging stations that cannot support a drone weighing this much should not respond. Specified as an integer representing grams</td>
  </tr>
  <tr>
    <td>
      <code class="field">charge_pad_type</code>
      <div class="type">optional</div>
    </td>
    <td>The type of charging pad. Accepted values can be either <code>open</code> (for an outdoor pad) or <code>enclosed</code> (for an enclosed charging pad)</td>
  </tr>
  <tr>
    <td>
      <code class="field">droneport_protection_level</code>
      <div class="type">optional</div>
    </td>
    <td>Charging stations may also provide protection services for drones. This parameter specifies the level of protection given to a drone. See possible codes under <a href="#drone-protection-level">Drone Protection Level</a></td>
  </tr>
  <tr>
    <td>
      <code class="field">energy_source</code>
      <div class="type">optional</div>
    </td>
    <td>Limit the request to only receive bids from charging stations using a specific source of the energy. Specified as an energy source id. See <a href="#energy-sources">Energy Sources</a></td>
  </tr>
</table>

# Bid

A bid to provide a charging service. Typically sent from a charging station to a drone.

## Arguments

> Post request to a local/remote endpoint representing the drone

```shell
curl "bidding_endpoint_here" \
  --data "need_id=ae7bd8f67f3089c" \
  --data "expires_at=1519093577681" \
  --data "price=2300000000000000000,30000000000000000" \
  --data "price_type=kwh,kwh" \
  --data "price_description=Price per kWh,VAT per kWh" \
  --data "latitude=32.785889" \
  --data "longitude=-79.935569" \
  --data "available_from=1519093577681" \
  --data "available_until=2017-12-12T15:18:54+03:00" \
  --data "location_name=IKEA parking lot B" \
  --data "location_name_lang=eng" \
  --data "location_house_number=372" \
  --data "location_street=King" \
  --data "location_city=Charleston" \
  --data "location_postal_code=29401" \
  --data "location_county=Charleston" \
  --data "location_state=SC" \
  --data "location_country=USA" \
  --data "height=5000" \
  --data "width=1000" \
  --data "length=1000" \
  --data "weight=100000" \
  --data "plug_types=bullet_2mm,bullet_3_5mm,bullet_4mm" \
  --data "energy_source=solar" \
  --data "provider=City Charge" \
  --data "manufacturer=GeoCharge" \
  --data "model=gc2910"
```

```javascript
const biddingEndPoint = "bidding_endpoint_here";

fetch(biddingEndPoint, {
  method: "POST",
  body: JSON.stringify({
    "need_id": "ae7bd8f67f3089c",
    "expires_at": "1519093577681",
    "price": "2300000000000000000,30000000000000000",
    "price_type": "kwh,kwh",
    "price_description": "Price per kWh,VAT per kWh",
    "latitude": "32.785889",
    "longitude": "-79.935569",
    "available_from": "1519093577681",
    "available_until": "1519093577681",
    "location_name": "IKEA parking lot B",
    "location_name_lang": "eng",
    "location_house_number": "372",
    "location_street": "King",
    "location_city": "Charleston",
    "location_postal_code": "29401",
    "location_county": "Charleston",
    "location_state": "SC",
    "location_country": "USA",
    "height": "5000",
    "width": "1000",
    "length": "1000",
    "weight": "100000",
    "plug_types": "bullet_2mm,bullet_3_5mm,bullet_4mm",
    "energy_source": "solar",
    "provider": "City Charge",
    "manufacturer": "GeoCharge",
    "model": "gc2910",
  })
});
```

```python
import requests
payload = {
    "need_id": "ae7bd8f67f3089c",
    "expires_at": "2017-12-11T15:18:59+03:00",
    "price": "2300000000000000000,30000000000000000",
    "price_type": "kwh,kwh",
    "price_description": "Price per kWh,VAT per kWh",
    "latitude": "32.785889",
    "longitude": "-79.935569",
    "available_from": "1519093577681",
    "available_until": "1519093577681",
    "location_name": "IKEA parking lot B",
    "location_name_lang": "eng",
    "location_house_number": "372",
    "location_street": "King",
    "location_city": "Charleston",
    "location_postal_code": "29401",
    "location_county": "Charleston",
    "location_state": "SC",
    "location_country": "USA",
    "height": "5000",
    "width": "1000",
    "length": "1000",
    "weight": "100000",
    "plug_types": "bullet_2mm,bullet_3_5mm,bullet_4mm",
    "energy_source": "solar",
    "provider": "City Charge",
    "manufacturer": "GeoCharge",
    "model": "gc2910",
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
    <td>The latitude coordinate of the charging station</td>
  </tr>
  <tr>
    <td>
      <code class="field">longitude</code>
      <div class="type required">required</div>
    </td>
    <td>The longitude coordinate of the charging station</td>
  </tr>
  <tr>
    <td>
      <code class="field">available_from</code>
      <div class="type required">required</div>
    </td>
    <td>The time from which the charging station can be made available. Specified as time in milliseconds since <a href="https://en.wikipedia.org/wiki/Unix_time">Epoch/Unix Time</a></td>
  </tr>
  <tr>
    <td>
      <code class="field">available_until</code>
      <div class="type">optional</div>
    </td>
    <td>The time until which the charging station can be made available. Specified as time in milliseconds since <a href="https://en.wikipedia.org/wiki/Unix_time">Epoch/Unix Time</a></td>
  </tr>
  <tr>
    <td>
      <code class="field">location_name</code>
      <div class="type">optional</div>
    </td>
    <td>A human readable name/description of the charging station location (e.g., Lund Train Station parking)</td>
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
    <td>The county where the station is located</td>
  </tr>
  <tr>
    <td>
      <code class="field">location_state</code>
      <div class="type">optional</div>
    </td>
    <td>The state where the station is located</td>
  </tr>
  <tr>
    <td>
      <code class="field">location_country</code>
      <div class="type">optional</div>
    </td>
    <td>The country where the station is located</td>
  </tr>
  <tr>
    <td>
      <code class="field">height</code>
      <div class="type">optional</div>
    </td>
    <td>The maximum drone height this station can accommodate. Specified as an integer representing centimeters</td>
  </tr>
  <tr>
    <td>
      <code class="field">width</code>
      <div class="type">optional</div>
    </td>
    <td>The maximum drone width this station can accommodate. Specified as an integer representing centimeters</td>
  </tr>
  <tr>
    <td>
      <code class="field">length</code>
      <div class="type">optional</div>
    </td>
    <td>The maximum drone length this station can accommodate. Specified as an integer representing centimeters</td>
  </tr>
  <tr>
    <td>
      <code class="field">weight</code>
      <div class="type">optional</div>
    </td>
    <td>The maximum drone weight this station can accommodate. Specified as an integer representing grams</td>
  </tr>
  <tr>
    <td>
      <code class="field">plug_types</code>
      <div class="type">required</div>
    </td>
    <td>A list of plug types available at this charging station. Specified as a comma separated list of plug type ids. See <a href="#plug-types">Plug Types</a> for available values</td>
  </tr>
  <tr>
    <td>
      <code class="field">energy_source</code>
      <div class="type">optional</div>
    </td>
    <td>The source of the energy used by this charging station. Specified as an energy source id. See <a href="#energy-sources">Energy Sources</a></td>
  </tr>
  <tr>
    <td>
      <code class="field">provider</code>
      <div class="type">optional</div>
    </td>
    <td>Name of the service provider or charging network operating this charging station</td>
  </tr>
  <tr>
    <td>
      <code class="field">manufacturer</code>
      <div class="type">optional</div>
    </td>
    <td>Name of the manufacturer of this charging station</td>
  </tr>
  <tr>
    <td>
      <code class="field">model</code>
      <div class="type">optional</div>
    </td>
    <td>Name of the model of this charging station</td>
  </tr>
</table>

# Plug Types

Below is a list of all the supported drone plug types.

<table class="reference connectors">
  <tr>
    <th>Plug Type ID</th>
    <th>Name</th>
    <th>Amp Tolerance to Plug Type</th>
  </tr>
  <tr>
    <td><code>jst_739</code></td>
    <td>JST Connector 739</td>
    <td>Up to 5 Amps</td>
  </tr>
  <tr>
    <td><code>bullet_2mm</code></td>
    <td>2mm bullet connectors</td>
    <td>Up to 20 Amps</td>
  </tr>
  <tr>
    <td><code>bullet_3_5mm</code></td>
    <td>3.5mm bullet connectors</td>
    <td>Up to 40 Amps</td>
  </tr>
  <tr>
    <td><code>xt_60_420</code></td>
    <td>XT60 connectors 420</td>
    <td>Up to 60 Amps</td>
  </tr>
  <tr>
    <td><code>t_plug_204</code></td>
    <td>T-Plug 204</td>
    <td>Up to 60 Amps</td>
  </tr>
  <tr>
    <td><code>ec3_306</code></td>
    <td>EC3 connector 306</td>
    <td>Up to 60 Amps</td>
  </tr>
  <tr>
    <td><code>bullet_4mm</code></td>
    <td>4mm bullet connectors</td>
    <td>Up to 70 Amps</td>
  </tr>
  <tr>
    <td><code>ec5_678</code></td>
    <td>EC5 connectors 678</td>
    <td>Up to 120 Amps</td>
  </tr>
  <tr>
    <td><code>bullet_6mm</code></td>
    <td>6mm bullet connectors</td>
    <td>Up to 120 Amps</td>
  </tr>
  <tr>
    <td><code>bullet_8mm</code></td>
    <td>8mm bullet connectors</td>
    <td>Up to 200 Amps</td>
  </tr>
</table>

# Energy Sources

The energy source used by the charging station.

<table class="energy_sources">
  <tr>
    <th>Source</th>
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
    <td>Uses 100% hydropower energy</td>
  </tr>
  <tr>
    <td><code>geothermal</code></td>
    <td>Uses 100% geothermal energy</td>
  </tr>
</table>

# Drone Protection Level

A charging station may also provide a certain level of protection from solids and/or liquids (mainly water and dust). The following table describes the standard levels of protection according to the International Protection Marking, IEC standard 60529.

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
    <td><code>kwh</code></td>
    <td>The listed <code>price</code> is per kWh</td>
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