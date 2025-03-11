//
//  MapViewController.swift
//  CityCare
//
//  Created by Jonas Czaja on 02/09/24.
//

import UIKit
import MapKit
import CoreData

class MapViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager = CLLocationManager()
    var occurrences: [Occurrence] = []
    var selectedOccurrence: Occurrence?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.showsUserLocation = true
        
        mapView.userTrackingMode = .follow
        
        mapView.delegate = self
        
        requestAuthorization()
        loadOccurrences()
        addOccurrencesToMap()
    }
    
    func requestAuthorization() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        locationManager.requestWhenInUseAuthorization()
    }
    
    func loadOccurrences() {
            // Assuming you're using CoreData
            let fetchRequest: NSFetchRequest<Occurrence> = Occurrence.fetchRequest()
            
            do {
                occurrences = try context.fetch(fetchRequest)
            } catch {
                print((error.localizedDescription))
            }
        }
        
    func addOccurrencesToMap() {
           for occurrence in occurrences {
               guard let address = occurrence.oc_location else { continue }
               geocodeAddress(address: address) { [weak self] coordinate in
                   guard let coordinate = coordinate else { return }
                   
                   let annotation = MKPointAnnotation()
                   annotation.coordinate = coordinate
                   annotation.title = occurrence.oc_category
                   annotation.subtitle = occurrence.oc_description
                   
                   self?.mapView.addAnnotation(annotation)
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
    
    func showRoute(to destination: CLLocationCoordinate2D) {
        let request = MKDirections.Request()
        
        request.source = MKMapItem(placemark: MKPlacemark(coordinate: mapView.userLocation.coordinate))
        request.destination = MKMapItem(placemark: MKPlacemark(coordinate: destination))
        
        let directions = MKDirections(request: request)
        directions.calculate{ (response, error) in
            if error == nil {
                guard let response = response, let route = response.routes.first else {return}
                
                print("nome: ", route.name, "- distancia: ", route.distance, "- duracao:", route.expectedTravelTime)
                
                for step in route.steps {
                    print("Em", step.distance, "metros, ", step.instructions)
                }
                
                self.mapView.removeOverlays(self.mapView.overlays)
                
                self.mapView.addOverlays([route.polyline], level: .aboveRoads)
            }
        }
    }
    
    @IBAction func searchButton(_ sender: Any) {
        textField.resignFirstResponder()
        
        guard let query = textField.text, !query.isEmpty else { return }
        
        mapView.removeAnnotations(mapView.annotations)
        
        let filteredOccurrences = occurrences.filter { occurrence in
            return occurrence.oc_category?.localizedCaseInsensitiveContains(query) == true ||
                   occurrence.oc_location?.localizedCaseInsensitiveContains(query) == true ||
                   occurrence.oc_description?.localizedCaseInsensitiveContains(query) == true
        }
        
        for occurrence in filteredOccurrences {
            guard let address = occurrence.oc_location else { continue }
            geocodeAddress(address: address) { [weak self] coordinate in
                guard let coordinate = coordinate else { return }
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                annotation.title = occurrence.oc_category
                annotation.subtitle = occurrence.oc_description
                
                self?.mapView.addAnnotation(annotation)
            }
        }
    }
    
    

    
    // MARK: - Navigation

     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
             if segue.identifier == "showOccurrenceDetail",
                let vc = segue.destination as? ViewController {
                 vc.occurrence = selectedOccurrence
             }
         }

}

extension MapViewController: MKMapViewDelegate {
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        
        guard let annotation = view.annotation, let name = annotation.title else {return}
        
        selectedOccurrence = occurrences.first { occurrence in
            occurrence.oc_category == name && occurrence.oc_description == annotation.subtitle
        }
        
        let alert = UIAlertController(title: name, message: "O que deseja fazer?", preferredStyle: .actionSheet)
        
        let detailAction = UIAlertAction(title: "Ver Detalhes", style: .default) { [weak self] _ in
                    self?.performSegue(withIdentifier: "showOccurrenceDetail", sender: nil)
                }
                alert.addAction(detailAction)
                
                let routeAction = UIAlertAction(title: "Mostrar Rota", style: .default) { (action) in
                    self.showRoute(to: annotation.coordinate)
                }
                alert.addAction(routeAction)
                
                let cancelAction = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
                alert.addAction(cancelAction)
                
                present(alert, animated: true, completion: nil)
            }
    
    func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
        if overlay is MKPolyline {
            let renderer = MKPolylineRenderer(overlay: overlay)
            
            renderer.lineWidth = 8.0
            renderer.strokeColor = .blue
            
            return renderer
        } else {
            return MKOverlayRenderer(overlay: overlay)
        }
    }
}
