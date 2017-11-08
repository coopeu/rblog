class Post < ActiveRecord::Base
	belongs_to :user 
	delegate :name, to: :user
	belongs_to :category
	has_many :comments



	validates :title, presence: true
	validates :category_id, presence: true
	validates :body, presence: true
	validates :user, presence: true

	has_attached_file :image, :default_url => ':style/rails1.jpg'
	validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/


	scope :ordered, -> {order('created_at DESC').paginate(:per_page => 10, :page => params[:page])}


	def self.search(query)
		where('title like ? OR body like ?', '%#{query}%', '%#{query}%')
	end


end