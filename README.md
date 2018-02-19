Ruby, Web based implementation of Auction Sniper example from
"Growing Object-Oriented Software, Guided by Tests"

# AuctionSniper

An application that automatically bids in auctions.

## Initial choices

XMPP message broker

Openfire website "Service Unavailable"

Looking for alternatives here:
https://xmpp.org/software/servers.html

ejabberd looks good:
https://www.process-one.net/en/ejabberd

XMPP client for ruby:
https://github.com/xmpp4r/xmpp4r

Web GUI testing framework:
https://github.com/teamcapybara/capybara

bundler gem for packaging and managing dependencies:
https://bundler.io/v1.13/guides/creating_gem

### Setting up ejabberd

```bash
sudo apt-get install ejabberd
sudo ejabberdctl start
sudo ejabberdctl register sniper localhost sniper
sudo ejabberdctl register auction-item-54321 localhost auction
sudo ejabberdctl register auction-item-65432 localhost auction
```
