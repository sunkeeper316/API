//
//  NameTVC.swift
//  API
//
//  Created by 黃德桑 on 2019/5/16.
//  Copyright © 2019 sun. All rights reserved.
//

import UIKit

class NameTVC: UITableViewController ,URLSessionDownloadDelegate{
   
    

    @IBOutlet weak var progressView: UIProgressView!
    var names = [Name]()
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return names.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath) as! NameCell

        let name = names[indexPath.row]
        cell.lbName.text = name.name
        cell.lbSurname.text = name.surname
        cell.lbGender.text = name.gender
        cell.lbregion.text = name.region
        // Configure the cell...

        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        let decoder = JSONDecoder()
        let data = try? Data(contentsOf: location)
        if let name = try? decoder.decode(Name.self, from: data!){
            self.names.append(name)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        } else {
            print("error")
        }
    }
    

    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        
        let progressView = Float(totalBytesWritten) / Float(totalBytesExpectedToWrite)
        print(-progressView/100)
        
        DispatchQueue.main.async {
            self.progressView.progress = -progressView/100
        }
    }
    @IBAction func clickAdd(_ sender: UIBarButtonItem) {
        if let urlString = "https://uinames.com/api/".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), let url = URL(string: urlString) {
            let sessioncon = URLSessionConfiguration.default
            let session = URLSession(configuration: sessioncon, delegate: self, delegateQueue: OperationQueue.main)
            let datatask = session.downloadTask(with: url)

            
//            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
//
//                if let data = data {
//                    let decoder = JSONDecoder()
//                    decoder.dateDecodingStrategy = .iso8601
//                    if let name = try? decoder.decode(Name.self, from: data) {
//                        self.names.append(name)
//                        DispatchQueue.main.async {
//                            self.tableView.reloadData()
//                        }
//                    } else {
//                        print("error")
//                    }
//                }
//            }
            datatask.resume()
//            task.resume()
            
        }
    }
    
}
