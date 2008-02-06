class Article < ActiveRecord::Base
  belongs_to :user
  has_many :comments
  validates_presence_of :title, :body

  def prev_article
    @prev_article ||= load_neighbors
  end

  def next_article
    @next_article ||= load_neighbors
  end

  private
  def load_neighbors
    ids = (Article.find_by_sql [<<-SQL, id, id]).first
SELECT next.id as next_id, prev.id as prev_id FROM
 (select min(id) as id from articles where ? < id) next,
 (select max(id) as id from articles where id < ?) prev
    SQL
    @prev_article = Article.find_by_id(ids.prev_id)
    @next_article = Article.find_by_id(ids.next_id)
  end
end
