import Foundation
import UIKit

public class DepositViewController : UIViewController {
    
    
    var mySlider: UISlider!
    var label01 = UILabel() // current deposits
    var label02 = UILabel() // projected deposits
    var label03 = UILabel() // interest rate
    var label04 = UILabel() // interest paid
    var label05 = UILabel() // projected interest paid
    
    let bank = sharedBank
    
    public override func loadView() {
        
        title = "Deposits Statistics"
        
        // UI
        let view = UIView()
        view.backgroundColor = .white
        let image = UIImage(named: "bg.jpg")
        let imageView = UIImageView(image: image)
        view.addSubview(imageView)
        
        /**Adding stuff related to labels*/
        
        //set up label 01
        label01 = UILabel()
        label01.text = "CURRENT DEPOSITS: "
        label01.textColor = UIColor.white
        label01.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBlack)
        label01.textAlignment = .left
        
        //set up label 02
        label02 = UILabel()
        label02.text = "PROJECTED DEPOSITS: "
        label02.textColor = UIColor.white
        label02.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBlack)
        label02.textAlignment = .left
        
        //set up label 04
        label04 = UILabel()
        label04.text = "MONTHLY INTEREST PAID: "
        label04.textColor = UIColor.white
        label04.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBlack)
        label04.textAlignment = .left
        
        
        //set up label 05
        label05 = UILabel()
        label05.text = "PROJECTED INTEREST PAID: "
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
        
        //To retrieve from the key
        
        if let myVal = UserDefaults.standard.object(forKey: "LoanInterest") as? Float {
            print(myVal)
            mySlider.value = myVal
        } else {
            print("no value was set for this key")
            mySlider.value = 5
        }
        
        mySlider.isContinuous = true
        mySlider.tintColor = UIColor.blue
        mySlider.translatesAutoresizingMaskIntoConstraints = false
        
        mySlider.addTarget(self, action: #selector(DepositViewController.sliderValueDidChange), for: .valueChanged)
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
    
    public override func viewDidLoad() {
        label01.text = "CURRENT DEPOSITS: " + sharedBank.deposit.currency
        let proj = sharedBank.depositManager.getProjection()
        label02.text = "PROJECTED DEPOSITS: " + (bank.deposit + proj).currency
        if let myVal = UserDefaults.standard.object(forKey: "LoanInterest") as? Float {
            label03.text = "INTEREST RATE: " + String(Double(myVal)) + "%"
        } else {
            print("no value was set for this key")
            label03.text = "INTEREST RATE: 5%"
            mySlider.value = 5
        }
        label04.text = "MONTHLY INTEREST PAID: " + bank.interestPaid.currency
        label05.text = "PROJECTED INTEREST PAID: " + ((bank.deposit + proj) * bank.depositManager.interest).currency
    }
    
    
    /// States changed include: The new projections for the next quarter
    ///                         The new interest rate for the next quarter
    func sliderValueDidChange(sender:UISlider!)
    {
        //print("value--\(Int(sender.value))")
        
        // save the new interest deafult
        let userDefaults = UserDefaults.standard
        userDefaults.set(Float(Double(sender.value).roundTo(places: 1)), forKey: "LoanInterest")
        
        // update deposit manager
        bank.depositManager.interest = (Float(Double(sender.value).roundTo(places: 1))/100)
        
        // updated the projections
        label03.text = "INTEREST RATE: " + String(Double(sender.value).roundTo(places: 1))
        let proj = bank.depositManager.getProjection()
        label02.text = "PROJECTED DEPOSITS: " + (bank.deposit + proj).currency
        label05.text = "PROJECTED INTEREST PAID: " + ((bank.deposit + proj) * bank.depositManager.interest).currency
    }
    
}
