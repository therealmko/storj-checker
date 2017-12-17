storj.sh <option>
# Purpose
Simple shell script to check the status, monitor and restart storjshare daemon running in Docker

# Setup
Change the 1st 2 variables in the storj.sh script
```
STORJ_HOST="<Storj static ip, hostname or DDNS hostname>"

STORJ_PORT="<Forwarded port number>"
```
  
# Usage

Usage: $ storj.sh <option>
Valid options are:
- check
  - Will check if connection to <STORJ_HOST>:<STORJ_PORT> is available. If not will call startup.
- status
  - Will display regular Storj status bar.
- startup
  - Will attempt to startup Storj node daemon.
- version
  - Will display daemon, core and protocol versions





  
