class Post < ApplicationRecord
  has_one_attached :image
  belongs_to :user
  has_many :comments, dependent: :destroy
  has_many :favorites, dependent: :destroy

  validates :title, presence: true
  validates :body, presence: true
  validates :keyword, presence: true
  validates :tag, presence: true, exclusion: { in: %w(---) }


  enum tag: {
    "---":0,
     hokkaido:1,aomnori:2,iwate:3,miyagi:4,akita:5,yamagata:6,fukushima:7,
     ibaraki:8,tochigi:9,gunma:10,saitama:11,chiba:12,tokyo:13,kanagawa:14,
     niigata:15,toyama:16,ishikawa:17,fukui:18,yamanashi:19,nagano:20,
     gifu:21,shizuoka:22,aichi:23,mie:24,
     shiga:25,kyoto:26,osaka:27,hyogo:28,nara:29,wakayama:30,
     tottori:31,shimane:32,okayama:33,hiroshima:34,yamaguchi:35,
     tokushima:36,kagawa:37,ehime:38,kochi:39,
     fukuoka:40,saga:41,nagasaki:42,kumamoto:43,oita:44,miyazaki:45,kagoshima:46,
     okinawa:47
  }

  # 並び替え機能用
  scope :latest, -> { order(created_at: :desc) }
  scope :old, -> { order(created_at: :asc) }
  scope :most_favorited, -> { includes(:favorites).sort_by { |x| x.favorites.includes(:favorites).size }.reverse }
  scope :most_commented, -> { includes(:comments).sort_by { |x| x.comments.includes(:comments).size }.reverse }

  # 検索機能用
  def self.search_for(keyword)
    Post.where('keyword LIKE ? OR title LIKE ?', "%#{keyword}%", "%#{keyword}%")
  end

  def favorited_by?(user)
    favorites.exists?(user_id: user.id)
  end
end
