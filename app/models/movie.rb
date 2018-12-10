class Movie < ApplicationRecord
  belongs_to :category

  validates :title, presence: true
  validates :description, presence: true

  scope :active, -> { where(is_deleted: false) }

  def destroy #:nodoc:
    run_callbacks(:destroy) do
      unless new_record?
        update_attribute(:is_deleted, true)
      end

      @destroyed = true
      freeze
    end
  end
end
