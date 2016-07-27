# PsPabxListener
A command line utility which connects to a Panasonic PABX via *telnet* and retrieve calling information. It doesn't parse the responses to any popular format. Instead, it just filters valuable content while keeping the original fixed-space format. Parsing to formats such as *csv*, as well as further instructions regarding Panasonic's default format, shall be included in the future. And a list of working devices, off course.

## Tested Devices:
* Panasonic KX-TDA 200.

## Environment:
* Ubuntu Linux (trusty or newer);
* Ruby 2.2.0.

It's possible that the utility works on different environments, but since I haven't tested it on such conditions, I can't promise anything. If you do, please let me know, and I will include both the information and your name as a contributor.

## Install
Simply,

      gem install ps_pabx_listener

## Using the command line utility

* Listem for useful information for 30 seconds:

      ps_pabx -s <pabx ip address or hostname> -u <username> -p <password>

* Listem for useful information for 10 seconds:

      ps_pabx -s <pabx ip address or hostname> -u <username> -p <password> -t 10

* Listem continuously for data and store it in a given directory:

      ps_pabx -s <pabx ip address or hostname> -u <username> -p <password> -d <store directory>

## Using as a daemon

You may prefer to use <code>ps_pabx_ctrl</code> and run ps_pabx as a daemon. In order to do that, make sure the following environment variables are defined and visible:

* **PS_PABX_HOST**: the PABX ip address or hostname;
* **PS_PABX_USER**: the PABX *telnet* username;
* **PS_PABX_PASS**: the PABX *telnet* password;
* **PS_PABX_DATA**: the directory where useful information, such as logging and collected data, will be stored.

Once it's done, you use the daemon with common service commands such as:

      ps_pabx_ctrl start
      ps_pabx_ctrl status
      ps_pabx_ctrl restart
      ps_pabx_ctrl stop

And so on.

## What else?
Developed by Lucas Vieira <lucas@vieira.io>, June 2016.

If you noticed a problem whatsoever, please, let me know.

Also, accepting PRs for better spec tests and anything else, really.
