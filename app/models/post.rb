class Post
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable

  field :body, type: String
  field :title, type: String
  field :archived, type: Boolean, default: false

  validates_presence_of :body, :title

  belongs_to :user
  has_many :comments

  default_scope ->{ ne(archived: true) }

  def archive!
    update_attribute :archived, true
  end


  def hotness
    if comments.count >=3
      return 4 if created_at.between? 24.hours.ago, Time.now 
      return 3 if created_at.between? 72.hours.ago, 24.hours.ago
      return 2 if created_at.between? 7.days.ago, 3.days.ago
      return 1
    else
      return 3 if created_at.between? 24.hours.ago, Time.now 
      return 2 if created_at.between? 72.hours.ago, 24.hours.ago
      return 1 if created_at.between? 7.days.ago, 3.days.ago
      return 0
    end
  end

  def self.get_all
    posts = self.all
    return posts
  end
end
