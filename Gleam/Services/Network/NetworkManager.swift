//
//  NetworkManager.swift
//  Gleam
//
//  Created by albert on 09/11/2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Foundation
import Moya
import Result

struct NetworkManager {
    
    static private let provider = MoyaProvider<HealthService>()
    
    static func getClinics(completion: @escaping (Result<[ClinicModel], GleamError>) -> Void) {
        provider.request(.getClinics) { result in
            switch result {
            case .success(let value):
                guard let clinics = try? value.map([ClinicModel].self, atKeyPath: "data", using: JSONDecoder(), failsOnEmptyData: false) else {
                    completion(.failure(GleamError()))
                    return
                }
                completion(.success(clinics))
            case .failure(_):
                completion(.failure(GleamError()))
            }
        }
    }
    
    static func sendUserData(userData: UserFlowData, completion: @escaping (Result<Bool, GleamError>) -> Void) {
        provider.request(.sendUserData(userData)) { result in
            switch result {
            case .success(let value):
                guard let value = try? value.map(Bool.self, atKeyPath: "success", using: JSONDecoder(), failsOnEmptyData: false) else {
                    completion(.failure(GleamError()))
                    return
                }
                completion(.success(value))
            case .failure(_):
                completion(.failure(GleamError()))
            }
        }
    }
}


struct GleamError: Error {
    var localizedDescription: String = "Server is unavailable, please try again later"
}
