//
//  AACategoryListViewController.swift
//  HEAhmedAlSuwaidi
//
//  Created by Sreekanth R on 19/11/17.
//  Copyright © 2017 Electronic Village. All rights reserved.
//

import UIKit

class AACategoryListViewController: AAViewController {
    @IBOutlet weak var tableview: UITableView!
    
    var leftMenuOption: LeftMenuOptions?
    let categoryListService = AACategoryListService()
    var categories: [AACategoryModel]?
    var selectedArticle: AACategoryArticleModel?
    var selectedCategory: AACategoryModel?
    var categoryOption: CategoryOptions = .none
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Archives"
        loadData()
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: -
    func loadData() {
        if leftMenuOption == .articlesByYear {
            categoryOption = .byYear
            getCategoryByYear()
        }
        if leftMenuOption == .articlesByPlace {
            categoryOption = .byPlace
            getCategoryByPlace()
        }
        if leftMenuOption == .articlesByNewspaper {
            categoryOption = .byNewsPaper
            getCategoryByNewspaper()
        }
        if leftMenuOption == .articlesByCategory {
            categoryOption = .byCategory
            getCategoryByCategory()
        }
    }
    
    func getCategoryByYear() {
        showLoaderOnView(self.view)
        categoryListService.getCategoryByYear { (categories, error) in
            self.categories = categories
            DispatchQueue.main.async {
                self.hideLoaderFromView(self.view)
                self.tableview.reloadData()
            }
        }
    }

    func getCategoryByPlace() {
        showLoaderOnView(self.view)
        categoryListService.getCategoryByPlace { (categories, error) in
            self.categories = categories
            DispatchQueue.main.async {
                self.hideLoaderFromView(self.view)
                self.tableview.reloadData()
            }
        }
    }
    
    func getCategoryByNewspaper() {
        showLoaderOnView(self.view)
        categoryListService.getCategoryByNewspaper { (categories, error) in
            self.categories = categories
            DispatchQueue.main.async {
                self.hideLoaderFromView(self.view)
                self.tableview.reloadData()
            }
        }
    }

    func getCategoryByCategory() {
        showLoaderOnView(self.view)
        categoryListService.getCategoryByCategory { (categories, error) in
            self.categories = categories
            DispatchQueue.main.async {
                self.hideLoaderFromView(self.view)
                self.tableview.reloadData()
            }
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier ==  StoryboardIds.CategoryList.articleDetails {
            let articleDetails = segue.destination as? AAArticleDetailsViewController
            articleDetails?.isCategoryBased = true
            let article = AAArticleModel(["id": selectedArticle?.articleId ?? ""])
            articleDetails?.selectedArticleModel = article
        }
        if segue.identifier == StoryboardIds.CategoryList.categoryArticles {
            let articles = segue.destination as? AADashboardViewController
            articles?.isCategoryBased = true
            articles?.categoryOption = categoryOption
            articles?.selectedCategory = selectedCategory
        }
        if segue.identifier == StoryboardIds.Dashboard.subscription {
            let subscrptn = segue.destination as? AASubscriptionViewController
            subscrptn?.isMapBased = false
        }
    }
}

extension AACategoryListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if categories != nil && (categories?.count)! > 0 {
            return (categories?.count)!
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = Dashboard.TableViewCellIds.categoryCell
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId) as? AACategoryListCell
        let category = categories![indexPath.row]
        cell?.populateData(category)
        cell?.delegate = self
        
        return cell!
    }
}

extension AACategoryListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 298.0
    }
}

extension AACategoryListViewController: AACategoryListCellDelegate {
    func categorySelected(_ category: AACategoryModel?) {
        selectedCategory = category
        performSegue(withIdentifier: StoryboardIds.CategoryList.categoryArticles, sender: nil)
    }
    func articleSelected(_ article: AACategoryArticleModel?) {
        selectedArticle = article
        if selectedArticle?.isPaid == true {
            if UserDefaults.standard.bool(forKey: "purchased") == true {
                performSegue(withIdentifier: StoryboardIds.CategoryList.articleDetails, sender: nil)
            } else {
                performSegue(withIdentifier: StoryboardIds.Dashboard.subscription, sender: nil)
            }
        } else {
            performSegue(withIdentifier: StoryboardIds.CategoryList.articleDetails, sender: nil)
        }
    }
}
