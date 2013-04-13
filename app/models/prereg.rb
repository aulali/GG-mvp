class Prereg < ActiveRecord::Base
  extend ActiveModel::Naming
  include ActiveModel::Conversion
  include ActionView::Helpers::TextHelper
  include Rails.application.routes.url_helpers
  include ActionDispatch::Routing::UrlFor

  belongs_to :user
  belongs_to :event

  attr_accessible :event_id, :user_id

end
