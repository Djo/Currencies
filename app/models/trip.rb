class Trip < ActiveRecord::Base
  has_many :country_trips, :dependent => :destroy
  has_many :countries, :through => :country_trips

  belongs_to :user

  default_scope order('created_at DESC')

  attr_accessible :description, :completed_at, :country_trips_attributes

  accepts_nested_attributes_for :country_trips, :reject_if => :all_blank

  validates :user_id, :presence => true
  validates :description, :presence => true
  validates :completed_at, :presence => true

  def self.dates(user)
    unscoped.select('DISTINCT completed_at').
             where('user_id' => user.id).
             order('completed_at ASC').
             map &:completed_at
  end
end
