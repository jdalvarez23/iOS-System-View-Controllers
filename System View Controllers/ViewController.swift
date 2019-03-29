//
//  ViewController.swift
//  System View Controllers
//
//  Created by student19 on 3/21/19.
//  Copyright © 2019 Jose Alvarez. All rights reserved.
//

import UIKit
import SafariServices // import Safari Services
import MessageUI // import Message UI framework (provides interface for sending email/texts)

/* To access the device's camera or photo library, we must adopt two protocols:
 UIImagePickerControllerDelegate: will transfer the selected image's information back into your app
 UINavigationControllerDelegate: will handle the responsibility for dismissing the image picker view
 */

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, MFMailComposeViewControllerDelegate {
    
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
        
        // 1. Create a URL from a string
        if let url = URL(string: "https://www.starwars.com/") {
            
            // 2. Create an instance of SFSafariViewController
            let safariViewController = SFSafariViewController(url: url)
            
            // 2.1 Set the view controller to appear as a modal
            safariViewController.modalPresentationStyle = .popover
            
            // 3. Present Safari view controller to user
            present(safariViewController, animated: true, completion: nil)
            
        }
        
    }
    
    // method that executes when the photos button is pressed
    @IBAction func photosButtonTapped(_ sender: UIButton) {
        
        let imagePicker = UIImagePickerController() // initialize instance of UIImagePickerController
        imagePicker.delegate = self // set current view controller as delegate
        
        // initialize alert controller and set title, message, and preferred style
        let alertController = UIAlertController(title: "Choose Image Source", message: nil, preferredStyle: .actionSheet)
        
        // initialize cancel action button for alert controller
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        
        // add actions to alert controller
        alertController.addAction(cancelAction)
        
        // execute only if camera source is available in current device
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            
            // initialize camera action button for alert controller
            let cameraAction = UIAlertAction(title: "Camera", style: .default, handler: { action in
                // execute code when this button is selected
                print("User selected camera action")
                imagePicker.sourceType = .camera // select camera app as the source type of image picker
                self.present(imagePicker, animated: true, completion: nil) // present camera app
                
            })
            alertController.addAction(cameraAction) // add camera action to alert controller
        }
        
        // execute only if photo library source is available in current device
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
            
            // initialize photo library action button for alert controller
            let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default, handler: { action in
                // execute code when this button is selected
                print("User selected photo library action")
                imagePicker.sourceType = .photoLibrary // select photo library app as the source type of image picker
                self.present(imagePicker, animated: true, completion: nil) // present photo library app
            })
            alertController.addAction(photoLibraryAction)
        }
    
        
        // set source view of popover presentation to current view controller
        alertController.popoverPresentationController?.sourceView = sender
        
        // display alert controller
        present(alertController, animated: true, completion: nil)
        
        
    }
    
    // method that executes when the email button is pressed
    @IBAction func emailButtonTapped(_ sender: UIButton) {
        
        // execute only if device is capable of sending emails
        if !MFMailComposeViewController.canSendMail() {
            
            print("This device cannot send mail!")
            
            return
            
        }
        
        let mailComposer = MFMailComposeViewController() // initialize instance of MFMailComposeViewController
        
        mailComposer.mailComposeDelegate = self // set current view controller as delegate
        
        // configure parts of email
        mailComposer.setToRecipients(["example@example.com"]) // set value to recipients array
        mailComposer.setSubject("This is test") // set value to subject of email
        mailComposer.setMessageBody("Hello, this is an email from the app I made.", isHTML: false) // set value to message body of email [isHTML determines if message body is to be rendered as HTML]
        
        present(mailComposer, animated: true, completion: nil) // present mail composer
        
    }
    
    // method that tells the delegate that the user has picked a photo (or other media) and includes the photo in the info dictionary
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        // execute if selected image exists
        if let selectedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            imageView.image = selectedImage // set image value to selected image
            
            dismiss(animated: true, completion: nil) // dismiss the image picker
            
        }
        
    }
    
    // method that dismisses the mail compose view controller and returns to the app
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        dismiss(animated: true, completion: nil) // dismiss the mail composer
        
    }
    
    
    
}

