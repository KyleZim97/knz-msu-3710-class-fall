class Student < ApplicationRecord
    #Constants
    VALID_MAJORS = ["Computer Science BS", "Data Science and Machine Learning", "Mechanical Engineering", "Business Administration", "Psychology", "Biology", "Mathematics", "Nursing", "English Literature", "Political Science"]
    
    #validations
    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :major, presence: true
    validates :graduation_date, presence: true
    validates :school_email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
    validate :acceptable_image
    validates :major, inclusion: { in: VALID_MAJORS }

    #relationships
    has_one_attached :avatar
    has_one_attached :profile_picture, dependent: :purge_later

    #Image handeling
    def avatar_url
        if avatar.attached?
            avatar
        else
            'portfolio_app\app\assets\images\default_image.jpg' 
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
