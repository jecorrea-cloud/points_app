class TransactionsController < ApplicationController
    def index 
        #Variables
        transactions = Transaction.all
        recent_transactions = {}
        #Iterate through and take out the proper attributes from all transactions
        transactions.map do |transaction|
            recent_transactions.key?(transaction.payer) ? recent_transactions[transaction.payer] += transaction.points : recent_transactions[transaction.payer] = transaction.points
        end    
        render json: recent_transactions
    end

    def create
        #Variable with the params from the request
        new_transaction = Transaction.create(transaction_params)
        #Check whether it is valid or not
        if new_transaction.valid?
            render json: new_transaction, status: 201
        else
            render json: {"errors": new_transaction.errors.full_messages}, status: 422
        end
    end

    def spend
        #Variables
        current_points = []
        Transaction.all.map do |trans|
            current_points << trans.points
        end
        total_points = current_points.sum
        #All transactions
        transactions = Transaction.all.sort_by(& :timestamp)
        #Points from the request to substract
        points_to_substract = params(:points)
        #Hash for the response
        spent_balance = {}

        if total_points < points_to_substract
            render json: {"Fatal": "Not enough points"}
        else
            transactions.map do |transaction|
                if points_to_substract <= 0 
                    break
                end
                if transaction.points > 0
                    if points_to_substract - transaction.points >= 0
                        spent_balance[transaction.payer] =  (transaction.points * -1)
                        points_to_substract = points_to_substract - transaction.points
                        transaction.update(points: 0)
                    else
                        points_left = transaction.points - points_to_substract
                        spent_balance[transaction.payer] = (points_to_substract * -1)
                        points_to_substract = 0
                        transaction.update(points: points_left)
                    end
                else
                    points_to_substract = points_to_substract - transaction.points
                    spent_balance[transaction.payer] = transactions.points
                    transaction.update(points: 0)
                end
            end
        end
        render json: spent_balance
    end

    private

    def transaction_params
        params.permit(:payer, :points, :timestamp)
    end
end
