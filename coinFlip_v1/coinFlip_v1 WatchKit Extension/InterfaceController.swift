//
//  InterfaceController.swift
//  coinFlip_v1 WatchKit Extension
//
//  Created by SUSAN BUSSE KERSTING on 9/27/20.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    
    @IBOutlet weak var flipLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        // Configure interface objects here.
    }
    
    
    @IBAction func flipLabelPressed() {
        
        flipLabel.setText("Flipping the coin.")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            
            self.flipLabel.setText("Flipping the coin..")
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.flipLabel.setText("Flipping the coin...")
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    
                    let randomFlip = Bool.random()
                    
                    if (randomFlip) { // If True
                        
                        self.flipLabel.setText("It's Heads")
                    } else { // If False
                        
                        self.flipLabel.setText("It's Tails")
                        
                    }
                }
            }
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
    }

}
