import Foundation

public class Fed {
    
    public var reserveRequirement: Float
    
    public init() {
        reserveRequirement = 10/100
    }
    
    public func setReserveRequirement(newPercentage: Float) {
        reserveRequirement = newPercentage
    }
    
    
}
