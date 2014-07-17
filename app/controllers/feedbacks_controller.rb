class FeedbacksController < ApplicationController
  layout 'manager'
  before_filter :authorize, only: [:index]

  def index
    @feedback = GetRequest.user_feedbacks
  end
end
