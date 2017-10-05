//
//  AddRestaurantController.swift
//  FoodPin
//
//  Created by Kevin  Dave on 03/10/17.
//  Copyright © 2017 Kevin Dave. All rights reserved.
//

import UIKit
import CoreData

class AddRestaurantController: UITableViewController {
    @IBOutlet var photoImageView: UIImageView!
    @IBOutlet var nameTextField: UITextField!
    @IBOutlet var typeTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var phoneTextField: UITextField!
    @IBOutlet var yesButton: UIButton!
    @IBOutlet var noButton: UIButton!
    
    var isVisited: Bool = false
    var restaurant: RestaurantMO!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.allowsEditing = false
                imagePicker.sourceType = .photoLibrary
                
                present(imagePicker, animated: true, completion: nil)
            }
            
            let leadingConstraint = NSLayoutConstraint(item: photoImageView, attribute: NSLayoutAttribute.leading, relatedBy: NSLayoutRelation.equal, toItem: photoImageView.superview, attribute: NSLayoutAttribute.leading, multiplier: 1, constant: 0)
            leadingConstraint.isActive = true
            
            let trailingConstraint = NSLayoutConstraint(item: photoImageView, attribute: NSLayoutAttribute.trailing, relatedBy: NSLayoutRelation.equal, toItem: photoImageView.superview, attribute: NSLayoutAttribute.trailing, multiplier: 1, constant: 0)
            trailingConstraint.isActive = true
            
            let topConstraint = NSLayoutConstraint(item: photoImageView, attribute: NSLayoutAttribute.top, relatedBy: NSLayoutRelation.equal, toItem: photoImageView.superview, attribute: NSLayoutAttribute.top, multiplier: 1, constant: 0)
            topConstraint.isActive = true
            
            let bottomConstraint = NSLayoutConstraint(item: photoImageView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: photoImageView.superview, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
            bottomConstraint.isActive = true
        }
    }
    
    @IBAction func saveRestaurant(segue: UIStoryboardSegue) {
        if !(nameTextField.text?.isEmpty)!, !(locationTextField.text?.isEmpty)!, !(typeTextField.text?.isEmpty)!, !(phoneTextField.text?.isEmpty)! {
            if let appDelegate = (UIApplication.shared.delegate as? AppDelegate) {
                restaurant = RestaurantMO(context: appDelegate.persistentContainer.viewContext)
                restaurant.name = nameTextField.text
                restaurant.type = typeTextField.text
                restaurant.location = locationTextField.text
                restaurant.phone = phoneTextField.text
                restaurant.isVisited = isVisited
                
                if let restaurantImage = photoImageView.image {
                    if let imageData = UIImagePNGRepresentation(restaurantImage) {
                        restaurant.image = NSData(data: imageData) as Data
                    }
                }
                
                appDelegate.saveContext()
            }
            dismiss(animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: "Oops", message: "We can't proceed because one of the fields is blank. Please note that all fields are required.", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alertController.addAction(action)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func toggleBeenHereButton(sender: UIButton) {
        if sender == yesButton {
            isVisited = true
            yesButton.backgroundColor = UIColor.red
            noButton.backgroundColor = UIColor.gray
        } else if sender == noButton {
            isVisited = false
            yesButton.backgroundColor = UIColor.gray
            noButton.backgroundColor = UIColor.red
        }
    }
}

extension AddRestaurantController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            photoImageView.image = selectedImage
            photoImageView.contentMode = .scaleAspectFill
            photoImageView.clipsToBounds = true
        }
        
        dismiss(animated: true, completion: nil)
    }
}

extension AddRestaurantController: UINavigationControllerDelegate {
    
}
