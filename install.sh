# This assumes you have Ruby 2.3.3
# And you are on somekind of Ubuntu...

sudo apt-get install ffmpeg imagemagick postgresql postgresql-contrib redis-server

sudo -u postgres createdb ordinateur_prod
sudo -u postgres createuser --superuser $USER

gem install bundler

bundle
