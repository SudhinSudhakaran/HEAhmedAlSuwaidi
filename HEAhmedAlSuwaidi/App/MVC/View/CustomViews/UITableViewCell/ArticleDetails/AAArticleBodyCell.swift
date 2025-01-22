

import UIKit
import WebKit

class AAArticleBodyCell: UITableViewCell {

    @IBOutlet weak var body: WKWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        body.navigationDelegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func populateData(_ article: AAArticleDetailModel?) {
        if article != nil {
            
            let htmlString = "<p dir=rtl style='text-align:justify;line-height:50pt;'><font size=20 > الموضوع :   "+(article?.articleCategoryName)!+"<br> المكان : " + (article?.articlePlaceName)!+"<br>الجريدة : " + (article?.articleNewspaperName)!+"<br> "+(article?.articleJournalist)! + "<br> أشخاص : <br>" + (article?.articlePeople)! + "</font></p><br><font size=20>" + (article?.articleBody)! + "</font>"
            //print (htmlString)
            self.body.loadHTMLString(htmlString, baseURL: nil)
            
            //self.body.loadHTMLString((article?.articleBody)!, baseURL: nil)
        }
    }
}

extension AAArticleBodyCell: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if navigationAction.navigationType == .linkActivated  {
            if let url = navigationAction.request.url,
                UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                    print(url)
                    print("Redirected to browser. No need to open it locally")
                    decisionHandler(.cancel)
            } else {
                print("Open it locally")
                decisionHandler(.allow)
            }
        } else {
            print("not a user clickk")
            decisionHandler(.allow)
        }
    }
}
