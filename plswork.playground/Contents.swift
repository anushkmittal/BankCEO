import UIKit
import PlaygroundSupport

let view = UIView(frame: CGRect(x: 0, y: 0, width: 500, height: 500))
view.backgroundColor = UIColor.white

var animator: UIDynamicAnimator = UIDynamicAnimator(referenceView: view)

PlaygroundPage.current.liveView = view

let square = UIView(frame: CGRect(x: 175, y: 0, width: 150, height: 150))
square.backgroundColor = UIColor.red
view.addSubview(square)

let gravity = UIGravityBehavior(items: [square])
animator.addBehavior(gravity)

let collision = UICollisionBehavior(items: [square])
animator.addBehavior(collision)

collision.translatesReferenceBoundsIntoBoundary = true