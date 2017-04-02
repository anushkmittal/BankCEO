import Foundation
//TODO: Make it for an additional of $ -- in the investment controller

public class InvestmentManager {
    
    var govBondPercentage: Float = 33.33
    var coorpBondPercentage: Float = 33.33
    var stockPercentage: Float = 33.33
    
    ///TOTAL Amount Invested
    var totalGovBond: Float = 0
    ///TOTAL Amount Invested
    var totalCoorpBond: Float = 0
    ///TOTAL Amount Invested
    var totalStock: Float = 0
    
    // projected amount invested in gov bonds
    var projectedGovBond: Float = 0
    // projected amount invested in coorp bonds
    var projectedCoorpBond: Float = 0
    // projected amount invest in stock market
    var projectedStockBond: Float = 0
    
    var govEarning: Float = 0
    var coorpEarning: Float = 0
    var stockEarning: Float = 0
    
    var count: Float = 0
    var diversify: Float = 20/100
    
    var investableFunds: Float
    
    init(investableFunds: Float) {
        self.investableFunds = investableFunds
        // update total investments of different types each time
        totalGovBond = projectedGovBond
        totalCoorpBond = projectedCoorpBond
        totalStock = projectedStockBond
        // update the projected investments
        projectedGovBond = govBondPercentage*investableFunds
        projectedCoorpBond = coorpBondPercentage*investableFunds
        projectedStockBond = stockPercentage*investableFunds
    }
    
    
    public func updateProjections() {
        projectedGovBond = govBondPercentage*investableFunds
        projectedCoorpBond = coorpBondPercentage*investableFunds
        projectedStockBond = stockPercentage*investableFunds
        
    }
    
    public func updateGovProjections() {
        // projected amount invested in gov bonds
        projectedGovBond = govBondPercentage*investableFunds
        
        // Government Bond Earnings
        if count>3 {
            govEarning = 2.5 / 100 * projectedGovBond
        } else {
            govEarning = ((count * 0.2) + 0.4) / 100 * projectedGovBond
        }
    }
    
    public func updateCoorpProjections() {
        // projected amount invested in coorp bonds
        projectedCoorpBond = coorpBondPercentage*investableFunds
        
        // Coorporate Bond Earning
        if (count<5) {
            coorpEarning = 5/100 * projectedCoorpBond
        } else {
            coorpEarning = 8/100 * projectedCoorpBond
        }
        
    }
    
    public func updateStockProjections() {
        // projected amount invest in stock market
        projectedStockBond = stockPercentage*investableFunds
        
        // Stock Market Earning
        if (diversify < 20 && (randomIntFrom(start: 1, to: 100) <= 40)) {
            // bumper lottery ;)
            stockEarning = 70/100 * projectedStockBond
        } else {
            stockEarning = Float(randomIntFrom(start: 0 + Int(diversify), to: 100 + Int(diversify))) * projectedStockBond
        }
    }
    
    
    public func updateEarnings() {
        count += 1
        
        // Government Bond Earnings
        if count>3 {
            govEarning = 2.5 / 100 * totalGovBond
        } else {
            govEarning = ((count * 0.2) + 0.4)/100 * totalGovBond
        }
        
        // Coorporate Bond Earning
        
        if (count<5) {
            coorpEarning = 5/100 * totalCoorpBond
        } else {
            coorpEarning = 8/100 * totalCoorpBond
        }
        
        // Stock Market Earning
        
        if (diversify < 20 && (randomIntFrom(start: 1, to: 100) <= 40)) {
            // bumper lottery ;)
            stockEarning = 70/100 * totalStock
        } else {
            stockEarning = Float(randomIntFrom(start: 0 + Int(diversify), to: 100 + Int(diversify))) * totalStock
        }
        
    }
    
    public func totalEarnings() -> Float {
        updateEarnings()
        return govEarning + coorpEarning + stockEarning
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
}
