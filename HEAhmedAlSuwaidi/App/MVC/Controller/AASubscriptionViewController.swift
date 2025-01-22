//
//  AASubscriptionViewController.swift
//  HEAhmedAlSuwaidi
//
//  Created by Sreekanth R on 24/08/19.
//  Copyright © 2019 Electronic Village. All rights reserved.
//

import UIKit
import StoreKit

class AASubscriptionViewController: AAViewController {
    @IBOutlet weak var tableView: UITableView!
    var productIDs: Array<String> = []
    var productsArray: Array<SKProduct> = []
    var isMapBased = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if isMapBased == true { self.navigationItem.rightBarButtonItem = nil }
        productIDs.append("org.evillage.heaMonthly")
        productIDs.append("org.evillage.heaYearly")
        SKPaymentQueue.default().add(self)
        requestProductInfo()

        // Do any additional setup after loading the view.
    }
    
    func requestProductInfo() {
        if SKPaymentQueue.canMakePayments() {
            let productIdentifiers = NSSet(array: productIDs)
            showLoaderOnView(view)
            let productRequest = SKProductsRequest(productIdentifiers: productIdentifiers as Set<NSObject> as! Set<String>)
            
            productRequest.delegate = self
            productRequest.start()
        }
        else {
            print("Cannot perform In App Purchases.")
        }
    }
    
    @IBAction func onSelectPrivayPolicy(_ sender: Any) {
        let url = URL(string:"https://www.electronicvillage.org/mohammedsuwaidi.php?pageid=26&languageid=2")!
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            // Fallback on earlier versions
            UIApplication.shared.openURL(url)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func onSelectCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

}

extension AASubscriptionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (productsArray.count + 2)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == productsArray.count  {
            let cell = tableView.dequeueReusableCell(withIdentifier: Dashboard.TableViewCellIds.subscriptioRestorenCell) as? AASubscriptionCell
            return cell!
        } else if indexPath.row == (productsArray.count + 1)  {
            let cell = tableView.dequeueReusableCell(withIdentifier: Dashboard.TableViewCellIds.subscriptionCancelCell) as? AASubscriptionCell
            return cell!
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Dashboard.TableViewCellIds.subscriptionCell) as? AASubscriptionCell
            
            let prodct = productsArray[indexPath.row]
            cell?.title.text = prodct.localizedTitle
            cell?.desc.text = prodct.localizedDescription
            
            let local = "\(prodct.priceLocale)".components(separatedBy: "=").last!
            let lclPrefix = local.components(separatedBy: " ").first!
            let prce = "\(prodct.price)"
            
            cell?.price.text = "\(lclPrefix) \(prce)"
            
            return cell!
        }
    }
}

extension AASubscriptionViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == productsArray.count {
            SKPaymentQueue.default().restoreCompletedTransactions()
        } else if indexPath.row == (productsArray.count + 1) {
            dismiss(animated: true, completion: nil)
        } else {
            let alert = UIAlertController(title: "HEAhmedAlSuwaidi", message: "Do you want to procced with purchase?", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "Proceed", style: .default , handler:{ (UIAlertAction)in
                self.showLoaderOnView(self.view)
                let payment = SKPayment(product: self.productsArray[indexPath.row] as SKProduct)
                SKPaymentQueue.default().add(payment)
                
            }))
            
            alert.addAction(UIAlertAction(title: "Cancel", style: .default , handler:{ (UIAlertAction)in
                alert.dismiss(animated: true, completion: nil)
            }))
            
            present(alert, animated: true, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == productsArray.count || indexPath.row == (productsArray.count + 1) {
            return 50
        }
        
        return 112
    }
}

extension AASubscriptionViewController: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        hideLoaderFromView(view)
        productsArray = []
        if response.products.count != 0 {
            for product in response.products {
                productsArray.append(product)
            }
            
            tableView.reloadData()
        }
        else {
            print("There are no products.")
        }
    }
}

extension AASubscriptionViewController: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        hideLoaderFromView(view)
        for transaction in transactions {
            switch transaction.transactionState {
            case SKPaymentTransactionState.restored:
                UserDefaults.standard.set(true, forKey: "purchased")
                break
            case SKPaymentTransactionState.purchased:
                SKPaymentQueue.default().finishTransaction(transaction)
                UserDefaults.standard.set(true, forKey: "purchased")
                let alert = UIAlertController(title: "HEAhmedAlSuwaidi", message: "Subscription reniewed successfully", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                    self.navigationController?.popViewController(animated: true)
                }))
                
                self.present(alert, animated: true)
                break
            case SKPaymentTransactionState.failed:
                SKPaymentQueue.default().finishTransaction(transaction)
                
                let alert = UIAlertController(title: "HEAhmedAlSuwaidi", message: "Subscription failed to reniew", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
                }))
                
                self.present(alert, animated: true)
                break
            default:
                print(transaction.transactionState.rawValue)
            }
        }
    }
}
