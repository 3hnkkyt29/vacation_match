class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :comment, presence: true

# 最新のコメントから表示させる用
  scope :latest, -> { order(created_at: :desc) }

end
