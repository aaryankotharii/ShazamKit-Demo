//
//  ShazamRow.swift
//  ShazamKit-Demo
//
//  Created by Aaryan Kothari on 09/06/21.
//

import SwiftUI

struct ShazamRow: View {
    let media: SHMedia
    var body: some View {
        HStack {
            AsyncImage(url: media.image) { image in
                image.resizable()
                    .frame(width: 100, height: 100)
                    .clipShape(RoundedRectangle(cornerRadius: 7))
            } placeholder: {
                Color.secondary
                    .frame(width: 100, height: 100)
            }
            VStack(alignment:.leading,spacing:10) {
                Text(media.name ?? "No Title")
                    .font(.title3)
                    .bold()
                Text(media.artist ?? "")
                    .font(.callout)
            }
            .padding()
        }
    }
}

struct ShazamRow_Previews: PreviewProvider {
    static var previews: some View {
        ShazamRow(media: SHMedia.data)
            .previewLayout(.sizeThatFits)
    }
}
