require 'net/http'

class GetHeroesJob < ActiveJob::Base
  include Sidekiq::Worker
  # TODO: write me

end


