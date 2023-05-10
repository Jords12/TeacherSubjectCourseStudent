class Teacher < ApplicationRecord
    has_many :subjects
    validate :acceptable_image
    has_one_attached :avatar

    def acceptable_image
        return unless avatar.attached?
          unless avatar.blob.byte_size <= 1.megabyte
            errors.add(:avatar, "its too big!")
          end
          acceptable_types = ["image/jpeg","image/png"]
          unless acceptable_types.include?(avatar.content_type)
            errors.add(:avatar, "must be JPEG or PNG")
          end
    end

end
