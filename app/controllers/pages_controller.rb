class PagesController < ApplicationController
  def index
    @signatures = Signature.order(created_at: :asc)
  end
end
