//
//  ViewController.swift
//  System View Controllers
//
//  Created by student19 on 3/21/19.
//  Copyright © 2019 Jose Alvarez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    // method that executes when the share button is pressed
    @IBAction func shareButtonTapped(_ sender: UIButton) {
        
        // set image to current image in UIImageView
        guard let image = imageView.image else {
            return
        }
        
        // initialize activity controller and pass image as an array
        let activityController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = sender // set source view to current screen
        
        // present the activity controller
        present(activityController, animated: true, completion: nil)
        
        
    }
    
    // method that executes when the safari button is pressed
    @IBAction func safariButtonTapped(_ sender: UIButton) {
    }
    
    // method that executes when the photos button is pressed
    @IBAction func photosButtonTapped(_ sender: UIButton) {
    }
    
    // method that executes when the email button is pressed
    @IBAction func emailButtonTapped(_ sender: UIButton) {
    }
    
}

