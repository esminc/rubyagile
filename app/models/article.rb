class Article < ActiveRecord::Base
  belongs_to :user
  has_many :images, :dependent => :destroy

  acts_as_searchable :searchable_fields => [:title, :body]

  named_scope :publishing, :conditions => {:publishing => true}
  named_scope :newer_first, :order => %Q(#{quoted_table_name}.created_at DESC)
  named_scope :recent, :order => %Q(#{quoted_table_name}.created_at DESC), :limit => 10

  def self.find_all_written_by(user)
    Article.find_all_by_user_id(user.id, :order => "created_at DESC")
  end

  def prev_article
    load_neighbors unless @prev_article
    (@prev_article == self ? nil : @prev_article)
  end

  def next_article
    load_neighbors unless @next_article
    (@next_article == self ? nil : @next_article)
  end

  def author_name
    user.login
  end

  private
  def load_neighbors
    ids = (Article.find_by_sql [<<-SQL, {:id => id, :true => true}]).first
SELECT next.id as next_id, prev.id as prev_id FROM
 (select min(id) as id from articles where :id < id and publishing = :true) next,
 (select max(id) as id from articles where id < :id and publishing = :true) prev
    SQL
    @prev_article = Article.find_by_id(ids.prev_id)
    @next_article = Article.find_by_id(ids.next_id)
  end
end
