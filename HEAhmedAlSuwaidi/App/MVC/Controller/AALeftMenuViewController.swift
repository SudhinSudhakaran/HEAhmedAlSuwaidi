
import UIKit

protocol AALeftMenuViewControllerDelegate {
    func menuViewController(_ controller: AALeftMenuViewController, selectedOption option: LeftMenuOptions)
}

class AALeftMenuViewController: UIViewController {
    var delegate: AALeftMenuViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension AALeftMenuViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LeftMenu.TableViewCellIds.menuCell) as? AALeftMenuCell
        cell?.menuLabel.text = menuItems[indexPath.row]
        return cell!
    }
}

extension AALeftMenuViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.menuViewController(self, selectedOption: LeftMenuOptions(rawValue: indexPath.row)!)
    }
}
