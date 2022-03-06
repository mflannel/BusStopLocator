//
//  Presenter.swift
//  tableApp
//
//  Created by Никита Комаров on 05.03.2022.
//

import Foundation
import Alamofire

//MARK: - Презентер основного контроллера
class ViewControllerPresenter {
    weak private var viewInputDelegate: ViewInputDelegate?
    var data: [StopArr] = []
    
    func setViewInputDelegate(viewInputDelegate: ViewInputDelegate?) {
        self.viewInputDelegate = viewInputDelegate
    }
    
    func requestData(completion: @escaping ([StopArr]) -> Void) {
            AF.request(APIKeyManager.shared.key).responseDecodable(of: Response.self) { response in
                if case .success    = response.result {
                    self.data       = response.value!.data
                    self.loadData()
                }
            }
    }
    
    func loadData()
    {
        self.viewInputDelegate?.requestData(with: self.data)
        print (self.data)
        self.viewInputDelegate?.reloadTableview()
    }
}

extension ViewControllerPresenter: ViewOutputDelegate {
    func requestAndLoadData() {
        requestData() {_ in}
    }
    func getNumberOfStops() -> Int {
        return(self.data.count)
    }
}
