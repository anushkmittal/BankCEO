//#-hidden-code
//
//  Contents.swift
//
//  Copyright (c) 2016 Apple Inc. All Rights Reserved.
//
//#-end-hidden-code
/*:
 **Goal:** Modify the code below to create your own set of rules for the cell simulator.

 To get started, run the code and observe what happens when you tap the live view to add living cells. The live view is initially filled with idle cells, but as the simulation runs these change to living or dead cells depending on the rules.
 
 Try modifying the rules of the simulation in the configureCell function. Experiment with different values to see what happens.
 
 When you're ready, move on to the next page to explore a more complex set of rules for the cell simulator.
 */

//#-editable-code

import PlaygroundSupport
import Foundation
import UIKit

public class LoansViewController : UIViewController {
    
    var label03 = UILabel()
    let pickerData = PickerData()
    let pickerView = UIPickerView()
    
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
        let label01 = UILabel()
        label01.text = "CURRENT LOANS: "
        label01.textColor = UIColor.white
        label01.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBlack)
        label01.textAlignment = .left
        
        //set up label 02
        let label02 = UILabel()
        label02.text = "PROJECTED LOANS: "
        label02.textColor = UIColor.white
        label02.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBlack)
        label02.textAlignment = .left
        
        //set up label 03
        label03 = UILabel()
        label03.text = "INTEREST RATE: "
        label03.textColor = UIColor.white
        label03.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBlack)
        label03.textAlignment = .left
        
        //set up label 04
        let label04 = UILabel()
        label04.text = "INTEREST EARNED: "
        label04.textColor = UIColor.white
        label04.font = UIFont.systemFont(ofSize: 20, weight: UIFontWeightBlack)
        label04.textAlignment = .left
        
        // stack
        let stackView00 = UIStackView(arrangedSubviews: [label01, label02, label03, label04])
        stackView00.axis = .vertical
        stackView00.spacing = 20
        stackView00.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView00)
        
        /**End labels stuff*/
        
        view.addSubview(pickerView)
        
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
            
            stackView00.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stackView00.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stackView00.topAnchor.constraint(equalTo: view.topAnchor, constant: 65),
            
            pickerView.widthAnchor.constraint(equalTo: view.widthAnchor)
            
            ])
        
        self.view = view
    }
    
    public override func viewDidLoad() {
        pickerView.backgroundColor = .black
        pickerView.dataSource = pickerData
        pickerView.delegate = pickerData
        pickerView.reloadAllComponents()
    }
    
}

class PickerData : NSObject, UIPickerViewDataSource, UIPickerViewDelegate {
    let fruits = ["Apple", "Orange", "Banana"]
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return fruits.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return fruits[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print(component)
    }
}

PlaygroundPage.current.liveView = LoansViewController()

//#-end-editable-code

