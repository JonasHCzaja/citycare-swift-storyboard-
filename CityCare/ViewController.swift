//
//  ViewController.swift
//  CityCare
//
//  Created by Jonas Czaja on 02/09/24.
//

import UIKit
import MapKit

class ViewController: UIViewController {

    var occurrences: [Occurrence] = []
    
    var occurrence: Occurrence?
    
    @IBOutlet weak var lbIssue: UILabel!
    @IBOutlet weak var lbStatus: UILabel!
    @IBOutlet weak var ivIssue: UIImageView!
    @IBOutlet weak var tvDescription: UITextView!
    @IBOutlet weak var lbAddress: UILabel!
    @IBOutlet weak var mvLocation: MKMapView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


    override func viewDidAppear(_ animated: Bool) {
        if let occurrence = occurrence {
            lbIssue.text = occurrence.oc_category
            lbStatus.text = occurrence.oc_status
            ivIssue.image = occurrence.oc_photo as? UIImage
            tvDescription.text = occurrence.oc_description
            lbAddress.text = occurrence.oc_location
           
        if let address = occurrence.oc_location {
                         
                geocodeAddress(address: address) { [weak self] coordinate in
                            
                    guard let coordinate = coordinate else { return }
        
                    self?.showLocationOnMap(coordinate: coordinate, title: occurrence.oc_category)
                    
                          }
                    
            }
                 
        }
             
    }
              
    func geocodeAddress(address: String, completion: @escaping (CLLocationCoordinate2D?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { (placemarks, error) in
            if let error = error {
                print((error.localizedDescription))
                completion(nil)
            } else if let placemark = placemarks?.first, let location = placemark.location {
                completion(location.coordinate)
            } else {
                completion(nil)
            }
        }
        
    }
              
    func showLocationOnMap(coordinate: CLLocationCoordinate2D, title: String?) {
                  
        let annotation = MKPointAnnotation()
                  
        annotation.coordinate = coordinate
                  
        annotation.title = title
                  
                 
        mvLocation.addAnnotation(annotation)
                  
                  
        let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 500, longitudinalMeters: 500)
                  
        mvLocation.setRegion(region, animated: true)
}
}

