//
//  Created by Nicholas Mahlangu, Lexie Schachne,
//  and Oriana Wang for CS 144r.
//

import UIKit

class DataSwitchViewController: UIViewController {

    @IBOutlet weak var connectionsLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var statusImage: UIImageView!
    var statusUpdates: [String] = []
    
    let dataService = DataServiceManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataService.delegate = self
    }
    
    // create a timestamp
    func getTimestamp() -> String{
        let timestamp = NSDateFormatter.localizedStringFromDate(NSDate(), dateStyle: .MediumStyle, timeStyle: .MediumStyle)
        return timestamp
    }
    
    // action functions which respond to button presses
    @IBAction func cautionAhead(sender: AnyObject) {
        // update local UI
        var status_update = "Caution Ahead"
        self.statusLabel.text = "You sent \(status_update)"
        self.statusImage.image = UIImage(named: "Caution Ahead")
        
        // create unique message and store it
        status_update += " - " + getTimestamp()
        self.statusUpdates.append(status_update)
        
        // send message to others
        dataService.sendData(status_update)
    }
    
    @IBAction func dangerBehind(sender: AnyObject) {
        // update local UI
        var status_update = "Danger Behind"
        self.statusLabel.text = "You sent \(status_update)"
        self.statusImage.image = UIImage(named: "Danger Behind")
        
        // create unique message and store it
        status_update += " - " + getTimestamp()
        self.statusUpdates.append(status_update)
        
        // send message to others
        dataService.sendData(status_update)
    }
    
    @IBAction func turnLeft(sender: AnyObject) {
        // update local UI
        var status_update = "Turn Left"
        self.statusLabel.text = "You sent \(status_update)"
        self.statusImage.image = UIImage(named: "Turn Left")
        
        // create unique message and store it
        status_update += " - " + getTimestamp()
        self.statusUpdates.append(status_update)
        
        // send message to others
        dataService.sendData(status_update)
    }
    
    @IBAction func TurnRight(sender: AnyObject) {
        // update local UI
        var status_update = "Turn Right"
        self.statusLabel.text = "You sent \(status_update)"
        self.statusImage.image = UIImage(named: "Turn Right")
        
        // create unique message and store it
        status_update += " - " + getTimestamp()
        self.statusUpdates.append(status_update)
        
        // send message to others
        dataService.sendData(status_update)
    }
    
    @IBAction func happyFace(sender: AnyObject) {
        // update local UI
        var status_update = "Happy Face"
        self.statusLabel.text = "You sent \(status_update)"
        self.statusImage.image = UIImage(named: "Happy Face")
        
        // create unique message and store it
        status_update += " - " + getTimestamp()
        self.statusUpdates.append(status_update)
        
        // send message to others
        dataService.sendData(status_update)
    }
    @IBAction func sadFace(sender: AnyObject) {
        // update local UI
        var status_update = "Sad Face"
        self.statusLabel.text = "You sent \(status_update)"
        self.statusImage.image = UIImage(named: "Sad Face")
        
        // create unique message and store it
        status_update += " - " + getTimestamp()
        self.statusUpdates.append(status_update)
        
        // send message to others
        dataService.sendData(status_update)
    }
    
    func changeData(data : UIColor) {
        UIView.animateWithDuration(0.2) {
            self.view.backgroundColor = data
        }
    }
    
}

extension DataSwitchViewController : DataServiceManagerDelegate {
    
    // number of connected devices changed
    func connectedDevicesChanged(manager: DataServiceManager, connectedDevices: [String]) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            if (connectedDevices.count < 1){
                self.connectionsLabel.text = "Awaiting connection..."
            }
            else {
                self.connectionsLabel.text = "Connections: \(connectedDevices.count)"
            }
        }
    }
    
    // received data from another device
    func dataChanged(manager: DataServiceManager, dataString: String) {
        NSOperationQueue.mainQueue().addOperationWithBlock { () -> Void in
            // only do stuff is string is in our dictionary
            if !self.statusUpdates.contains(dataString) {
                // store the new string
                self.statusUpdates.append(dataString)
                
                // split the string into parts
                var string_parts = dataString.componentsSeparatedByString("-")
                let data_update = String(string_parts[0].characters.dropLast())
                
                // update the UI
                self.statusImage.image = UIImage(named: data_update)
                self.statusLabel.text = "Received \(data_update)"
                
                // send the data to all other connected peers
                manager.sendData(dataString)
            }
        }
    }
    
}