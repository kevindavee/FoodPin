//
//  MapViewController.swift
//  FoodPin
//
//  Created by Kevin  Dave on 03/10/17.
//  Copyright © 2017 Kevin Dave. All rights reserved.
//

import UIKit
import MapKit

class MapViewController: UIViewController {
    @IBOutlet var mapView: MKMapView!
    
    var restaurant: RestaurantMO!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(restaurant.location!, completionHandler: { placemarks, error in
            if let error = error {
                print(error)
                return
            }
            
            if let placemarks = placemarks {
                let placemark = placemarks[0]
                let annotation = MKPointAnnotation()
                annotation.title = self.restaurant.name
                annotation.subtitle = self.restaurant.type
                
                if let location = placemark.location {
                    annotation.coordinate = location.coordinate
                    
                    self.mapView.showAnnotations([annotation], animated: true)
                    self.mapView.selectAnnotation(annotation, animated: true)
                }
            }
        })
        
        mapView.delegate = self
        mapView.showsCompass = true
        mapView.showsScale = true
        mapView.showsTraffic = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension MapViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        let identifer = "MyPin"
        
        if annotation.isKind(of: MKUserLocation.self) {
            return nil
        }
        
        var annotationView: MKPinAnnotationView? = mapView.dequeueReusableAnnotationView(withIdentifier: identifer) as? MKPinAnnotationView
        
        if annotationView == nil {
            annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifer)
            annotationView?.canShowCallout = true
        }
        
        let leftIconView = UIImageView(frame: CGRect.init(x: 0, y: 0, width: 53, height: 53))
        if let restaurantImage = restaurant.image {
            leftIconView.image = UIImage(data: restaurantImage as Data)
        }
        annotationView?.leftCalloutAccessoryView = leftIconView
        
        return annotationView
    }
}
