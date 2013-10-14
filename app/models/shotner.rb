class Shotner < ActiveRecord::Base

  attr_accessible :public_link, :password_link, :user_id, :type_url, :original_url, :shortened_url, :usage_count

  belongs_to :user

  validates_presence_of :original_url
  validates_presence_of :shortened_url
  validates_uniqueness_of :shortened_url

  scope :index_last, lambda { |user_id|
    where('shotners.user_id is null').order('created_at DESC').first(7) unless !user_id.nil?
  }

  scope :index_popular, lambda { |user_id|
    where('shotners.user_id is null').order('usage_count DESC').first(7) unless !user_id.nil?
  }

  scope :index_my, lambda { |user_id|
    where('shotners.user_id = ?', user_id).order('created_at DESC') #unless !user_id.nil?
  }

  scope :url_to, lambda { |id|
    where('shotners.id = ?', id.to_i) #unless !user_id.nil?
  }

end
