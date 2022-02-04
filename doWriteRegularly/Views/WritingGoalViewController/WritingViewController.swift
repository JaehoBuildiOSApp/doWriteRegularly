//
//  WritingViewController.swift
//  doWriteRegularly
//
//  Created by Jaeho Jung on 2021/12/17.
//

import UIKit
import UserNotifications

class WritingViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    
    var writingIndexToEdit: Int?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        
        WritingFunctions.readWritings(completion: { [weak self] in
            self?.tableView.reloadData()
        })
        
        view.backgroundColor = Theme.Background
        addButton.createFloatingActionButton()

    }
//
//    @IBAction func didTapTest() {
//        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound], completionHandler: { success, error in
//            if success {
//                self.scheduleTest()
//            } else if let error = error {
//                print("error occurred")
//            }
//        })
//    }
//
//    func scheduleTest() {
//        let content = UNMutableNotificationContent()
//        content.title = "Hello World"
//        content.sound = .default
//        content.body = "test body"
//
//        let targetDate = Date().addingTimeInterval(5)
//        let trigger = UNCalendarNotificationTrigger(dateMatching: Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: targetDate), repeats: false)
//
//        let request = UNNotificationRequest(identifier: "some_long_id", content: content, trigger: trigger)
//        UNUserNotificationCenter.current().add(request, withCompletionHandler: { error in
//            if error != nil {
//                print("something went wrong")
//            }
//        })
//    }
    

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toAddWritingSegue" {
            let popup = segue.destination as! AddWritingViewController
            popup.writingIndexToEdit = self.writingIndexToEdit
            popup.doneSaving = { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
}
 
extension WritingViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Data.writingModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! WritingTableViewCell
                
        cell.setup(writingModel: Data.writingModels[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
                
        let delete = UIContextualAction(style: .destructive, title: "삭제") { (UIContextualAction, view, actionPerformed: @escaping (Bool) -> ()) in
            
            let alert = UIAlertController(title: "목표 삭제", message: "목표를 삭제하시겠어요?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler: { (alertAction) in actionPerformed(false)
            }))
            alert.addAction(UIAlertAction(title: "삭제", style: .destructive, handler: { (alertAction) in
                WritingFunctions.deleteWriting(index: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .automatic)
                actionPerformed(true)
            } ))
            
            self.present(alert, animated: true)
        }
                
        return UISwipeActionsConfiguration(actions: [delete])
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let edit = UIContextualAction(style: .normal, title: "수정") { (UIContextualAction, view, actionPerformed: @escaping (Bool) -> ()) in
            self.writingIndexToEdit = indexPath.row
            self.performSegue(withIdentifier: "toAddWritingSegue", sender: nil)
            actionPerformed(true)
        }
        edit.backgroundColor = UIColor(named: "Edit")
        
        return UISwipeActionsConfiguration(actions: [edit])
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let storyboard = UIStoryboard(name: String(desc), bundle: <#T##Bundle?#>)
//    }
}

