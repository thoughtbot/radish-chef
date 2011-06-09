# radish-chef

Chef recipes to hook up your cluster's Redis instances to [Radish](http://radishapp.com).

## Usage

These chef recipes install the following:

* The [daikon](http://rubygems.org/gems/daikon) ruby gem, Radish's client daemon
* An Upstart service to keep it running
* A user/group just to run daikon

## Requires

* Ubuntu 10
* Chef 0.10.x+
* Ruby 1.8.6+
* Redis 1.2.6+

## Help

If you're on a different distribution or you're having issues with these recipes, open up a request on [Radish Support](http://support.radishapp.com) or crack open a GitHub issue!

## License

Copyright (c) 2011 thoughtbot, Nick Quaranto. See LICENSE.txt for further details.
