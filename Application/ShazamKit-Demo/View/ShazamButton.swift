//
//  ShazamButton.swift
//  ShazamKit-Demo
//
//  Created by Aaryan Kothari on 09/06/21.
//

import SwiftUI

struct ShazamButton: View {
    @Binding var title: String
    @Binding var state: ShazamState
    var body: some View {
        HStack {
            Image("shazam")
                .resizable()
                .frame(width: 40, height: 40)
            Text(title)
                .foregroundColor(.white)
                .font(.system(size: 25, weight: .medium))
        }
        .padding(.horizontal,10)
        .padding()
        .background(state.color)
        .clipShape(Capsule())
        .shadow(radius: 10)
    }
}

struct ShazamButton_Previews: PreviewProvider {
    static var previews: some View {
        ShazamButton(title: .constant("Listen"), state: .constant(.idle))
            .previewLayout(.sizeThatFits)
    }
}
