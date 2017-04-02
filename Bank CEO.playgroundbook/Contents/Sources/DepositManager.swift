import Foundation

public class DepositManager {
    
    // hypothetical formulae that will show change in market with change in interest rate
    // use that to calculate the project projections
    
    public var interest: Float // interest rate
    public var projections: Float // projected deposits based on new interest rate
    
    public init() {
        
        interest = 5/100  // 5% starting interest rate
        projections = (50000 + (interest*1000000)) + 500
        
    }
    
    public func getProjection() -> Float {
        
        projections = (50000 + (interest*1000000)) * (Float(randomIntFrom(start: 95, to: 115)/100))
        return projections
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
