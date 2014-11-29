class Video < ActiveRecord::Base
  belongs_to :category
  validates :title, :description, presence: true

  def self.search_by_title(search_term)
    return [] if search_term.blank?
    self.where("title iLIKE ?", "%#{search_term}%").order("created_at ASC")
  end
end