# frozen_string_literal: true

class Campaign < ApplicationRecord
  has_attached_file :profile_photo, styles: { medium: '1000x1000>', thumb: '100x100>' }, default_url: 'assets/images/:style/missing.png'
  has_attached_file :cover_photo, styles: { medium: '1000x1000>', thumb: '100x100>' }, default_url: 'assets/images/:style/missing.png'
  has_attached_file :description_photo, styles: { medium: '1000x1000>', thumb: '100x100>' }, default_url: 'assets/images/:style/missing.png'
  validates :title, :description, :goal, presence: true
  belongs_to :user
  has_many :comments
  validates_attachment_content_type :profile_photo, content_type: /\Aimage\/.*\z/
  validates_attachment_content_type :cover_photo, content_type: /\Aimage\/.*\z/
  validates_attachment_content_type :description_photo, content_type: /\Aimage\/.*\z/


  scope :finished, -> {where(status: true)}


  def cover_photo_url
    cover_photo.url(:medium)
  end
  def profile_photo_url
    profile_photo.url(:medium)
  end
  def description_photo_url
    description_photo.url(:medium)
  end
end
