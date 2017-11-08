class Contact < ActiveRecord::Base
	
	belongs_to :user

	validates :name, presence: true
	validates :email, presence: true
	validates :message, presence: true, length: { minimum: 10, maximum: 1000 }


end
