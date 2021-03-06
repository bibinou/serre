class Post < ActiveRecord::Base

  has_many :comments, :dependent => :destroy
  belongs_to :blog_category

  scope :last_posts, self.where(['published_at < ?', Time.now]).order('published_at DESC').limit(5)
  scope :by_category, lambda{ |category_id|
    self.where(['blog_category_id = ? AND published_at < ?', category_id, Time.now])
  }
  scope :by_month, lambda{ |year, month|
    self.where(["YEAR(created_at) = ? AND MONTH(created_at) = ? AND published_at < ?", year, month, Time.now])
  }

  def self.archives_by_month
    self.where(['published_at < ?', Time.now]).order('published_at DESC').group_by{|p| p.published_at.beginning_of_month}
  end


end

