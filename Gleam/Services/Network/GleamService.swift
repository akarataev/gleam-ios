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
}

extension HealthService: TargetType {
    
    var baseURL: URL {
        return URL(string: "http://18.222.158.154:8000/")!
    }
    
    var path: String {
        switch self {
        case .getClinics:
            return "clinics"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getClinics:
            return .get
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        switch self {
        case .getClinics:
            return .requestPlain
        }
    }
    
    var headers: [String: String]? {
        return nil
    }
    
    var validationType: ValidationType {
        return .successCodes
    }
}
