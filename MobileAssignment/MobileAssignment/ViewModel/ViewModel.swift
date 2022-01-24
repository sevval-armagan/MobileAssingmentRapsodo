//
//  ViewModel.swift
//  MobileAssignment
//
//  Created by Şevval Armağan on 24.01.2022.
//

import Foundation
import Realm
import RealmSwift

class ViewModel {
    
    var response2: Response?
    let realm = try! Realm()
    
    func fetch(completion: @escaping(Response) -> Void){
        Service.shared.getData(completion: { [self] response in
            response2 = response
            completion(response)
        }
        )
    }
    
//    func save(data: RealmResponse) {
//        do {
//            try realm.write {
//                realm.add(data)
//            }
//        } catch {
//            print("An error occurred while saving the category: \(error)")
//        }
//    }
//    
    
}
