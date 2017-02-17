//
//  ViewController.swift
//  MapsCoordinates
//
//  Created by Sierra 4 on 13/02/17.
//  Copyright © 2017 Sierra 4. All rights reserved.
//

import UIKit

import GoogleMaps

import CoreLocation

import CoreData

import CSPieChart


class ViewController: UIViewController,GMSMapViewDelegate,CLLocationManagerDelegate {
    
   
    @IBOutlet var btnView: UIView!//btnBackground view
    
   
    @IBOutlet var btnTraceLine: UIButton! //btn outlet to change on button

   
    @IBOutlet weak var mapView: GMSMapView!//mapView Outlet
    
    @IBOutlet var btnPieChart: UIButton!
  
    @IBOutlet var btnRouteHistory: UIButton!
    let locationManager = CLLocationManager() //creating  current Location object
    
    
   
    let path = GMSMutablePath() // Creating Object of Path Class
    
    let marker = GMSMarker()// creating marker  Object

    
    
    var lineDrawer = 0//flag for line Drawing
    
   
    var myLati = Double() //global variable to store latitude
    
    
    var myLongi = Double()//global variable to store Longitude
    
    
    var myLatLongArrayStartingPosition = [Double]()//global array of starting latitude and longitude
    
    
    var myLatLongArrayEndPosition = [Double]()//global array of ending latitude and longitude
    
   
    var distanceArray = [Int]() //distance array for storing distance of particular route
    
   
    var indexOfDistanceArray = 0 //temrory variable for checking
    
    
    var myLatLongStartingPositionDictionary:[[String:Double]] = []
    
    var myLatLongEndingPositionDictionary:[[String:Double]] = []
    
    let date = Date()
    let formatter = DateFormatter()
  
    
    
    
    
    
    //View Did Load Function
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        self.btnTraceLine.center.x = self.view.frame.width
        self.btnPieChart.center.x = self.view.frame.width
        
        
        UIView.animate(withDuration: 1.0, delay: 0, usingSpringWithDamping: 4.0, initialSpringVelocity: 5.0, options: UIViewAnimationOptions(rawValue: 0), animations:({
            self.btnRouteHistory.center.y = self.view.frame.width/2
            self.btnPieChart.center.y = self.view.frame.width/2
            self.btnTraceLine.center.x = self.view.frame.width / 2
        
        })
        , completion: nil)
       
        formatter.dateFormat = "dd.MM.yyyy"
        
        
        
       
        
        
//       btnTraceLine.layer.cornerRadius = btnTraceLine.frame.size.width/2     //for button customization
//        btnTraceLine.clipsToBounds = true
        
        //location manger delegates
        self.locationManager.delegate = self
        
        self.locationManager.requestWhenInUseAuthorization()
        
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        
        self.locationManager.startUpdatingLocation()
        
       
        
        mapView.settings.myLocationButton = true    //Currnet location button
        
      
       
        mapView.animate(toZoom: 15)     //zoom at starting of app

 
    }
    
    
    
    
     //////////////////////////////////////////////////////////////////////////////////////////////
    //fail if not getting cllocation
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
        print("Error" + error.localizedDescription)
    }
   
    
    
    
    
    
     //////////////////////////////////////////////////////////////////////////////////////////////
//it update the current location
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
    {
        let userLocation = locations[0]
        
        // object for getting current user location
        let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        
        
        _ = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
        
        
        mapView.animate(toLocation: CLLocationCoordinate2D.init(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude))
        
       
        mapView.isMyLocationEnabled = true      //enabling current location
        
        locationManager.startUpdatingHeading()
        
        
      
        let markerImage = UIImage(named: "car")!    //setting marker image
        
//        let marker:GMSMarker = GMSMarker.init(position: center)
     
        marker.position = center        //marker position setting
       
        marker.icon = markerImage        //setting mmarker icon with image

        marker.isFlat = true
       
        marker.map = mapView     //setting marker to the map
        
     
        myLati = userLocation.coordinate.latitude
                                                               //getting current location and storing into globall variable
        myLongi = userLocation.coordinate.longitude
        
        
        

        //checker for line drawing
        if lineDrawer == 1
        {
        _ = path.add(CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude))
      
        
            
        let polyline = GMSPolyline(path: path)  //polyline object
            
            
        polyline.strokeColor = UIColor.blue   //color setting
            
           
        polyline.strokeWidth = 5.0    //width of line
            
            
        polyline.map = mapView  //setting polyline to the map
            
        
        }
        else
        {
            path.removeAllCoordinates()
            
        }
        
        
    }
    
   //////////////////////////////////////////////////////////////////////////////////////////////
    
 
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading)
    {
        let  heading:Double = newHeading.magneticHeading;
        marker.groundAnchor = CGPoint(x: 0.5, y: 0.5)
//        var degree = CLLocationDegrees()
//        degree = 90
        marker.rotation = heading
        
        marker.map = mapView;
        print(marker.rotation)
    }
    
    
    
    
    
    
    
    
     //////////////////////////////////////////////////////////////////////////////////////////////
    @IBAction func btnTraceLineAction(_ sender: UIButton) {
        let text = sender.currentTitle!
        btnTraceLine.transform = CGAffineTransform(scaleX: 0.9, y: 0.6)
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 8.0,
                       options: .allowUserInteraction,
                       animations: { [weak self] in
                        self?.btnTraceLine.transform = .identity
            },
                       completion: nil)
        
        if text == "START"
        {
            btnTraceLine.setTitle("STOP", for: .normal)
            
            
            
            btnTraceLine.backgroundColor = UIColor.red
            btnTraceLine.setTitleColor(UIColor.white, for: .normal)
            
            lineDrawer = 1
            
            myLatLongArrayStartingPosition.append(myLati)
           
            myLatLongArrayStartingPosition.append(myLongi)
            print("1--",myLati)
            print("--",myLongi)
            
           
            myLatLongStartingPositionDictionary.append(["latitude":myLatLongArrayStartingPosition[0],"longitude":myLatLongArrayStartingPosition[1]])
            
           
            
           
          
        }
        else if text == "STOP"
            
        {
            btnTraceLine.setTitle("START", for: .normal)
            
            
            btnTraceLine.backgroundColor = UIColor.green
            btnTraceLine.setTitleColor(UIColor.white, for: .normal)
            
            lineDrawer = 0
            
            myLatLongArrayEndPosition.append(myLati)
            
            myLatLongArrayEndPosition.append(myLongi)
            
             myLatLongEndingPositionDictionary.append(["latitude":myLatLongArrayEndPosition[0],"longitude":myLatLongArrayEndPosition[1]])
            
            let location1 = CLLocation(latitude: myLatLongArrayStartingPosition[0], longitude: myLatLongArrayStartingPosition[1])
            
            let location2 = CLLocation(latitude: myLatLongArrayEndPosition[0], longitude: myLatLongArrayEndPosition[1])
            
            let distanceTravelled = location1.distance(from: location2)
            
            let distance = Int(distanceTravelled)
            
            distanceArray.append(distance)
            
            
            
            indexOfDistanceArray = indexOfDistanceArray + 1
            
            myLatLongArrayStartingPosition = []
            
            myLatLongArrayEndPosition = []
            
            
        }
        

    }
    
    @IBAction func btnPieChartAction(_ sender: Any) {
        btnPieChart.transform = CGAffineTransform(scaleX: 0.9, y: 0.6)
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 8.0,
                       options: .allowUserInteraction,
                       animations: { [weak self] in
                        self?.btnPieChart.transform = .identity
            },
                       completion: nil)
        
    }
    @IBAction func btnRouteHistoryAction(_ sender: Any) {
        btnRouteHistory.transform = CGAffineTransform(scaleX: 0.9, y: 0.6)
        UIView.animate(withDuration: 1,
                       delay: 0,
                       usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 8.0,
                       options: .allowUserInteraction,
                       animations: { [weak self] in
                        self?.btnRouteHistory.transform = .identity
            },
                       completion: nil)
        
    }
   
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let result = formatter.string(from: date)
        if segue.identifier == "passing2"
        {
            let yourNextViewcontroller = (segue.destination as! TableViewController)
            
            yourNextViewcontroller.distanceArrayCell = distanceArray
            
            yourNextViewcontroller.startingPostionArrayOfDictionary = myLatLongStartingPositionDictionary
            
            yourNextViewcontroller.EndingPostionArrayOfDictionary = myLatLongEndingPositionDictionary
            
            yourNextViewcontroller.date = result
            
//            addCategory()
          
        }
        if segue.identifier == "passing1"
        {
            let yourNextViewcontroller = (segue.destination as! ViewControllerCsPieChart)
            yourNextViewcontroller.distanceArrayPieChart = distanceArray
        }
    }

   
    
//     func fetchCategories() {
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "DistancePath")
//        do {
//            let results = try appDelegate.persistentContainer.viewContext.fetch(fetchRequest)
//            for task in results {
//                categories.append(task.value(forKeyPath: "title") as! String? ?? "None")
//            }
//        } catch let error as NSError {
//            print("Could not fetch. \(error), \(error.userInfo)")
//        }
//    }
    

     func addCategory() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let catEntity  = NSEntityDescription.entity(forEntityName: "DistancePath", in: appDelegate.persistentContainer.viewContext)!
        let category = NSManagedObject(entity: catEntity, insertInto: appDelegate.persistentContainer.viewContext)
       for index in distanceArray.indices
       {
        category.setValue(distanceArray[index], forKeyPath: "distance")
//        category.setValue(parent , forKeyPath: "parent")
        }
        do {
            try appDelegate.persistentContainer.viewContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }

    


}

