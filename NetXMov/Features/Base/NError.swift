//
//  DataError.swift
//  NetXMov
//
//

import Foundation

enum NError: Error, Equatable {
  case unauthorized
  case internalServerError
  case responseError(message: String)
  case incompleteInput
  case undefinedError
  case parseError
  case serializationError
  case notValidURL
  case sourceNotFound
}

extension NError {
  var description: String {
    switch self {
    case .unauthorized:
      return "Ups! Your session has been expired. You'll be logged out."
    case let .responseError(message):
      return message
    case .incompleteInput:
      return "Incomplete input"
    case .undefinedError, .parseError, .internalServerError:
      return "Sorry please try again later"
    case .serializationError:
      return "Problems with serialization"
    case .notValidURL:
      return "URL is not valid"
    case .sourceNotFound:
      return "Source not found"
    }
  }
}

enum DatabaseError: Error{
  case invalidInstance
  case requestFailed
  case saveFailed
}

extension DatabaseError {
  var description: String {
    switch self {
    case .invalidInstance:
      return "Realm Instance Invalid"
    case .requestFailed:
      return "Failed request from realm"
    case .saveFailed:
      return "Failed to save favorite item, Please try again"
    }
  }
}
