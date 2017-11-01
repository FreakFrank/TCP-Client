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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let image = UIImage(named: "IMG_3616"){
            if let imageData = UIImageJPEGRepresentation(image, 1){
                let client = TCPClient(address: "192.168.1.23", port: 5000)
                switch client.connect(timeout: 10) {
                case .success:
                    print("Connceted Successfully")
                    let result = client.send(data: imageData)
                case .failure(let error):
                    print("Didn't Connect")
                }
            }
        }
        
    }
    
    
    
}

