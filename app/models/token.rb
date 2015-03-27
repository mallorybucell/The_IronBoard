class Token < ActiveRecord::Base
  class Invalid < StandardError; end
  belongs_to :admin

  validates :key, presence: true, uniqueness: true
  validates_presence_of :description

  scope :valid, -> { where(active: true) }

  def disable!
    update active: false
  end

  def disabled?
    !active?
  end
end

