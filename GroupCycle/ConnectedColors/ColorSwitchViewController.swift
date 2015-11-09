//
//  ViewController.swift
//  ConnectedColors
//
//  Created by Ralf Ebert on 28/04/15.
//  Copyright (c) 2015 Ralf Ebert. All rights reserved.
//

import UIKit

class ColorSwitchViewController: UIViewController {

    @IBOutlet weak var connectionsLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    
    let colorService = ColorServiceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorService.delegate = self
    }
    
    // action functions which respond to button presses
    @IBAction func cautionAhead(sender: AnyObject) {
        let status_update = "Caution Ahead"
        self.statusLabel.text = status_update
        self.statusImage.image = UIImage(named: "Caution Ahead")
        colorService.sendColor(status_update)
    }
    
    @IBAction func dangerBehind(sender: AnyObject) {
        let status_update = "Danger Behind"
        self.statusLabel.text = status_update
        self.statusImage.image = UIImage(named: "Danger Behind")
        colorService.sendColor(status_update)
    }
    
    @IBAction func turnLeft(sender: AnyObject) {
        let status_update = "Turn Left"
        self.statusLabel.text = status_update
        self.statusImage.image = UIImage(named: "Turn Left")
        colorService.sendColor(status_update)
    }
    
    @IBAction func TurnRight(sender: AnyObject) {
        let status_update = "Turn Right"
        self.statusLabel.text = status_update
        self.statusImage.image = UIImage(named: "Turn Right")
        colorService.sendColor(status_update)
    }
    
    @IBAction func happyFace(sender: AnyObject) {
        let status_update = "Happy Face"
        self.statusLabel.text = status_update
        self.statusImage.image = UIImage(named: "Happy Face")
        colorService.sendColor(status_update)
    }
    @IBAction func sadFace(sender: AnyObject) {
        let status_update = "Sad Face"
        self.statusLabel.text = status_update
        self.statusImage.image = UIImage(named: "Sad Face")
        colorService.sendColor(status_update)
    }
    
    func changeColor(color : UIColor) {
        UIView.animateWithDuration(0.2) {
            self.view.backgroundColor = color
        }
    }
    
}

extension ColorSwitchViewController : ColorServiceManagerDelegate {
    
    func connectedDevicesChanged(manager: ColorServiceManager, connectedDevices: [String]) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            self.connectionsLabel.text = "Connections: \(connectedDevices)"
        }
    }
    
    func colorChanged(manager: ColorServiceManager, colorString: String) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            self.statusImage.image = UIImage(named: colorString)
            self.statusLabel.text = colorString
            NSLog("Received \(colorString)")
        }
    }
    
}