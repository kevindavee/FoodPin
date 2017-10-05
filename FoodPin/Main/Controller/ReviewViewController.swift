//
//  ReviewViewController.swift
//  FoodPin
//
//  Created by Kevin  Dave on 02/10/17.
//  Copyright © 2017 Kevin Dave. All rights reserved.
//

import UIKit

class ReviewViewController: UIViewController {
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var containerImageView: UIImageView!
    @IBOutlet var containerView: UIView!
    @IBOutlet var closeButton: UIButton!
    
    var restaurant: RestaurantMO?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let restaurant = restaurant, let restaurantImage = restaurant.image {
            backgroundImageView.image = UIImage(data: restaurantImage as Data)
            containerImageView.image = UIImage(data: restaurantImage as Data)
        }

        // Do any additional setup after loading the view.
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        backgroundImageView.addSubview(blurEffectView)
        
        let scaleTransform = CGAffineTransform.init(scaleX: 0, y: 0)
        let translateTransform = CGAffineTransform.init(translationX: 0, y: -1000)
        let combineTransform = scaleTransform.concatenating(translateTransform)
        containerView.transform = combineTransform
        
        let closeButtonTransform = CGAffineTransform.init(translationX: 3000, y: 0)
        closeButton.transform = closeButtonTransform
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIView.animate(withDuration: 0.5, animations: {
            self.containerView.transform = CGAffineTransform.identity
            UIView.animate(withDuration: 0.5, animations: {
                self.closeButton.transform = CGAffineTransform.identity
            })
        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
