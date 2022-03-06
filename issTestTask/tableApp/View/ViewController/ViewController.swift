//
//  ViewController.swift
//  tableApp
//
//  Created by Никита Комаров on 28.02.2022.
//

import UIKit
import Foundation

//MARK: - Основной контроллер
class ViewController: UIViewController {
    
    @IBOutlet weak var tableView        : UITableView!
    var data: [StopArr]                 = []
    private var presenter               = ViewControllerPresenter()
    weak private var viewOutputDelegate : ViewOutputDelegate?
    private var stopId                  : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.setViewInputDelegate(viewInputDelegate: self)
        self.viewOutputDelegate = presenter
        self.viewOutputDelegate?.requestAndLoadData()
    }
    
    // MARK: - Подготоввка данных в MapViewController
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination          = segue.destination as? MapViewController {
               destination.data     = data[(tableView.indexPathForSelectedRow?.row)!]
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(data.count)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell                = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text    = data[indexPath.row].name
        
        return (cell)
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showMap", sender: self)
    }
}

extension ViewController: ViewInputDelegate {
    func requestData(with testData: [StopArr]) {
        self.data = testData
    }
    
    func reloadTableview(){
        self.tableView.reloadData()
    }
}
