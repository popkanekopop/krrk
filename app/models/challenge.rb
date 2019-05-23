class Challenge < ApplicationRecord
  belongs_to :user
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 140 }
  validate  :picture_size

  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader


  private

  # アップロード画像のサイズを検証する
  def picture_size
    if picture.size > 5.megabytes
      errors.add(:picture, "should be less than 5MB")
    end
  end
end
