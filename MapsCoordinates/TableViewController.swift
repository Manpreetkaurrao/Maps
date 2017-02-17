//
//  TableViewController.swift
//  MapsCoordinates
//
//  Created by Sierra 4 on 14/02/17.
//  Copyright © 2017 Sierra 4. All rights reserved.
//

import UIKit

class TableViewController: UIViewController {

    @IBOutlet var cellView: UIView!
    var distanceArrayCell = [Int]()
    
    var startingPostionArrayOfDictionary:[[String:Double]] = []
    
    var EndingPostionArrayOfDictionary:[[String:Double]] = []
    
    var date = String()
    
    @IBOutlet var HeaderView: UIView!
    @IBOutlet var tableView: UITableView!
    var SlatSelf = Double()
    var SlongSelf = Double()
    var ElatSelf = Double()
    var ElongSelf = Double()
    let backgroundImage = UIImage(named: "design2")
    override func viewDidLoad() {
        super.viewDidLoad()

       self.tableView.backgroundColor = UIColor(red: 2/255, green: 156/255, blue: 250/255, alpha: 1)
        
        
    }
    
    @IBAction func btnBack(_ sender: Any) {
        
        _ = self.navigationController?.popViewController(animated: true)
    }
   

}
extension TableViewController: UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     
        return distanceArrayCell.count
       
      
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! TableViewCell
        cell.lblRouteData.text = String(distanceArrayCell[indexPath.row]) + "   M"
        cell.lblDate.text = date
      cell.backgroundColor = UIColor.clear
        
        cell.layer.masksToBounds = true
        
      
        
    
        return cell
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        SlatSelf = startingPostionArrayOfDictionary[indexPath.row]["latitude"]!
        SlongSelf = startingPostionArrayOfDictionary[indexPath.row]["longitude"]!
        ElatSelf = EndingPostionArrayOfDictionary[indexPath.row]["latitude"]!
        ElongSelf = EndingPostionArrayOfDictionary[indexPath.row]["longitude"]!
        
        
        performSegue(withIdentifier: "route", sender: self)
    }
    
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "route"
        {
            let yourNextViewcontroller = (segue.destination as! ViewControllerOfMyRoute)
            
            yourNextViewcontroller.Slat = SlatSelf
            yourNextViewcontroller.Slong = SlongSelf
            yourNextViewcontroller.Elat = ElatSelf
            yourNextViewcontroller.Elong = ElongSelf
           
            
            
        }
    }
        
    


}
//func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    let temp = arrayOfCellData[indexPath.section].cellObject[indexPath.row]
//    
//    
//    guard  let name1 = temp.name else {
//        return
//    }
//    guard let image1 = temp.imageCell else {
//        return
//    }
//    guard  let detail1 = temp.detail else {
//        return
//    }
//    namePass = name1
//    detailPass = detail1
//    imagePass = image1
//    
//    performSegue(withIdentifier: "Passing", sender: self)
//}
//
////Segue for data Passing
//override func prepare(for segue: UIStoryboardSegue, sender: Any?)
//{
//    if segue.identifier == "Passing"
//    {
//        let yourNextViewcontroller = segue.destination as! ViewController1
//        yourNextViewcontroller.name = namePass
//        yourNextViewcontroller.detail = detailPass
//        
//        yourNextViewcontroller.imagenext = imagePass
//        
//        
//    }
//}
