//#-hidden-code
//
//  Contents.swift
//
//  Copyright (c) 2017 Anushk Mittal. All Rights Reserved.
//
//#-end-hidden-code
/*:
 # Blink: A Cell Simulator
 Blink is a simulation that explores how a living cell reproduces or dies given a certain set of rules. Your goal is to understand the algorithms that run the simulation so that you can create your own version, with your own rules.
 
 This playground is running a modified version of [Conway's Game of Life](https://en.wikipedia.org/wiki/Conway%27s_Game_of_Life), which presents cells reproducing and dying based upon the status of the 8 neighboring cells. You will see this simulation in the **live view** when you run the code.
 
 The rules for this simulation are:
 * Any living cell with fewer than two living neighbors dies.
 * Any living cell with two or three living neighbors lives on.
 * Any living cell with more than three living neighbors dies.
 * Any dead cell with exactly three living neighbors becomes a living cell.
 
 The cell simulator uses a loop to evaluate all cells on the grid. For each iteration of the loop, the rules are applied and a new generation of cells is created. Experiment with stepping through the simulation to watch this happen. On the next page, you'll explore modifying this algorithm.
 */
//#-editable-code
import UIKit
import PlaygroundSupport

class ImageViewController : UIViewController, LineChartDelegate {
    
    
    var labell = UILabel()
    var lineChart: LineChart!
    
    override func loadView() {
        
        // UI
        let view = UIView()
        view.backgroundColor = .white
        let image = UIImage(named: "bg.jpg")
        let imageView = UIImageView(image: image)
        view.addSubview(imageView)
        
        /*New Stuff related to labels buttons */
        
        //set up label 1
        let label1 = UILabel()
        label1.text = "DEPOSITS"
        label1.textColor = UIColor.white
        label1.textAlignment = .center
        label1.font = UIFont.boldSystemFont(ofSize: 17)
        
        //set up button 1
        let image1 = UIImage(named: "deposits.png")
        let button1 = UIButton(type: UIButtonType.custom)
        button1.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
        button1.setImage(image1, for: .normal)
        button1.addTarget(self, action: Selector(("btnTouched1:")), for:.touchUpInside)
        
        // stack 1
        let stackView = UIStackView(arrangedSubviews: [label1, button1])
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
        button2.addTarget(self, action: Selector(("btnTouched2:")), for:.touchUpInside)
        
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
        button3.addTarget(self, action: Selector(("btnTouched3:")), for:.touchUpInside)
        
        // stack 3
        let stackView3 = UIStackView(arrangedSubviews: [label3, button3])
        stackView3.axis = .vertical
        stackView3.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView3)
        
        /**End new stuff*/
        
        
        /**Adding stuff related to labels*/
        
        //set up label 01
        let label01 = UILabel()
        label01.text = "Deposits: "
        label01.textColor = UIColor.white
        label01.font = UIFont.systemFont(ofSize: 30, weight: UIFontWeightBlack)
        label01.textAlignment = .left
        
        //set up label 02
        let label02 = UILabel()
        label02.text = "Loans: "
        label02.textColor = UIColor.white
        label02.font = UIFont.systemFont(ofSize: 30, weight: UIFontWeightBlack)
        label02.textAlignment = .left
        
        
        //set up label 03
        let label03 = UILabel()
        label03.text = "Investments: "
        label03.textColor = UIColor.white
        label03.font = UIFont.systemFont(ofSize: 30, weight: UIFontWeightBlack)
        label03.textAlignment = .left
        
        
        //set up label 04
        let label04 = UILabel()
        label04.text = "NET: "
        label04.textColor = UIColor.white
        label04.font = UIFont.systemFont(ofSize: 30, weight: UIFontWeightBlack)
        label04.textAlignment = .left
        
        //set up label 004
        let label004 = UILabel()
        label004.text = "Total Assets: "
        label004.textColor = UIColor.white
        label004.font = UIFont.systemFont(ofSize: 30, weight: UIFontWeightBlack)
        label004.textAlignment = .left
        
        //set up label 05
        let label05 = UILabel()
        label05.text = "% Loaned: "
        label05.textColor = UIColor.white
        label05.font = UIFont.systemFont(ofSize: 30, weight: UIFontWeightBlack)
        label05.textAlignment = .left
        
        // stack
        let stackView00 = UIStackView(arrangedSubviews: [label01, label02, label03, label04, label004, label05])
        stackView00.axis = .vertical
        stackView00.spacing = 20
        stackView00.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView00)
        
        /**End labels stuff*/
        
        // Slider stuff
        let mySlider = UISlider(frame:CGRect(x: 10, y: 100, width: 300, height: 20))
        mySlider.minimumValue = 0
        mySlider.maximumValue = 100
        mySlider.isContinuous = true
        mySlider.tintColor = UIColor.blue
        mySlider.translatesAutoresizingMaskIntoConstraints = false
        mySlider.addTarget(self, action: Selector(("btnTouched3:")), for: .valueChanged)
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
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[labell]-[chart(==320)]", options: [], metrics: nil, views: views))
        
        
        
        
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
            label1.widthAnchor.constraint(equalTo: stackView.widthAnchor),
            label1.heightAnchor.constraint(equalTo: stackView.heightAnchor, multiplier: 0.3),
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
            mySlider.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 90),
            mySlider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            // mySlider.widthAnchor.constraint(equalTo: stackViewLast.widthAnchor),
            //  labelLast.widthAnchor.constraint(equalTo: stackViewLast.widthAnchor),
            
            //graph
            lineChart.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lineChart.topAnchor.constraint(equalTo: view.topAnchor, constant: 65),
            lineChart.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.21),
            
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
    
    
    /**
     * Line chart delegate method.
     */
    func didSelectDataPoint(_ x: CGFloat, yValues: Array<CGFloat>) {
        //labell.text = "x: \(x)     y: \(yValues)"
    }
    
    
    /**
     * Redraw chart on device rotation.
     */
    override func didRotate(from fromInterfaceOrientation: UIInterfaceOrientation) {
        if let chart = lineChart {
            chart.setNeedsDisplay()
        }
    }
    
    
}

PlaygroundPage.current.liveView = ImageViewController()


//#-end-editable-code
