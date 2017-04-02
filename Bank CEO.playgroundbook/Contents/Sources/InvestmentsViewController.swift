import Foundation
import UIKit

public class InvestmentsViewController : UIViewController {
    
    
    var mySlider0: UISlider!
    var mySlider1: UISlider!
    var mySlider2: UISlider!
    var label01 = UILabel()
    var label02 = UILabel()
    var label03 = UILabel()
    var labelA = UILabel()
    var labelB = UILabel()
    var labelC = UILabel()
    var labelZ = UILabel()
    let userDefaults = UserDefaults.standard
    
    var govtSelect: Int = 0
    var corpSelect: Int = 0
    var stockSelect: Int = 0
    
    
    public override func loadView() {
        
        title = "Investments Statistics"
        
        //hacky workaround to avoid unwrapping nils
        //no known side effect for now
        
        userDefaults.set(0, forKey: "governmentBonds")
        userDefaults.set(0, forKey: "stockMarket")
        userDefaults.set(0, forKey: "coorporateBonds")
        
        // UI
        let view = UIView()
        view.backgroundColor = .white
        let image = UIImage(named: "bg.jpg")
        let imageView = UIImageView(image: image)
        view.addSubview(imageView)
        
        /**Adding stuff related to labels*/
        
        //set up label 01
        label01 = UILabel()
        label01.text = "0 % Invested in Government Bonds for a total of $0"
        label01.textColor = UIColor.white
        label01.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightBlack)
        label01.textAlignment = .left
        
        //set up slider 01
        mySlider0 = UISlider(frame:CGRect(x: 10, y: 100, width: 300, height: 20))
        mySlider0.minimumValue = 0
        mySlider0.maximumValue = 100
        mySlider0.isContinuous = true
        mySlider0.tintColor = UIColor.blue
        mySlider0.translatesAutoresizingMaskIntoConstraints = false
        mySlider0.addTarget(self, action: #selector(InvestmentsViewController.governmentBonds), for: .valueChanged)
        
        
        
        //set up label 02
        label02 = UILabel()
        label02.text = "0% Invested in Corporate Bond for a total of $0"
        label02.textColor = UIColor.white
        label02.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightBlack)
        label02.textAlignment = .left
        
        //set up slider 02
        mySlider1 = UISlider(frame:CGRect(x: 10, y: 100, width: 300, height: 20))
        mySlider1.minimumValue = 0
        mySlider1.maximumValue = 100
        mySlider1.isContinuous = true
        mySlider1.tintColor = UIColor.blue
        mySlider1.translatesAutoresizingMaskIntoConstraints = false
        mySlider1.addTarget(self, action: #selector(InvestmentsViewController.coorporateBonds), for: .valueChanged)
        
        
        //set up label 03
        label03 = UILabel()
        label03.text = "0% Invested in Stock Market for a total of $0"
        label03.textColor = UIColor.white
        label03.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightBlack)
        label03.textAlignment = .left
        
        //set up slider 03
        mySlider2 = UISlider(frame:CGRect(x: 10, y: 100, width: 300, height: 20))
        mySlider2.minimumValue = 0
        mySlider2.maximumValue = 100
        mySlider2.isContinuous = true
        mySlider2.tintColor = UIColor.blue
        mySlider2.translatesAutoresizingMaskIntoConstraints = false
        mySlider2.addTarget(self, action: #selector(InvestmentsViewController.stockMarket), for: .valueChanged)
        
        // set up label A
        labelA = UILabel()
        labelA.text = "Projected Government Bond Earning: "
        labelA.textColor = UIColor.white
        labelA.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightBlack)
        labelA.textAlignment = .left
        
        // set up label B
        labelB = UILabel()
        labelB.text = "Projected Corporate Bond Earning: "
        labelB.textColor = UIColor.white
        labelB.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightBlack)
        labelB.textAlignment = .left
        
        // set up label C
        labelC = UILabel()
        labelC.text = "Projected Stock Market Earning: "
        labelC.textColor = UIColor.white
        labelC.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightBlack)
        labelC.textAlignment = .left
        
        // set up label Z
        labelZ = UILabel()
        labelZ.text = "Total Percentage: "
        labelZ.textColor = UIColor.white
        labelZ.font = UIFont.systemFont(ofSize: 18, weight: UIFontWeightBlack)
        labelZ.textAlignment = .center
        
        //set up button 2
        let image2 = UIImage(named: "loans.png")
        let button2 = UIButton(type: UIButtonType.custom)
        button2.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        button2.setImage(image2, for: .normal)
        button2.addTarget(self, action: #selector(InvestmentsViewController.fillUp), for:.touchUpInside)
        
        // stack
        let stackView00 = UIStackView(arrangedSubviews: [label01, mySlider0, label02, mySlider1, label03, mySlider2, labelA, labelB, labelC, labelZ, button2])
        stackView00.axis = .vertical
        stackView00.spacing = 25
        stackView00.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView00)
        
        // Layout
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            //background constrains
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // stack00 constrains
            label01.widthAnchor.constraint(equalTo: stackView00.widthAnchor),
            mySlider0.widthAnchor.constraint(equalTo: stackView00.widthAnchor),
            label02.widthAnchor.constraint(equalTo: stackView00.widthAnchor),
            mySlider1.widthAnchor.constraint(equalTo: stackView00.widthAnchor),
            label03.widthAnchor.constraint(equalTo: stackView00.widthAnchor),
            mySlider2.widthAnchor.constraint(equalTo: stackView00.widthAnchor),
            labelA.widthAnchor.constraint(equalTo: stackView00.widthAnchor),
            labelB.widthAnchor.constraint(equalTo: stackView00.widthAnchor),
            labelC.widthAnchor.constraint(equalTo: stackView00.widthAnchor),
            labelZ.widthAnchor.constraint(equalTo: stackView00.widthAnchor),
            
            
            stackView00.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView00.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView00.topAnchor.constraint(equalTo: view.topAnchor, constant: 65),
            
            ])
        
        self.view = view
    }
    
    
    public override func viewDidLoad() {
        var totalPercentage: Int = 0
        
        govtSelect = sharedBank.storeA
        corpSelect = sharedBank.storeB
        corpSelect = sharedBank.storeC
        
        //TODO: Add stuff prepopulated on screen load
        if let myVal = UserDefaults.standard.object(forKey: "governmentBonds") as? Int {
            
            if (myVal == 0) {
                label01.text = String(govtSelect) + "% Invested in Government Bonds for a total of " + sharedBank.investmentManager.totalGovBond.currency
                totalPercentage += myVal
            } else {
                label01.text = String(myVal) + "% Invested in Government Bonds for a total of " + sharedBank.investmentManager.totalGovBond.currency
                totalPercentage += myVal
            }
        }
        
        if let myVal1 = UserDefaults.standard.object(forKey: "coorporateBonds") as? Int {
            if (myVal1 == 0) {
                label01.text = String(corpSelect) + "% Invested in Coorporate Bonds for a total of " + sharedBank.investmentManager.totalCoorpBond.currency
                totalPercentage += myVal1
            } else {
                label01.text = String(myVal1) + "% Invested in Coorporate Bonds for a total of " + sharedBank.investmentManager.totalCoorpBond.currency
                totalPercentage += myVal1
            }
        }
        
        if let myVal2 = UserDefaults.standard.object(forKey: "stockMarket") as? Int {
            if (myVal2 == 0) {
                label01.text = String(stockSelect) + "% Invested in Stock Market for a total of " + sharedBank.investmentManager.totalStock.currency
                totalPercentage += myVal2
            } else {
                label01.text = String(myVal2) + "% Invested in Stock Market for a total of " + sharedBank.investmentManager.totalStock.currency
                totalPercentage += myVal2
            }
        }
        
        labelZ.text = "Total Percentage: " + String(totalPercentage) + "%"
        if(totalPercentage != 100) {
            labelZ.textColor = UIColor.red
            
        } else {
            labelZ.textColor = UIColor.green
            
        }
        
    }
    
    func calculateTotal() -> Int {
        
        var totalPercentage: Int = 0
        print("calculate total called")
        
        print(govtSelect)
        print(corpSelect)
        print(stockSelect)
        totalPercentage += govtSelect
        totalPercentage += corpSelect
        totalPercentage += stockSelect
        
        print("total percentage: \(totalPercentage)")
        return totalPercentage
    }
    
    /// State Change: Directly updates the percentage of investable funds used to purchase gov bonds
    func governmentBonds(sender:UISlider!)
    {
        print("value--\(Int(sender.value))")
        govtSelect = Int(sender.value)
        // save the new interest deafult
        userDefaults.set(Int(sender.value), forKey: "governmentBonds")
        
        // calculate and display total percentage
        
        labelZ.text = "Total Percentage: " + String(calculateTotal()) + "%"
        if(calculateTotal() != 100) {
            labelZ.textColor = UIColor.red
            
        } else {
            labelZ.textColor = UIColor.green
            
        }
        
        sharedBank.investmentManager.govBondPercentage = Float(Double(sender.value).roundTo(places: 1))/100
        sharedBank.investmentManager.updateGovProjections()
        
        label01.text = String(Double(sender.value).roundTo(places: 1)) + "% Invested in Government Bonds for a total of " + sharedBank.investmentManager.projectedGovBond.currency
        labelA.text = "Projected Government Bond Earning: " + sharedBank.investmentManager.govEarning.currency
    }
    
    /// State Change: Directly updates the percentage of investable funds used to purchase coorp bonds
    ///               Total Number of coorp bonds invested
    ///               Total earning right now
    func coorporateBonds(sender:UISlider!)
    {
        print("value--\(Int(sender.value))")
        
        // save the new interest deafult
        userDefaults.set(Int(sender.value), forKey: "coorporateBonds")
        corpSelect = Int(sender.value)
        
        labelZ.text = "Total Percentage: " + String(calculateTotal()) + "%"
        if(calculateTotal() != 100) {
            labelZ.textColor = UIColor.red
            
        } else {
            labelZ.textColor = UIColor.green
            
        }
        
        sharedBank.investmentManager.coorpBondPercentage = Float(Double(sender.value).roundTo(places: 1))/100
        sharedBank.investmentManager.updateCoorpProjections()
        
        label02.text = String(Double(sender.value).roundTo(places: 1)) + "% Invested in Coorporate Bonds for a total of " + sharedBank.investmentManager.projectedCoorpBond.currency
        labelB.text = "Projected Corporate Bond Earning: " + sharedBank.investmentManager.coorpEarning.currency
    }
    
    /// State Change: Directly updates the percentage of investable funds used to purchase stock market shares
    func stockMarket(sender:UISlider!)
    {
        print("value--\(Int(sender.value))")
        stockSelect = Int(sender.value)
        
        // save the new interest deafult
        userDefaults.set(Int(sender.value), forKey: "stockMarket")
        
        labelZ.text = "Total Percentage: " + String(calculateTotal()) + "%"
        if(calculateTotal() != 100) {
            labelZ.textColor = UIColor.red
            
        } else {
            labelZ.textColor = UIColor.green
            
        }
        
        sharedBank.investmentManager.stockPercentage = Float(Double(sender.value).roundTo(places: 1))/100
        sharedBank.investmentManager.updateStockProjections()
        
        label03.text = String(Double(sender.value).roundTo(places: 1)) + "% Invested in Stock Market for a total of " + sharedBank.investmentManager.projectedStockBond.currency
        labelC.text = "Projected Stock Market Earning: " + sharedBank.investmentManager.stockEarning.currency
    }
    
    public override func viewWillDisappear(_ animated: Bool) {
        sharedBank.storeA = govtSelect
        sharedBank.storeB = corpSelect
        sharedBank.storeC = stockSelect
        self.fillUp()
    }
    
    public override func viewDidDisappear(_ animated: Bool) {
        self.fillUp()
    }
    
    public func fillUp() {
        // fill up all sliders equally
        //first check current percentage
        
        let tempTotal = calculateTotal()
        
        if (tempTotal == 100) {
            return
        }
        if (tempTotal<100) {
            // fill up each of them with remaining amount equally
            let toAdd = 100 - calculateTotal()
            govtSelect += toAdd/3
            corpSelect += toAdd/3
            stockSelect += toAdd/3
        } else if (tempTotal>100) {
            // remove from each of them with extra amount equally
            let toRemove = calculateTotal() - 100
            govtSelect -= toRemove/3
            corpSelect -= toRemove/3
            stockSelect -= toRemove/3
        }
        
        // updateUI
        
        if (tempTotal != 100) {
            mySlider0.value = Float(govtSelect)
            mySlider1.value = Float(corpSelect)
            mySlider2.value = Float(stockSelect)
            
            labelZ.text = "Total Percentage: " + String(calculateTotal()) + "%"
            labelZ.textColor = UIColor.green
            
            // for govt bond
            sharedBank.investmentManager.govBondPercentage = Float(Double(govtSelect).roundTo(places: 1)) / 100
            sharedBank.investmentManager.updateGovProjections()
            label01.text = String(sharedBank.investmentManager.govBondPercentage) + "% Invested in Government Bonds for a total of " + sharedBank.investmentManager.projectedGovBond.currency
            labelA.text = "Projected Government Bond Earning: " + sharedBank.investmentManager.govEarning.currency
            
            // for corp bond
            sharedBank.investmentManager.coorpBondPercentage = Float(Double(corpSelect).roundTo(places: 1))/100
            sharedBank.investmentManager.updateCoorpProjections()
            label02.text = String(sharedBank.investmentManager.coorpBondPercentage) + "% Invested in Coorporate Bonds for a total of " + sharedBank.investmentManager.projectedCoorpBond.currency
            labelB.text = "Projected Corporate Bond Earning: " + sharedBank.investmentManager.coorpEarning.currency
            
            // for stock earning
            sharedBank.investmentManager.stockPercentage = Float(Double(stockSelect).roundTo(places: 1))/100
            sharedBank.investmentManager.updateStockProjections()
            label03.text = String(sharedBank.investmentManager.stockPercentage) + "% Invested in Stock Market for a total of " + sharedBank.investmentManager.projectedStockBond.currency
            labelC.text = "Projected Stock Market Earning: " + sharedBank.investmentManager.stockEarning.currency
        }
        
    }
}
