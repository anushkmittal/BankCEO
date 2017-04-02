import Foundation

class LoanManager {
    
    var interest: Float
    var projections: Float
    var riskFactor: Float
    
    init(riskFactor: Float) {
        
        interest = 5/100  // 5% starting interest rate
        self.riskFactor = riskFactor
        projections = (((4000/interest) + 5000) + (riskFactor * 1000000))
        
    }
    
    func getProjection() -> Float {
        
        projections = (((4000/interest) + 5000) + (riskFactor * 1000000)) * (Float(randomIntFrom(start: 90, to: 110))/100)
        return projections
    }
    
    func randomIntFrom(start: Int, to end: Int) -> Int {
        
        var a = start
        var b = end
        
        // swap to prevent negative integer crashes
        
        if a > b {
            swap(&a, &b)
        }
        
        return Int(arc4random_uniform(UInt32(b - a + 1))) + a
    }
    
    func setRiskFactor(risk: Float) {
        riskFactor = risk
    }
    
}
