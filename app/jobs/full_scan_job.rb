require 'net/http'

class FullScanJob < ActiveJob::Base
  include Sidekiq::Worker
  queue_as :full_scan





  def get_json()
    # TODO: relations, multiple workers
    entry = ScannerStatus.first()
    if entry
      start_at_seq_num = entry.match_seq_num
    end
    if not start_at_seq_num
      ScannerStatus.new(match_seq_num: 240).save
      start_at_seq_num = 240
      logger.error 'NO SEQ NUMBER'
    end
    data = SteamAPI.get_matches(start_at_seq_num)
    if data and data['result'] and data['result']['matches'].count
      count = 0
      data['result']['matches'].each do |match|
        count+=1
        Match.add_match match
      end
      logger.error "Added #{count} full"
      if data['result']['matches'].last and (last_num = data['result']['matches'].last['match_seq_num'])
          ScannerStatus.first().update(match_seq_num: data['result']['matches'].last['match_seq_num'])
      end
    end
  end

  def perform(*args)
    # Do something later
    get_json
    sleep(5)
    FullScanJob.perform_later
  end
end
