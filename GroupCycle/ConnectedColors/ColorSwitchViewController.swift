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
    
    let colorService = ColorServiceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colorService.delegate = self
    }

    @IBAction func redTapped(sender: AnyObject) {
//        self.changeColor(UIColor.redColor())
//        colorService.sendColor("red")
        self.statusLabel.text = "red"
    }
    
    @IBAction func yellowTapped(sender: AnyObject) {
//        self.changeColor(UIColor.yellowColor())
//        colorService.sendColor("yellow")
        self.statusLabel.text = "yellow"
    }
    
    @IBAction func greenTapped(sender: AnyObject) {
//        self.changeColor(UIColor.greenColor())
//        colorService.sendColor("green")
        self.statusLabel.text = "green"
    }
    
    // TODO: add method for each button
    // TODO: implemented color changed thing for all devices
    
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
            switch colorString {
            case "red":
                self.changeColor(UIColor.redColor())
            case "yellow":
                self.changeColor(UIColor.yellowColor())
            case "green":
                self.changeColor(UIColor.greenColor())
            default:
                NSLog("%@", "Unknown color value received: \(colorString)")
            }
        }
    }
    
}