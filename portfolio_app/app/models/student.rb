class Student < ApplicationRecord

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :major, presence: true
    validates :graduation_date, presence: true
    validates :school_email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
    validate :acceptable_image

    has_one_attached :avatar

    def avatar_url
        if avatar.attached?
            avatar
        else
            'portfolio_app\app\assets\images\default_image.jpg'  # Path to your default image
        end
    end

    def acceptable_image
        return unless avatar.attached?

        unless avatar.blob.byte_size <= 1.megabyte
            errors.add(:avatar, "is too big")
        end
        
        acceptable_types = ["image/jpeg", "image/png"]
        unless acceptable_types.include?(avatar.content_type)
            errors.add(:avatar, "must be a JPEG or PNG")
        end
    end
end
