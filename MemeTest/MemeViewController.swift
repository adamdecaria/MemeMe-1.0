//
//  MemeViewController.swift
//  MemeTest
//
//  Created by Adam DeCaria on 2016-10-08.
//  Copyright © 2016 Adam DeCaria. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
        
    //MARK: outlets to storyboard
    
    // Outlet to display image selected by user
    @IBOutlet weak var chosenImage: UIImageView!
    // Outlet to the cameraButton
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    // Outlet to the top textField
    @IBOutlet weak var textFieldTop: UITextField!
    // Outlet to the bottom textField
    @IBOutlet weak var textFieldBottom: UITextField!
    // Outlet to the nav bar
    @IBOutlet weak var navigationBar: UINavigationBar!
    // Outlet to the activity button on the nav bar
    @IBOutlet weak var activityButton: UIBarButtonItem!
    // Outlet to the button bar on the bottom of the screen
    @IBOutlet weak var bottomBar: UIToolbar!
        
    // MARK: store the memed image here
    var memedPic: UIImage!
    
    // MARK: determine if the UIImage is visible to the user (used for cancel button)
    var imageIsVisible: Bool = true
        
    // MARK: check if an image has been chosen, in order to turn on the "share" activity button
    var picChosen: Bool = false
        
    // MARK: create the "impact" like font
    let memeTextAtributes = [NSStrokeColorAttributeName: UIColor.black, NSForegroundColorAttributeName: UIColor.white, NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!, NSStrokeWidthAttributeName: -3.0] as [String : Any]
        
    var memeSaveInStruct: Meme!

    // MARK: load the view and call the prepareTextField function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareTextField(textField: textFieldTop, defaultText: "TOP")
        prepareTextField(textField: textFieldBottom, defaultText: "BOTTOM")
            
      // Do any additional setup after loading the view, typically from a nib.
    } // End viewDidLoad
    
    // MARK: prepare the textFields for display
    func prepareTextField(textField: UITextField, defaultText: String) {
        
        textField.text = defaultText
        textField.delegate = self
        textField.defaultTextAttributes = memeTextAtributes
        textField.textAlignment = NSTextAlignment.center
        
    } // End prepareTextField
    
    // MARK: check that the camera is enabled on the device, otherwise dim the camera button; as well check if user has chosen a pic to enable the share button
    override func viewWillAppear(_ animated: Bool) {
            
        super.viewWillAppear(animated)
        
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)
        
        if picChosen {
            activityButton.isEnabled = true
        } else {
            activityButton.isEnabled = false
        }
            
        subscribeToKeyboardNotifications()
        self.tabBarController?.tabBar.isHidden = true
            
    } // End viewWillAppear
        
    override func viewWillDisappear(_ animated: Bool) {
            
        super.viewWillDisappear(animated)
        unsubscribeFromKeyboardNotifications()
        self.tabBarController?.tabBar.isHidden = false
            
    } // End viewWillDissapear
    
    // MARK: allow the user to choose and image and bring it back to the first view controller to be memed
   func chooseImageFromSource(source: UIImagePickerControllerSourceType) {
        
        if chosenImage.isHidden == true {
            chosenImage.isHidden = false
        }
        
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(imagePicker, animated: true, completion: nil)
            
        picChosen = true
            
    } // End chooseImage
        
    // MARK: Launch the imagePickerController for the user to select an image to meme
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
            
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            chosenImage.image = image
        }
            
        picker.dismiss(animated: true, completion: nil)
            
    } // End imagePickerController
        
    // MARK: pass the user selection (camera or photoLibrary) to chooseImageFromSource to take a new picture/select existing to meme
    @IBAction func getPicture(_ sender: AnyObject) {
        
        if sender as! NSObject == cameraButton {
            chooseImageFromSource(source: UIImagePickerControllerSourceType.camera)
        } else {
            chooseImageFromSource(source: UIImagePickerControllerSourceType.photoLibrary)
        }
        
    } // End takePicture
        
    // MARK: clear the textField when the user puts focus on it to type their meme text
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
        if textField.text == "TOP" || textField.text == "BOTTOM" {
            textField.text = ""
        }
            
    } // End textFieldDidBeginEditing
        
    // MARK: ensure the keyboard dissapears
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            
        if textField == textFieldTop {
            return textFieldTop.resignFirstResponder()
        } else {
            return textFieldBottom.resignFirstResponder()
        }
            
    } // End textFieldShouldReturn
        
    // MARK: add observers to listen for keyboard notifications - keyboardWillShow and keyboardWillHide
    func subscribeToKeyboardNotifications() {
            
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
            
    } // End subscribteToKeyboardNotifications
        
    // MARK: stop any active observers when viewWilldissapear
    func unsubscribeFromKeyboardNotifications() {
            
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
    } // End unsubscribeFromKeyboardNotifications
        
    // MARK: move the image displayed in the UIImageView up to adjust for displaying the keyboard
    func keyboardWillShow(notification: NSNotification) {
            
        if textFieldBottom.isFirstResponder {
            view.frame.origin.y = getKeyboardHeight(notification: notification) * (-1)
        }
            
    } // End keyboardWillShow
        
    // MARK: get the size of the keyboard to use in keyboardWillShow to calculate how far to adjust the image y coordinate
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
            
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.cgRectValue.height
            
    } // End getKeyboardHeight
        
    // MARK: after the user leaves focus on textFieldBottom, move the image y coordinate back to its proper position
    func keyboardWillHide(notification: NSNotification) {
            
        if textFieldBottom.isFirstResponder {
            view.frame.origin.y = 0
        }
            
    } // End keyboardWillHide
        
    // save the memed image, its text and the original image in the Meme struct
    func saveMeme() {
        memeSaveInStruct = Meme(topText: textFieldTop.text!, bottomText: textFieldBottom.text!, originalImage: chosenImage.image!, memedImage: memedPic)
        
        // Add it to the memes array in the Application Delegate
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        appDelegate.memes.append(memeSaveInStruct)
        print(appDelegate.memes.count)
        
    } // End saveMeme
    
    // MARK: create a "meme" by hidding the nav and bottom bar, then screenshotting
    func generateMemedImage() -> UIImage {
            
        navigationBar.isHidden = true
        bottomBar.isHidden = true
            
        // Render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
            
        navigationBar.isHidden = false
        bottomBar.isHidden = false
        
        return memedImage
            
    } // End generateMemedImage
        
    // MARK: present the activityViewController to share the Meme, then save the meme in the struct provided aboveac
    @IBAction func activityButton(_ sender: AnyObject) {
        
        memedPic = generateMemedImage()
        let activityViewController = UIActivityViewController(activityItems: [self.memedPic], applicationActivities: nil)
            
        activityViewController.completionWithItemsHandler = {
            activity, completed, items, error in
                
            if completed {
                self.saveMeme()
                self.dismiss(animated: true, completion: nil)
            }
        }
        self.present(activityViewController, animated: true, completion: nil)
            
    } // End activityButton
   
    // MARK: Hide the image selected by the user so the screen is blank and reset the textField text
    @IBAction func cancelButton(_ sender: AnyObject) {
      
        if chosenImage.isHidden == false {
            chosenImage.isHidden = true
        }
        
        textFieldTop.text = "TOP"
        textFieldBottom.text = "BOTTOM"

    }
    
    override var prefersStatusBarHidden: Bool {
        
        get {
            return true
        }
    }
        
        
} // End ViewController




