class LandingPageController < ApplicationController
  def welcome
    @gossips = Gossip.all
  end
end
