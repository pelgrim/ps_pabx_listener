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

* Listen for useful information for 30 seconds:

        ps_pabx -s pabx.example.com -u username -p password

* Listen for useful information for 10 seconds:

        ps_pabx -s pabx.example.com -u username -p password -t 10

* Listen continuously for data and store it in a given directory:

        ps_pabx -s pabx.example.com -u username -p password -d /output/directory

## What else?
Developed by Lucas Vieira <lucas@vieira.io>, July 2016.

If you noticed a problem whatsoever, please, let me know.

Also, accepting PRs for better spec tests and anything else, really.
