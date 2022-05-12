//
//  IssLocatorViewModel.swift
//  IssLocator
//
//  Created by Minerva Nolasco Espino on 10/05/22.
//

import Foundation

public class IssLocatorViewModel : ServiceManagerDelegate {
    
    private lazy var serviceManager = ServiceManager()
    var  issModel : Bindable<IssLocatorModel?> = Bindable(nil)
    
    //Request a location using protocol functions
    func requestLocation(){
        serviceManager.delegate = self
        serviceManager.sendRequest(urlString: "http://api.open-notify.org/iss-now.json")
    }
    
    func serviceResponse(_ responseData: Data?, _ error: Error?) {
        issModel.value = self.parseJSONLocator(IssLocatorData: responseData ?? Data())
    }
    
    func parseJSONLocator(IssLocatorData: Data) -> IssLocatorModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(IssLocatorModel.self, from: IssLocatorData)
            return decodedData
        } catch {
            print(error)
            return nil
        }
    }
    
    
    //Request location using closure
//    func requestIssLocationWithClosure(){
//        serviceManager.sendRequestWithClosure(urlString: "http://api.open-notify.org/iss-now.json") { data, error in
//            if error != nil{
//                print("Error")
//            }else{
//                DispatchQueue.main.async {
//                    self.issModel.value = self.parseJSONLocator(IssLocatorData: data ?? Data())
//                }
//            }
//        }
//    }
    
}
