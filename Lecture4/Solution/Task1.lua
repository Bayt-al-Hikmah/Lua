local BankAccount = {}
BankAccount.__index = BankAccount

function BankAccount:initialize(accountNumber, ownerName, initialBalance)
    initialBalance = initialBalance or 0
    
    if initialBalance < 0 then
        error("Initial balance cannot be negative")
    end
    
    local account = {
        accountNumber = accountNumber,
        ownerName = ownerName,
        balance = initialBalance,
        transactions = {}
    }
    
    setmetatable(account, BankAccount)
    
    if initialBalance > 0 then
        table.insert(account.transactions, {
            type = "DEPOSIT",
            amount = initialBalance,
            balanceAfter = initialBalance,
            timestamp = os.date()
        })
    end
    
    return account
end

function BankAccount:deposit(amount)
    if amount <= 0 then
        error("Deposit amount must be positive")
    end
    
    self.balance = self.balance + amount
    
    table.insert(self.transactions, {
        type = "DEPOSIT",
        amount = amount,
        balanceAfter = self.balance,
        timestamp = os.date()
    })
    
    return self.balance
end

function BankAccount:withdraw(amount)
    if amount <= 0 then
        error("Withdrawal amount must be positive")
    end
    
    if self.balance < amount then
        error("Insufficient funds for withdrawal")
    end
    
    self.balance = self.balance - amount
    
    table.insert(self.transactions, {
        type = "WITHDRAWAL",
        amount = amount,
        balanceAfter = self.balance,
        timestamp = os.date()
    })
    
    return self.balance
end

function BankAccount:getBalance()
    return self.balance
end

function BankAccount:getStatement()
    print(string.format("Statement for Account #%s", self.accountNumber))
    print(string.format("Owner: %s", self.ownerName))
    print(string.format("Current Balance: %.2f", self.balance))
    print("\nTransaction History:")
    print("----------------------------------------")
    
    for _, transaction in ipairs(self.transactions) do
        print(string.format("%s | %s | Amount: %.2f | Balance: %.2f", 
              transaction.timestamp, 
              transaction.type, 
              transaction.amount, 
              transaction.balanceAfter))
    end
    
    print("----------------------------------------")
end

function BankAccount.transfer(sourceAccount, targetAccount, amount)
    if amount <= 0 then
        error("Transfer amount must be positive")
    end
    
    if sourceAccount.balance < amount then
        error("Source account has insufficient funds for transfer")
    end
    
    sourceAccount.balance = sourceAccount.balance - amount
    table.insert(sourceAccount.transactions, {
        type = "TRANSFER_OUT",
        amount = amount,
        balanceAfter = sourceAccount.balance,
        timestamp = os.date(),
        toAccount = targetAccount.accountNumber
    })
    
    targetAccount.balance = targetAccount.balance + amount
    table.insert(targetAccount.transactions, {
        type = "TRANSFER_IN",
        amount = amount,
        balanceAfter = targetAccount.balance,
        timestamp = os.date(),
        fromAccount = sourceAccount.accountNumber
    })
    
    return true
end

-- Tests
local account1 = BankAccount:initialize("12345", "Alice", 1000)
local account2 = BankAccount:initialize("67890", "Bob", 500)


local success, err = pcall(function() 
    account1:deposit(200) 
end)
if not success then print("Deposit error:", err) end

success, err = pcall(function() 
    account1:withdraw(300) 
end)
if not success then print("Withdrawal error:", err) end

success, err = pcall(function() 
    BankAccount.transfer(account1, account2, 400)
end)
if not success then print("Transfer error:", err) end

account1:getStatement()
account2:getStatement()

success, err = pcall(function() 
    account1:withdraw(1000) 
end)
if not success then print("Error:", err) end

success, err = pcall(function() 
    account1:deposit(-100) 
end)
if not success then print("Error:", err) end