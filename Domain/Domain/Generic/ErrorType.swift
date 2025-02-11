//
//  ErrorType.swift
//  Domain
//
//  Created by JHONATAHAN RIVERA on 2/10/25.
//

import Foundation

public enum ErrorType: String, Error {
    case badURL
    case parseError
    case netWorkError
    case generic
}
