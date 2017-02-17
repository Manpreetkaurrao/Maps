//
//  ViewControllerOfMyRoute.swift
//  MapsCoordinates
//
//  Created by Sierra 4 on 15/02/17.
//  Copyright © 2017 Sierra 4. All rights reserved.
//

import UIKit

import GoogleMaps



class ViewControllerOfMyRoute: UIViewController {

    var Slat:Double = 0.0
    var Slong:Double = 0.0
    var Elat:Double = 0.0
    var Elong:Double = 0.0
    
    @IBOutlet var mapViewRoute: GMSMapView!
    
    let path = GMSMutablePath() 
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        print(Slat)
        print(Slong)
        print(Elat)
        print(Elong)
        
        let camera = GMSCameraPosition.camera(withLatitude: Slat, longitude: Slong, zoom: 22)
        
        mapViewRoute.camera = camera
       
        
        // Creates a marker in the center of the map.
//        let marker = GMSMarker()
//        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
        path.add(CLLocationCoordinate2D(latitude: Slat, longitude: Slong))
        
        path.add(CLLocationCoordinate2D(latitude: Elat, longitude: Elong))
        
        let polyline = GMSPolyline(path: path)  //polyline object
        
        polyline.strokeColor = UIColor.blue//color setting
        
        polyline.strokeWidth = 5.0    //width of line
        
        polyline.map = mapViewRoute  //setting polyline to the map
    }

   
    @IBAction func btnBack(_ sender: Any) {
        _ = self.navigationController?.popViewController(animated: true)
    }

}
