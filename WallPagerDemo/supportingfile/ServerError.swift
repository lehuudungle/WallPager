//
//  ServerError.swift
//  WallPagerDemo
//
//  Created by Ledung95d on 7/16/18.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation


public enum ServerError: Error {
    case systemError(Error)
    case customerError(String)
    var detail: (statusCode: Int, messageError: String) {
        switch self {
        case .customerError(let errorString):
            switch errorString {
            case ServerErrorMessage.noConnectNetwork.rawValue:
                return (ServerErrorCode.noNetwork.rawValue,ServerErrorMessage.noConnectNetwork.rawValue)
            default:
                return (ServerErrorCode.noNetwork.rawValue,ServerErrorMessage.noConnectNetwork.rawValue)
            }
        case .systemError(let error):
            return (error._code, error.localizedDescription)
        }
        
    }
}

public enum ServerErrorMessage: String {
    case noConnectNetwork = "Kiểm tra lại kết nối mạng"
    
}

public enum ServerErrorCode: Int {
    case noNetwork = 10001
}
