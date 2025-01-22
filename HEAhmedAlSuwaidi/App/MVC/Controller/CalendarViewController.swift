//
//  CalendarViewController.swift
//  HEAhmedAlSuwaidi
//
//  Created by Tanura Vittil on 11/27/17.
//  Copyright © 2017 Electronic Village. All rights reserved.
//

import UIKit


class CalendarViewController: AAViewController {

    @IBOutlet weak var EventDateLabel: UILabel!
    @IBOutlet weak var EventDatePicker: UIDatePicker!
    @IBOutlet var SearchButton: UIView!
    
    let articleListService = AAAricleListService()
    var eventdatestring: String?
    var articlesArray: [AAArticleModel]?
    
    let date = Date() //TODAYS DATE
    var dateFormatter = DateFormatter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EventDatePicker.datePickerMode = .date
        //EventDatePicker.addTarget(self, action: Selector("EventDatePickerChanged"), for: UIControlEvents.valueChanged)
        EventDatePicker.addTarget(self, action: #selector(EventDatePickerChanged), for: UIControlEvents.valueChanged)
        // Do any additional setup after loading the view.
        dateFormatter.dateFormat = "yyyy-MM-dd"
        EventDateLabel.text = dateFormatter.string(from: date)
        
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func EventDatePickerChanged(datePicker:UIDatePicker) {
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let strDate = dateFormatter.string(from: EventDatePicker.date)
        //print("jjkhjkhhk")
        //print(strDate)
        EventDateLabel.text = strDate
        eventdatestring = strDate
        
       
    }
    //selectedCategory = category
    //performSegue(withIdentifier: StoryboardIds.CategoryList.categoryArticles, sender: nil)
    @IBAction func SearchButtonClicked(_ sender: Any) {
        //print (eventdatestring)
        
        showLoaderOnView(self.view)
        //print (eventdatestring)
        //to be changed to todays date or default date on calender
        
        
        if (eventdatestring == nil)
        {
            //eventdatestring = "1975-12-01"
            dateFormatter.dateFormat = "yyyy-MM-dd"
            eventdatestring = dateFormatter.string(from: date)
        }
        articleListService.getArticleListByEventDate(eventdatestring) { (articles, error) in
            self.articlesArray = articles
            
            DispatchQueue.main.async {
                self.hideLoaderFromView(self.view)
                self.performSegue(withIdentifier: "calendareventdate", sender: nil)
                //self.tableView.reloadData()
            }
        }
        //selectedCategory = category
        //performSegue(withIdentifier: StoryboardIds.CategoryList.categoryArticles, sender: nil)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        //print("\(segue.identifier)")
        //print("\(segue.destination)")
        //if segue.identifier == "calendareventdate"
        //{
            let dashboard = segue.destination as? AADashboardViewController
        
            dashboard?.isSearchEventDateBased = true
            dashboard?.articlesArray=self.articlesArray
        print("\(segue.destination)")
        
           
        //}
        
        
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
   

}
