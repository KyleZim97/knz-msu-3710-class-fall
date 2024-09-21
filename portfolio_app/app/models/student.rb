class Student < ApplicationRecord

    validates :first_name, presence: true
    validates :last_name, presence: true
    validates :major, presence: true
    validates :graduation_date, presence: true
    validates :school_email, presence: true, uniqueness: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "must be a valid email address" }
    

    #has_one_attached :avatar
end
