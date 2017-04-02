import Foundation

public let sharedBank = Bank(deposits: 1000000, loanedPercentage: 0)

public class Bank {
    
    // Liabilities
    
    /**Not all deposits would convert into assets. Interest rate paid on the deposit is lost*/
    
    /** Deposits */
    public let depositManager = DepositManager()
    public var deposit: Float // current deposits (deposits added each month)
    public var interestPaid: Float // this is our monthly loss
    public var totalInterestPaid: Float // this is our total loss
    
    //Assets
    
    public var bankReserves: Float
    public var usableFund: Float // this is the money that can be manipulated by bank
    
    /** Loans */
    public let loanManager = LoanManager(riskFactor: 5/100)
    public var loan: Float // current loans (loans added and subtracted each month)
    public var percentLoaned: Float // percent of the usable funds loaned
    public var interestEarned: Float // this is our monthly income
    public var totalInterestEarned: Float // this is our total income
    
    
    /** Investment */
    
    public var investment: Float
    public var percentInvested: Float
    public var investmentEarnings: Float // this is our monthly income
    public var totalInvestmentEarnings: Float = 0 // this is our total income
    public let investmentManager: InvestmentManager
    
    public var excessReserves: Float
    
    public var fed = Fed()
    
    convenience init() {
        self.init(deposits: 1000000, loanedPercentage: 0)
    }
    
    /// - parameter deposits: Initial amount of money deposits in bank at the beginning (in dollars)
    /// - parameter loanedPercentage: Initial percentage of money loaned. If not 0, then the remaining percentage is invested
    public init(deposits: Float, loanedPercentage: Float) {
        
        // First month initial conditions
        
        
        // deposit stuff
        deposit = deposits
        interestPaid = deposit * depositManager.interest
        ///////////////////////////////////////////////////
        bankReserves = deposit * fed.reserveRequirement
        usableFund = deposit - interestPaid - bankReserves
        
        
        // loan stuff
        percentLoaned = loanedPercentage // initial loan rate
        loan = usableFund * percentLoaned // amount of found loaned or received back's sum
        interestEarned = loanManager.interest * loan //interest earned income along the way
        
        // investment stuff
        // if (loanedPercentage == 0) {
        //     investment = 0 // initially no money is invested
        //     percentInvested = 0
        //     investmentEarnings = 0
        //     investmentManager = InvestmentManager(investableFunds: deposit * percentInvested)
        
        //} else {
        percentInvested = 1 - fed.reserveRequirement-percentLoaned-depositManager.interest
        investmentManager = InvestmentManager(investableFunds: deposit * percentInvested)
        
        investment = percentInvested * deposit // override by user choice
        investmentEarnings = investmentManager.totalEarnings()
        //  investmentEarnings = investmentManager.totalEarnings()
        // }
        
        totalInterestPaid = interestPaid
        totalInterestEarned = interestEarned
        totalInvestmentEarnings = investmentEarnings
        excessReserves = deposit - (bankReserves + loan + totalInterestEarned + investment + totalInvestmentEarnings)
    }
    
    public func nextQuarter(deposits: Float) {
        // next quarter
        // update all things by fetching and using all the latest information
        
        self.deposit += deposits // add deposits of the bank by said amount
        self.loan += loanManager.projections // add loans of the bank by said amount
        self.investment = (investmentManager.projectedGovBond + investmentManager.projectedCoorpBond + investmentManager.projectedStockBond)
        
        ///FOR THE MONTH
        interestPaid = deposits * depositManager.interest
        interestEarned = loanManager.projections * loanManager.interest
        
        
        
        recalculateStuff()
    }
    
    /// Should be called just once!
    public func recalculateStuff() {
        
        // stuff that changes with change in deposit
        totalInterestPaid = deposit * depositManager.interest // the new interest paid
        bankReserves = deposit * fed.reserveRequirement
        usableFund = deposit - totalInterestPaid - bankReserves
        
        // stuff that changes with change in loans
        //loan = usableFund * percentLoaned
        totalInterestEarned = loan * loanManager.interest  // the new interest earned
        
        // stuff that changes for the investments
        percentInvested = 1 - fed.reserveRequirement-percentLoaned-depositManager.interest
        investmentManager.investableFunds = deposit * percentInvested
        
        let newEarning = investmentManager.totalEarnings()
        investmentEarnings = newEarning - investmentEarnings
        
        totalInvestmentEarnings = newEarning
        
        excessReserves = deposit - (bankReserves + loan + totalInterestEarned + investment + totalInvestmentEarnings)
    }
    
    public func totalAsset() -> Float {
        print(bankReserves)
        print(loan)
        print(totalInterestEarned)
        print(investment)
        print(totalInvestmentEarnings)
        
        return  bankReserves + loan + totalInterestEarned + investment + totalInvestmentEarnings + excessReserves
    }
    
    public func totalLiabilites() -> Float {
        return deposit
    }
    
    public func monthlyEarnings() -> Float {
        return interestEarned + investmentEarnings - interestPaid
    }
    
    public func triggerRandomEvents() {
        
        if (randomIntFrom(start: 1+Int(loanManager.riskFactor), to: 100) >= 70) {
            // 50% of the high risk loans have defaulted
            loan = 50/100*loan
        }
        
    }
    
    public func randomIntFrom(start: Int, to end: Int) -> Int {
        
        var a = start
        var b = end
        
        // swap to prevent negative integer crashes
        if a > b {
            swap(&a, &b)
        }
        
        return Int(arc4random_uniform(UInt32(b - a + 1))) + a
    }
    
    
    ///Storage
    public var storeA: Int = 0
    public var storeB: Int = 0
    public var storeC: Int = 0
    
}
