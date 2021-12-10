class Transaction < ApplicationRecord

    #Validations before entering the database
    validates :payer, :points, :datetime, presence: true

end
