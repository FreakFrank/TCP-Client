//
//  ViewController.swift
//  TCPClient
//
//  Created by Kareem Ismail on 10/19/17.
//  Copyright © 2017 Whatever. All rights reserved.
//

import UIKit
import SwiftSocket

class ViewController: UIViewController {
    let howManyPacketsToSend = 3 //constant for how many packets you wish to send
    var howManyPacketsSent = 0 // counter for how many packets sent
    let delayBetweenPackets = 10.0 // 10 seconds delay between each packet
    let compressionValue = 0.7 //change the compterssion value to get different sizes
    let ipAdress = "192.168.xx.xx" // add your ip address
    @IBOutlet weak var progressLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        sendImageLocally()
    }
    
    func sendImageLocally(){
        if let image = UIImage(named: "IMG_3616"){
            if let imageData = UIImageJPEGRepresentation(image, CGFloat(compressionValue)){
                let client = TCPClient(address: "\(ipAdress)", port: 5000)
                switch client.connect(timeout: 10) {
                case .success:
                    print("Connceted Successfully")
                    progressLabel.text = "Sending packet number \(howManyPacketsSent + 1)"
                    let result = client.send(data: imageData)
                case .failure(let error):
                    print("Didn't Connect")
                }
            }
        }
        howManyPacketsSent += 1
        if howManyPacketsSent < howManyPacketsToSend {
            DispatchQueue.main.asyncAfter(deadline: .now() + self.delayBetweenPackets, execute: {
                self.sendImageLocally()
            })
        }
        else {
            progressLabel.text = "All Packets sent Successfully"
        }
    }
    
    
    
}

