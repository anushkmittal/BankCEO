import Foundation
import UIKit

public class LoansViewController : UIViewController {
    
    
    var mySlider: UISlider!
    /// Current Loans
    var label01 = UILabel()
    /// projected loans
    var label02 = UILabel()
    /// interest rate
    var label03 = UILabel()
    /// interest earned
    var label04 = UILabel()
    /// project interest earned
    var label05 = UILabel()
    
    let bank = sharedBank
    public override func loadView() {
        
        title = "Loans Statistics"
        
        // UI
        let view = UIView()
        view.backgroundColor = .white
        let image = UIImage(named: "bg.jpg")
        let imageView = UIImageView(image: image)
        view.addSubview(imageView)
        
        /**Adding stuff related to labels*/
        
        //set up label 01
        label01 = UILabel()
        label01.text = "CURRENT LOANS: "
        label01.textColor = UIColor.white
        label01.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBlack)
        label01.textAlignment = .left
        
        //set up label 02
        label02 = UILabel()
        label02.text = "PROJECTED LOANS: "
        label02.textColor = UIColor.white
        label02.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBlack)
        label02.textAlignment = .left
        
        
        //set up label 04
        label04 = UILabel()
        label04.text = "MONTHLY INTEREST EARNED: "
        label04.textColor = UIColor.white
        label04.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBlack)
        label04.textAlignment = .left
        
        //set up label 04
        label05 = UILabel()
        label05.text = "PROJECTED INTEREST EARNED: "
        label05.textColor = UIColor.white
        label05.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBlack)
        label05.textAlignment = .left
        
        //set up label 03
        label03 = UILabel()
        label03.text = "INTEREST RATE: "
        label03.textColor = UIColor.white
        label03.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBlack)
        label03.textAlignment = .left
        
        // stack
        let stackView00 = UIStackView(arrangedSubviews: [label01, label02, label04, label05, label03])
        stackView00.axis = .vertical
        stackView00.spacing = 20
        stackView00.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView00)
        
        /**End labels stuff*/
        
        // Slider stuff
        mySlider = UISlider(frame:CGRect(x: 10, y: 100, width: 300, height: 20))
        mySlider.minimumValue = 0
        mySlider.maximumValue = 100
        mySlider.isContinuous = true
        mySlider.tintColor = UIColor.blue
        mySlider.translatesAutoresizingMaskIntoConstraints = false
        
        mySlider.addTarget(self, action: #selector(LoansViewController.sliderValueDidChange), for: .valueChanged)
        view.addSubview(mySlider)
        
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
            label02.widthAnchor.constraint(equalTo: stackView00.widthAnchor),
            label03.widthAnchor.constraint(equalTo: stackView00.widthAnchor),
            label04.widthAnchor.constraint(equalTo: stackView00.widthAnchor),
            label05.widthAnchor.constraint(equalTo: stackView00.widthAnchor),
            
            stackView00.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView00.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView00.topAnchor.constraint(equalTo: view.topAnchor, constant: 65),
            
            //slider
            mySlider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mySlider.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mySlider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            
            ])
        
        self.view = view
    }
    
    
    /// States Changed 1. loan interest rate for next quarter
    ///                2. loan projections for next quarter
    func sliderValueDidChange(sender:UISlider!)
    {
        //print("value--\(Int(sender.value))")
        let userDefaults = UserDefaults.standard
        userDefaults.set(sender.value, forKey: "LoanInterestCorrect")
        
        // update loan manager
        bank.loanManager.interest = (Float(Double(sender.value).roundTo(places: 1))/100)
        
        
        // updated the projections
        label03.text = "INTEREST RATE: " + String(Double(sender.value).roundTo(places: 1))
        let proj = sharedBank.loanManager.getProjection()
        label02.text = "PROJECTED LOANS: " + (bank.loan + proj).currency
        label05.text = "PROJECTED INTEREST EARNED: " + ((bank.loan + proj) * bank.loanManager.interest).currency
        
    }
    
    public override func viewDidLoad() {
        print("printing loan values")
        
        label01.text = "CURRENT LOANS: " + sharedBank.loan.currency
        let proj = sharedBank.loanManager.getProjection()
        label02.text = "PROJECTED LOANS: " + (bank.loan + proj).currency
        if let myVal = UserDefaults.standard.object(forKey: "LoanInterestCorrect") as? Float {
            label03.text = "INTEREST RATE: " + String(Double(myVal)) + "%"
        } else {
            print("no value was set for this key")
            label03.text = "INTEREST RATE: 5%"
            mySlider.value = bank.loanManager.interest
        }
        label04.text = "MONTHLY INTEREST EARNED: " + bank.interestEarned.currency
        label05.text = "PROJECTED INTEREST EARNED: " + ((bank.loan + proj) * bank.loanManager.interest).currency
        
        print(sharedBank.loan)
        print(proj)
        print(bank.loanManager.interest)
        print(bank.interestEarned)
        print((bank.loan + proj) * bank.loanManager.interest)
    }
    
}
