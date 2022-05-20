//
//  NetworkError.swift
//  Photo search
//
//  Created by Paweł on 19/05/2022.
//

import Foundation

enum APError: Error {
    case invalidURL
    case unableToComplete
    case invalidResponse
    case invalidData
}
