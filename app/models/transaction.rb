class Transaction < ApplicationRecord

    #Validations before entering the database
    validates :payer, :points, :datetime, presence: true
    validates :points, numericality: {'greater_than': 0} 

end
