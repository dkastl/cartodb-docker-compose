npm run carto-node
npm run build:static
RAILS_ENV=development bundle exec rake db:create
RAILS_ENV=development bundle exec rake db:migrate

RAILS_ENV=development bundle exec script/resque > resque.log 2>&1 &
# RAILS_ENV=development bundle exec rails server
RAILS_ENV=development bundle exec thin start --threaded -p 3000 --threadpool-size 5
