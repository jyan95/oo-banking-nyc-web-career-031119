class Transfer
  attr_reader :sender, :receiver
  attr_accessor  :status, :amount, :executed

  def initialize(sender, receiver, amount)
    @sender = sender
    @receiver = receiver
    @amount = amount
    @status = "pending"
    @executed = false
  end

  def valid?
    @sender.valid? && @receiver.valid? ? true : false
  end

  def execute_transaction
    if @status != "complete"
      if self.valid? == true && @amount <= @sender.balance
        @sender.balance -= amount
        @receiver.balance += amount
        @status = "complete"
        @executed = true
      else
        @status = "rejected"
        "Transaction rejected. Please check your account balance."
      end
    end
  end

  def reverse_transfer
    if @executed == true
      @sender.balance += amount
      @receiver.balance -= amount
      @status = "reversed"
    end
  end
end
