---
title: DAV CLI User Guide

toc_footers:
  - Documentation powered by <a href="https://github.com/lord/slate" target="blank">Slate</a>.

search: true
---

<p class="header-image"><img src="/images/dav_cli/header.png" alt="DAV CLI User Guide"></p>

#  DAV CLI User Guide

This is the user guide for the DAV Command Line Interface (CLI).

DAV CLI is written in and installed using Node.js but is useful not just for Node.js or JavaScript development.

# Installation

Before you get started, make sure you have Node version 8 and up and npm or Yarn installed.


<ul>
	<li>To install DAV CLI using <b>npm</b>, run the following command:
		<p><code class="code-block">$ npm install -g dav-cli</code></p>
	</li>
	<li>To install DAV CLI using <b>Yarn</b>, run the following command:
		<p><code class="code-block">$ yarn global add dav-cli</code></p>
	</li>
</ul>

# Usage

The following table describes the various options that are available using the DAV CLI (You can also view them by running the command <code>dav-cli</code>):

<table class="cli_options">
  <tr>
    <th>Command</th>
    <th>Description</th>
  </tr>
  <tr>
    <td><code>-V</code> or <code>--version</code></td>
    <td>Output the version number</td>
  </tr>
  <tr>
    <td><code>-s</code> or <code>--version</code></td>
    <td>Start a local Ethereum node</td>
  </tr>
  <tr>
    <td><code>-p</code> or <code>--port &lt;n&gt;</code></td>
    <td>Port for Ethereum node to listen to</td>
  </tr>
  <tr>
    <td><code>--genkey &lt;s&gt;</code></td>
    <td>Generate a private-public key pair for a new Identity</td>
  </tr>
  <tr>
    <td><code>-r</code> or <code>--register &lt;s&gt;</code></td>
    <td>Register a new Identity on the blockchain</td>
  </tr>
  <tr>
    <td><code>-h</code> or <code>--help</code></td>
    <td>Output usage information</td>
  </tr>
  
</table>

### Examples

To start a local Ethereum node on the default port:
<p><code class="code-block">$ dav-cli --start</code></p>

Start a local Ethereum node on port 1234:
<p><code class="code-block">$ dav-cli --start --port 1234</code></p>

Generate a new private-public key pair and save it to the ~/.dav directory:
<p><code class="code-block">$ dav-cli --genkey ~/.dav</code></p>

Register a new Identity on the blockchain:
<p><code class="code-block">$ dav-cli --register ~/.dav/0xd14e3aca4d62c8e7b150fc63dabb8fb4b3485263</code></p>
