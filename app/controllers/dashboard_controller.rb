class DashboardController < ApplicationController
  def index
     @dc = Dc.all.each
     @hq = Hq.all.each
  end
end
