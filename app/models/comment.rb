class Comment < ActiveRecord::Base
	belongs_to :post

	validates_presence_of :name
  validates_length_of :name, :within => 4..20
  validates_presence_of :body
  validates_length_of :body, :within => 20..500
end
