//
//  BasePresenter.swift
//  NetXMov
//
//  Created by Ilham Hadi P. on 30/07/21.
//

import Foundation
import SwiftUI

protocol BasePresenter {
  func deleteFavorite(at index: Int)
  func makefavorite(at index: Int)
}
