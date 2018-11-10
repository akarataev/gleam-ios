//
//  GleamService.swift
//  Gleam
//
//  Created by albert on 09/11/2018.
//  Copyright © 2018 Alexey Karataev. All rights reserved.
//

import Moya
import Result

enum HealthService {
    case getClinics
    case sendUserData(UserFlowData)
}

extension HealthService: TargetType {
    
    var baseURL: URL {
        return URL(string: "http://gleam.apptolab.ru:8000/")!
    }
    
    var path: String {
        switch self {
        case .getClinics:
            return "clinics"
        case .sendUserData:
            return "appointments"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getClinics:
            return .get
        case .sendUserData:
            return .post
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getClinics:
            let lat = UserSettings.lat
            let lon = UserSettings.lon
            if lat.isZero || lon.isZero {
                return .requestPlain
            } else {
                return .requestParameters(parameters: ["lat": lat, "lon": lon], encoding: URLEncoding.default)
            }
        case .sendUserData(let data):
            return .requestParameters(parameters: data.makeJSON(), encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String: String]? {
        return ["Content-Type": "application/json"]
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
