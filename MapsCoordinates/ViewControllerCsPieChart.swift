//
//  ViewControllerCsPieChart.swift
//  MapsCoordinates
//
//  Created by Sierra 4 on 16/02/17.
//  Copyright © 2017 Sierra 4. All rights reserved.
//

import UIKit

import CSPieChart

class ViewControllerCsPieChart: UIViewController {

    var distanceArrayPieChart = [Int]()
    
    
    @IBOutlet var pieChart: CSPieChart!
   
        var data = [CSPieChartData]()
        var colorList: [UIColor] = [
            .red,
            .orange,
            .yellow,
           
   
            .green,
            .blue,
            .magenta
        ]
         @IBAction func btnBack(_ sender: Any) {
            _ = self.navigationController?.popViewController(animated: true)
            
         }
        var subViewList: [UIView] = []
        
        override func viewDidLoad() {
            super.viewDidLoad()
            // Do any additional setup after loading the view, typically from a nib.
            
            
            
            pieChart.dataSource = self
            pieChart.delegate = self
            
            pieChart?.pieChartRadiusRate = 1
            pieChart?.pieChartLineLength = 10
            pieChart?.seletingAnimationType = .touch
            
            for index in distanceArrayPieChart.indices
            {
                data.append(CSPieChartData(key:"task\(index)" , value: Double(distanceArrayPieChart[index])))
                var value = distanceArrayPieChart[index]
                
                
                let view1 = UILabel()
                view1.text = "\(value) Metre"
                view1.textAlignment = .center
                view1.sizeToFit()
                subViewList.append(view1)
                
            }
            
            
            
        }
        
        
        
    }
    
    extension ViewControllerCsPieChart: CSPieChartDataSource {
        func numberOfComponentData() -> Int {
            return distanceArrayPieChart.count
        }
        
        func pieChartComponentData(at index: Int) -> CSPieChartData {
            return data[index]
        }
        
        func numberOfComponentColors() -> Int {
            
            return colorList.count
        }
        
        func pieChartComponentColor(at index: Int) -> UIColor {
            return colorList[index]
        }
        
        func numberOfLineColors() -> Int {
            return colorList.count
        }
        
        func pieChartLineColor(at index: Int) -> UIColor {
            return colorList[index]
        }
        
        func numberOfComponentSubViews() -> Int {
            return subViewList.count
        }
        
        func pieChartComponentSubView(at index: Int) -> UIView {
            return subViewList[index]
        }
    }
    
    extension ViewControllerCsPieChart: CSPieChartDelegate {
        func didSelectedPieChartComponent(at index: Int) {
            
        }
    }

   




