//
//  ErrorHandler.swift
//  StorybookInteractive
//
//  Created by Doni Pebruwantoro on 15/08/24.
//

import Foundation

enum ErrorHandler: Error {
    case fileNotFound
    case decodedFailed(Error)
    case encodedFailed(Error)
    case dataCorrupted
}
