class TransactionsController < ApplicationController
    def index 
        transactions = Transaction.all
        recent_transactions = {}

        transactions.map do |transaction|
            recent_transactions.key?(transaction.payer) ? recent_transactions[transaction.payer] += transaction.points : recent_transactions[transaction.payer] = transaction.points
        end    
        render json: recent_transactions
    end

    def create
        new_transaction = Transaction.create(transaction_params)
        
        if new_transaction.valid?
            render json: new_transaction, status: 201
        else
            render json: {"errors": new_transaction.errors.full_messages}, status: 422
        end
    end

    def spend
        current_points = []
        Transaction.all.map do |trans|
            current_points << trans.points
        end
        total_points = current_points.sum
        transactions = Transaction.all

        

    end

    private

    def transaction_params
        params.permit(:payer, :points, :timestamp)
    end
end
