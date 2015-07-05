#!/bin/sh

bundle exec sidekiq -q latest_scan -c 1 &


bundle exec sidekiq -q scan_low -c 1 &
bundle exec sidekiq -q scan_high -c 1 &
bundle exec sidekiq -q scan_veryhigh -c 1 &

bundle exec sidekiq -q full_scan -c 1 &
bundle exec sidekiq -q process_players -c 1 &

bundle exec sidekiq -q process_match -c 25 &
bundle exec sidekiq -q process_match -c 25 &
bundle exec sidekiq -q process_match -c 25 &
bundle exec sidekiq -q process_match -c 25 &
