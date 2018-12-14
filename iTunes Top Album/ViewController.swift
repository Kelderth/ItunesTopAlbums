//
//  ViewController.swift
//  iTunes Top Album
//
//  Created by Jesus Sanchez on 12/12/18.
//  Copyright © 2018 Jesus Sanchez. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let albumTop : [String] = ["Select a Top...", "Top 5", "Top 10", "Top 25", "Top 50", "Top 75"]
    let options : [String] = ["0", "5", "10", "25", "50", "75"]
    var iTunesRequest : NetworkingRequest = NetworkingRequest()
    var albumSource : [Album] = [Album]()
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Table View (delegate & dataSource)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        
        //iTunesRequest.downloadiTunes("5")
        
        setupNetworkingService()
        
        print("Eduardo echale ganas, TU PUEDES!")
    }

    func setupNetworkingService() {
        let success: TopAlbumSuccess = { [unowned self] Album in
            DispatchQueue.main.async {
                self.albumSource = Album
                self.tableView.reloadData()
            }
        }
        iTunesRequest.success = success
    }

}

// TABLE VIEW
extension ViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {

        return 1

    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        print(albumSource.count)
        return albumSource.count

    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? AlbumItemTableViewCell else {
            return UITableViewCell()
        }
        
        let item = albumSource[indexPath.row]
        cell.setup(album: item)
        return cell
    }
    
    
}

// PICKER VIEW
extension ViewController: UIPickerViewDelegate,UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return albumTop.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return albumTop[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // do an API call with the selectedRow
        if row >= 0 {
            iTunesRequest.downloadiTunes(options[row])
//            print("User did select" + "\(row)")
        }
        
    }
    
}
