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
    let userDefaultsKey = "locationUsrKey"
    var arrLocation : [IssLocatorModel] = []
    //Request a location using protocol functions
    func requestLocation(){
        serviceManager.delegate = self
        serviceManager.sendRequest(urlString: "http://api.open-notify.org/iss-now.json")
    }
    
    func getInitialData(){
        arrLocation = self.getUsrDefaults() ?? []
    }
    
    func serviceResponse(_ responseData: Data?, _ error: Error?) {
        if let modelResponse = self.parseJSONLocator(IssLocatorData: responseData ?? Data()) {
            arrLocation.append(modelResponse)
            setUsrDefaults(arr: arrLocation)
            issModel.value = modelResponse
        }
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
    
    func setUsrDefaults(arr:[IssLocatorModel]) {
        do{
            let jsonEncoder = JSONEncoder()
            let arrEncoded = try jsonEncoder.encode(arr)
            UserDefaults.standard.setValue(arrEncoded, forKey: userDefaultsKey)
            UserDefaults.standard.synchronize()
            print("Se guardo en user defaults")
        }
        catch{
            print("Error al guardar en userdefaults: \(error.localizedDescription)")
        }
    }
    
    func removeUsrDefaults(){
        UserDefaults.standard.removeObject(forKey: userDefaultsKey)
    }
    
    func getUsrDefaults() -> [IssLocatorModel]? {
        guard let arrData = UserDefaults.standard.object(forKey: userDefaultsKey) as? Data else{ return nil }
        do {
            let jsonDecoder = JSONDecoder()
            let arrModels = try jsonDecoder.decode([IssLocatorModel].self, from: arrData)
            return arrModels
        } catch let error {
            print("Ocurrio un error al obtener data de userdefaults: \(error.localizedDescription)")
            return nil
        }
    }
    
    func getnumberOfRows() -> Int {
        if let array = getUsrDefaults() {
            return array.count
        }
        return 0
    }
    
    
    func getCellForRow(index :Int) -> IssLocatorModel? {
        guard let dataUsr = getUsrDefaults() else {
            return nil
        }
        return dataUsr[index]
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
