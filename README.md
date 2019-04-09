# vspec
vSpec is a set of inspec profiles specifically aimed at vsphere and VMware related products

# how to run
- Install inspec (https://inspec.io)
- clone this repo
- create a config file in each of the profiles (samples are provided)
- run ```inspec --exec psc --attrs path/to/your/config

# Notes

The only OS this has been tested and found working on is Linux. It probably also works on OSX. Windows is right out because inspec doesn't support http on windows. If you want to run this on windows, it works if you have the linux subsystem and install inspec under the linux subsystem. 

# Warning

*DO NOT USE IN PRODUCTION. THIS PRODUCT WILL CAUSE YOUR DATACENTER TO CATCH ON FIRE, EAT YOUR CAT AND STEAL YOUR CAR. IF FLAMING DATACENTERS PERSIST CONSULT A DOCTOR.*
