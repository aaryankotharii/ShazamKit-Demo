//
//  ShazamState.swift
//  ShazamKit-Demo
//
//  Created by Aaryan Kothari on 09/06/21.
//

import SwiftUI

enum ShazamState {
    case idle
    case listening
    case success
    
    var color: Color {
        return self == .success ? .green : .blue
    }
}
