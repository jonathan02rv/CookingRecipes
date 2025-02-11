//
//  ErrorRequest.swift
//  DataRecipes
//
//  Created by JHONATAHAN RIVERA on 2/10/25.
//

import Domain

enum ErrorRequest: String, Error {
    case badURL
    case parseError
    case netWorkError
    case unknown

    func getTypeError() -> ErrorType {
        return ErrorType(rawValue: self.rawValue) ?? .generic
    }
}
