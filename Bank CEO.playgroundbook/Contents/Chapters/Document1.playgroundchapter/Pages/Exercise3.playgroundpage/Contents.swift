//#-hidden-code
//
//  Contents.swift
//
//  Copyright (c) 2016 Apple Inc. All Rights Reserved.
//
//#-end-hidden-code
/*:
 In the previous page, a cell with 4 neighbors would die regardless if those neighbors were alive or dead. In this new version, the algorithm checks the number of neighbors in each state (alive, dead, or idle) to determine what happens. Under certain conditions, the algorithm also changes cells to the idle state, resulting in some interesting patterns.
 
 Play with the rules in the algorithm to see what kinds of complex simulations you can create.
 */
//#-hidden-code
//#-code-completion(everything, hide)
//#-code-completion(currentmodule, show)
//#-code-completion(module, show, Swift)
//#-code-completion(module, show, Blink_Sources)
//#-code-completion(identifier, show, if, func, var, let, ., =, <=, >=, <, >, ==, !=, +, -, true, false, &&, ||, !, *, /)
//#-code-completion(identifier, hide, configureCell(cell:), BlinkViewController, viewController, Coordinate, InitialStatePreset, Simulation, Cell, storyBoard)

/*import UIKit
import PlaygroundSupport

let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
let viewController = storyBoard.instantiateInitialViewController() as! BlinkViewController

PlaygroundPage.current.liveView = viewController
//#-end-hidden-code
let simulation = Simulation()
//#-editable-code
simulation.cellDimension = 32

simulation.placePattern(Pattern.pulsar, atColumn: 1, row: 1)

simulation.speed = 2

simulation.set("🌹", forState: .alive)
simulation.set(#colorLiteral(red: 0.6352941176, green: 0.8470588235, blue: 0.7176470588, alpha: 1), forState: .alive)
simulation.set(#imageLiteral(resourceName:"plant.png"), forState: .dead)
simulation.set(#colorLiteral(red: 0.6352941176, green: 0.8470588235, blue: 0.7176470588, alpha: 1), forState: .dead)
simulation.set(#colorLiteral(red: 0.2352941176, green: 0.7215686275, blue: 0.4705882353, alpha: 1), forState: .idle)

simulation.gridLineThickness = 4
simulation.gridColor = #colorLiteral(red: 0.6352941176, green: 0.8470588235, blue: 0.7176470588, alpha: 1)

//#-end-editable-code
func configureCell(cell: Cell) {
    //#-editable-code
    switch cell.state {

    case .alive:
        if cell.numberOfAliveNeighbors > 6 {
            cell.state = .idle
        }
        else if cell.numberOfAliveNeighbors < 2 && cell.numberOfIdleNeighbors > 5 {
            cell.state = .dead
        }
    case .dead:
        if cell.numberOfAliveNeighbors == 3 {
            cell.state = .alive
        }
        else if cell.numberOfIdleNeighbors > 5 {
            cell.state = .idle
        }
    case .idle:
        // Try changing this value to == 1 and see what happens.
        if cell.numberOfIdleNeighbors > 7 {
            cell.state = .alive
        }
        else if cell.numberOfAliveNeighbors > 3 {
            cell.state = .dead
        }
        else if cell.numberOfDeadNeighbors > 3 {
            cell.state = .dead
        }
    }
    //#-end-editable-code
}
//#-hidden-code
simulation.configureCell = configureCell

viewController.simulation = simulation
//#-end-hidden-code
*/

import UIKit
import PlaygroundSupport

// operator overrides allowing us to do arithmetic with `CGPoint`

func + (left: CGPoint, right: CGPoint) -> CGPoint {
    return CGPoint(x: left.x + right.x, y: left.y + right.y)
}

func += (left: inout CGPoint, right: CGPoint) {
    left = left + right
}

func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
    return CGPoint(x: point.x * scalar, y: point.y * scalar)
}

/*:
 A subclass of UIImageView that handles the drawing
 */

class SketchView: UIImageView {
    var path = UIBezierPath()
    var points = [CGPoint]()
    
    init(){
        super.init(frame: CGRect.zero)
        path.lineWidth = 5
        isUserInteractionEnabled = true
        contentMode = .redraw
        backgroundColor = #colorLiteral(red: 0.062745101749897, green: 0.0, blue: 0.192156866192818, alpha: 1.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let pos = touches.first!.location(in: self)
        path.lineCapStyle = .round //by starting with a round line style, the user can draw a dot with a single tap
        path.move(to: pos)
        points.append(pos)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let pos = touches.first!.location(in: self)
        points.append(pos)
        // wait until we have 4 points of a curve, plus the first point of the next curve
        if points.count > 4 {
            // move the end of the path to be between the final control point of tis curve, and the first control point of the next curve. THis smooths the path out:
            points[3] = (points[2] + points[4]) * 0.5
            path.lineCapStyle = .butt
            path.addCurve(to: points[3], controlPoint1: points[1], controlPoint2: points[2]) // add a viewer to the path here
            cacheImage()
            path.removeAllPoints()
            //The next curve's startpoint is this curve's end point
            path.move(to: points[3])
            // remove first 3 points
            points.removeFirst(3)
            setNeedsDisplay()
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        path.addLine(to: touches.first!.location(in: self))
        cacheImage()
        path.removeAllPoints()
        points.removeAll()
        setNeedsDisplay()
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        touchesEnded(touches, with: event)
    }
    
    func cacheImage(retainImage: Bool = true){
        UIGraphicsBeginImageContext(self.frame.size)
        if retainImage {
            // in order to draw on top of the image, we need to draw the existing image in
            image?.draw(in: self.frame)
            // draw the path
            #colorLiteral(red: 0.95686274766922, green: 0.658823549747467, blue: 0.545098066329956, alpha: 1.0).setStroke()
            path.stroke( with: .multiply, alpha: 0.7)
        }
        // and save the image
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
    }
    
    func clearImage(){
        path.removeAllPoints()
        // use the cacheImage function to wipe the image
        cacheImage(retainImage: false)
        setNeedsDisplay()
    }
}

/*:
 A subclass of UIViewController which sets up the navbar and its buttons
 */

class ViewController: UIViewController {
    let mainView = SketchView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //title = "Playground Graffiti"
        view = mainView
       // navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareSheet))
       // navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: mainView, action: #selector(mainView.clearImage))
        
    }
     }

// ViewController is wrapped inside a NavigationViewController to get the nav bar, and space for a couple of buttons
PlaygroundPage.current.liveView = UINavigationController(rootViewController: ViewController())

