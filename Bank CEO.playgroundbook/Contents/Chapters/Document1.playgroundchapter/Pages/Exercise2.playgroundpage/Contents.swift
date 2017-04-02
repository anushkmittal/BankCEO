//#-hidden-code
//
//  Contents.swift
//
//  Copyright (c) 2017 Anushk Mittal. All Rights Reserved.
//
//#-end-hidden-code
/*:
 **Goal:** Modify the code below to create your own set of rules for the bank simulator.

 To get started, run the code and observe what happens when you stimulate the percent loaned and interest rates for deposits and loans. Also, observe the projected monthly earnings change differently for different kinds of investments. Click the time forward icon to see next quarter results.
 
 Try modifying the rules of the simulation in the configureBank function. Experiment with different values to see what happens as you change initial conditions or modify the Fed.
 
 When you're ready, move on to the next page to explore a more complex set of rules for the bank simulator.
 */
//#-hidden-code
import PlaygroundSupport
import UIKit
import Foundation

public class DashboardViewController : UIViewController, LineChartDelegate {
    
    var labell = UILabel()
    var lineChart: LineChart!
    var mySlider: UISlider!
    var depositsLabel = UILabel()
    var percLoaned = UILabel()
    var label01 = UILabel() // deposits loss
    var label02 = UILabel() // loans profit
    var label03 = UILabel() // investment profits
    var label04 = UILabel() // net month profits
    var label004 = UILabel() // total bank assets
    var totalAssets: [CGFloat] = []
    
    //let bank = Bank()
    
    /**Editable Code*/
    public let bank = sharedBank
    
    public override func loadView() {
        
        title = "Bank CEO: Stimulate the Economy"
        
        // UI
        let view = UIView()
        view.backgroundColor = .white
        let image = UIImage(named: "bg.jpg")
        let imageView = UIImageView(image: image)
        view.addSubview(imageView)
        
        /*New Stuff related to labels buttons */
        
        //set up label 1
        depositsLabel = UILabel()
        depositsLabel.text = "DEPOSITS"
        depositsLabel.textColor = UIColor.white
        depositsLabel.textAlignment = .center
        depositsLabel.font = UIFont.boldSystemFont(ofSize: 17)
        
        //set up button 1
        let image1 = UIImage(named: "deposits.png")
        let button1 = UIButton(type: UIButtonType.custom)
        button1.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        button1.setImage(image1, for: .normal)
        button1.addTarget(self, action: #selector(DashboardViewController.deposit), for:.touchUpInside)
        
        // stack 1
        let stackView = UIStackView(arrangedSubviews: [depositsLabel, button1])
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        
        //set up label 2
        let label2 = UILabel()
        label2.text = "LOANS"
        label2.textColor = UIColor.white
        label2.textAlignment = .center
        label2.font = UIFont.boldSystemFont(ofSize: 17)
        
        //set up button 2
        let image2 = UIImage(named: "loans.png")
        let button2 = UIButton(type: UIButtonType.custom)
        button2.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        button2.setImage(image2, for: .normal)
        button2.addTarget(self, action: #selector(DashboardViewController.loan), for:.touchUpInside)
        
        // stack 2
        let stackView2 = UIStackView(arrangedSubviews: [label2, button2])
        stackView2.axis = .vertical
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView2)
        
        //set up label 3
        let label3 = UILabel()
        label3.text = "INVESTMENTS"
        label3.textColor = UIColor.white
        label3.textAlignment = .center
        label3.font = UIFont.boldSystemFont(ofSize: 17)
        
        //set up button 3
        let image3 = UIImage(named: "inv.png")
        let button3 = UIButton(type: UIButtonType.custom)
        button3.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        button3.setImage(image3, for: .normal)
        button3.addTarget(self, action: #selector(DashboardViewController.investment), for:.touchUpInside)
        
        // stack 3
        let stackView3 = UIStackView(arrangedSubviews: [label3, button3])
        stackView3.axis = .vertical
        stackView3.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView3)
        
        //set up label 4
        let depositsLabel11 = UILabel()
        depositsLabel11.text = ""
        depositsLabel11.textColor = UIColor.white
        depositsLabel11.textAlignment = .center
        depositsLabel11.font = UIFont.boldSystemFont(ofSize: 17)
        
        //set up button 4
        let image4 = UIImage(named: "time.png")
        let button44 = UIButton(type: UIButtonType.custom)
        button44.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        button44.setImage(image4, for: .normal)
        button44.addTarget(self, action: #selector(DashboardViewController.nextQuarter), for:.touchUpInside)
        
        // stack 4
        let stackView4 = UIStackView(arrangedSubviews: [depositsLabel11, button44])
        stackView4.axis = .vertical
        stackView4.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView4)
        
        /**End new stuff*/
        
        
        /**Adding stuff related to labels*/
        
        //set up label 01
        label01 = UILabel()
        label01.text = "Deposits: "
        label01.textColor = UIColor.white
        label01.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBlack)
        label01.textAlignment = .left
        
        //set up label 02
        label02 = UILabel()
        label02.text = "Loans: "
        label02.textColor = UIColor.white
        label02.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBlack)
        label02.textAlignment = .left
        
        
        //set up label 03
        label03 = UILabel()
        label03.text = "Investments: "
        label03.textColor = UIColor.white
        label03.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBlack)
        label03.textAlignment = .left
        
        //set up label 04
        label04 = UILabel()
        label04.text = "NET: "
        label04.textColor = UIColor.white
        label04.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBlack)
        label04.textAlignment = .left
        
        
        //set up label 004
        label004 = UILabel()
        label004.text = "Total Assets: "
        label004.textColor = UIColor.white
        label004.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBlack)
        label004.textAlignment = .left
        
        //set up label 05
        percLoaned = UILabel()
        percLoaned.text = "% Loaned: 0.00%"
        percLoaned.textColor = UIColor.white
        percLoaned.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBlack)
        percLoaned.textAlignment = .left
        
        // stack
        let stackView00 = UIStackView(arrangedSubviews: [label01, label02, label03, label04, label004, percLoaned])
        stackView00.axis = .vertical
        stackView00.spacing = 20
        stackView00.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView00)
        
        
        
        /**End labels stuff*/
        
        // Slider stuff
        mySlider = UISlider(frame:CGRect(x: 10, y: 100, width: 300, height: 20))
        mySlider.minimumValue = 0
        mySlider.maximumValue = 100 - (bank.fed.reserveRequirement * 100) - (bank.depositManager.interest * 100)
        mySlider.isContinuous = true
        mySlider.tintColor = UIColor.blue
        mySlider.translatesAutoresizingMaskIntoConstraints = false
        
        //mySlider.addTarget(
        //    self,
        //    action: Selector(("ImageViewController.sliderValueChanged:")),
        //    for: UIControlEvents.valueChanged)
        
        mySlider.addTarget(self, action: #selector(DashboardViewController.sliderValueDidChange), for: .valueChanged)
        //mySlider.addTarget(self, action: Selector(("sliderChange:")), for: .valueChanged)
        view.addSubview(mySlider)
        
        // graph stuff
        
        var views: [String: AnyObject] = [:]
        
        labell.text = "..."
        labell.translatesAutoresizingMaskIntoConstraints = false
        labell.textAlignment = NSTextAlignment.center
        view.addSubview(labell)
        views["labell"] = labell
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[labell]-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-260-[labell]", options: [], metrics: nil, views: views))
        
        lineChart = LineChart()
        lineChart.animation.enabled = true
        lineChart.area = false
        lineChart.x.grid.visible = false
        lineChart.x.labels.visible = false
        lineChart.y.grid.visible = false
        lineChart.y.labels.visible = false
        lineChart.dots.visible = false
        lineChart.translatesAutoresizingMaskIntoConstraints = false
        lineChart.addLine([3, 4, 9, 11, 13, 15])
        lineChart.delegate = self
        view.addSubview(lineChart)
        views["chart"] = lineChart
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-[chart]-|", options: [], metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[labell]-[chart(==260)]", options: [], metrics: nil, views: views))
        
        
        
        
        // Layout
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            //background constrains
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: view.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            // stack 1 constrains
            button1.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            button1.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.7),
            depositsLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            depositsLabel.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.3),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -21),
            
            // stack 2 constrains
            button2.widthAnchor.constraint(equalTo: stackView2.widthAnchor),
            button2.heightAnchor.constraint(equalTo: stackView2.heightAnchor, multiplier: 0.7),
            label2.widthAnchor.constraint(equalTo: stackView2.widthAnchor),
            label2.heightAnchor.constraint(equalTo: stackView2.heightAnchor, multiplier: 0.3),
            stackView2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView2.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -21),
            
            // stack 2 constrains
            button3.widthAnchor.constraint(equalTo: stackView3.widthAnchor),
            button3.heightAnchor.constraint(equalTo: stackView3.heightAnchor, multiplier: 0.7),
            label3.widthAnchor.constraint(equalTo: stackView3.widthAnchor),
            label3.heightAnchor.constraint(equalTo: stackView3.heightAnchor, multiplier: 0.3),
            stackView3.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            stackView3.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -21),
            
            stackView4.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView4.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 105),
            
            // stack00 constrains
            label01.widthAnchor.constraint(equalTo: stackView00.widthAnchor),
            label02.widthAnchor.constraint(equalTo: stackView00.widthAnchor),
            label03.widthAnchor.constraint(equalTo: stackView00.widthAnchor),
            label04.widthAnchor.constraint(equalTo: stackView00.widthAnchor),
            label004.widthAnchor.constraint(equalTo: stackView00.widthAnchor),
            
            stackView00.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 50),
            stackView00.topAnchor.constraint(equalTo: view.topAnchor, constant: 65),
            
            //slider
            mySlider.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mySlider.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 15),
            mySlider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            // mySlider.widthAnchor.constraint(equalTo: stackViewLast.widthAnchor),
            //  labelLast.widthAnchor.constraint(equalTo: stackViewLast.widthAnchor),
            
            //graph
            lineChart.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lineChart.topAnchor.constraint(equalTo: view.topAnchor, constant: 65),
            lineChart.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2),
            
            // final stack
            /*      stackViewLast.centerXAnchor.constraint(equalTo: view.centerXAnchor),
             stackViewLast.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 30),
             stackViewLast.topAnchor.constraint(equalTo: lineChart.bottomAnchor, constant: 80)
             */
            
            //last one
            //   labelLast.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            //     labelLast.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            
            
            
            
            ])
        
        self.view = view
    }
    
    public func leapButton() {
        
    }
    
    
    public override func viewDidLoad() {
        configureBank()
        //bank.recalculateStuff()
        updateStats()
    }
    
    /** Add all the latest details stuff here */
    public func updateStats() {
        updateDeposits() // update all the data models at first
        //bank.nextQuarter()
        // label01 deposits loss
        label01.text = "Deposits: -" + bank.interestPaid.currency
        
        // label02 loans profit
        label02.text = "Loans: +" + bank.interestEarned.currency
        
        // label03 investment profits
        label03.text = "Investments: +" + bank.investmentEarnings.currency
        
        // label04 net month profitss
        label04.text = "Net Monthly Earnings: " + bank.monthlyEarnings().currency
        
        // label004 total bank assets
        label004.text = "Total Assets: " + bank.totalAsset().currency
        
        totalAssets.append(CGFloat(bank.totalAsset()))
        
        lineChart.clear()
        lineChart.addLine(totalAssets)
    }
    
    public func updateDeposits() {
        // Increase the banks total deposits
        bank.nextQuarter(deposits: bank.depositManager.projections)
    }
    
    
    /**
     * Line chart delegate method.
     */
    public func didSelectDataPoint(_ x: CGFloat, yValues: Array<CGFloat>) {
        //labell.text = "x: \(x)     y: \(yValues)"
    }
    
    
    /**
     * Redraw chart on device rotation.
     */
    override public func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        if let chart = lineChart {
            chart.setNeedsDisplay()
        }
    }
    
    /// States Changed: The new % of amount loaned
    func sliderValueDidChange(sender:UISlider!)
    {
        //print("value--\(Int(sender.value))")
        percLoaned.text = "% Loaned: " + String(Double(sender.value).roundTo(places: 1))
        bank.percentLoaned = Float(Double(sender.value).roundTo(places: 1))
        print(bank.percentLoaned)
    }
    
    func deposit(sender: UIButton!) {
        print("deposit clicked")
        let next = DepositViewController()
        navigationController?.pushViewController(next, animated: true)
    }
    
    func loan(sender: UIButton!) {
        print("loan clicked")
        let next = LoansViewController()
        navigationController?.pushViewController(next, animated: true)
    }
    
    func investment(sender: UIButton!) {
        print("investment clicked")
        let next = InvestmentsViewController()
        navigationController?.pushViewController(next, animated: true)
    }
    
    func nextQuarter() {
        mySlider.maximumValue = 100 - (bank.fed.reserveRequirement * 100) - (bank.depositManager.interest * 100)
        updateStats() // updates all the relevant UI
    }
    //#-end-hidden-code
    func configureBank() {
        //#-editable-code
        print("Configuring the Bank")
        let fed = sharedBank.fed
        fed.setReserveRequirement(newPercentage: 0.1)
        bank.deposit = 10000000
        bank.loanManager.setRiskFactor(risk: 0.05)
        bank.investmentManager.setDiversification(newRatio: 0.2)
        //#-end-editable-code
    }
    //#-hidden-code

}


extension NumberFormatter {
    convenience init(style: Style) {
        self.init()
        numberStyle = style
    }
}

extension Formatter {
    static let currency = NumberFormatter(style: .currency)
    static let currencyUS: NumberFormatter = {
        let formatter = NumberFormatter(style: .currency)
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()
    static let currencyBR: NumberFormatter = {
        let formatter = NumberFormatter(style: .currency)
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter
    }()
}



extension FloatingPoint {
    var currency: String {
        return Formatter.currency.string(for: self) ?? ""
    }
    var currencyUS: String {
        return Formatter.currencyUS.string(for: self) ?? ""
    }
    var currencyBR: String {
        return Formatter.currencyBR.string(for: self) ?? ""
    }
    
}

extension Double {
    /// Rounds the double to decimal places value
    func roundTo(places:Int) -> Double {
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

let master = DashboardViewController()
let nav = UINavigationController(rootViewController: master)

PlaygroundPage.current.liveView = nav
    //#-end-editable-code
//}
