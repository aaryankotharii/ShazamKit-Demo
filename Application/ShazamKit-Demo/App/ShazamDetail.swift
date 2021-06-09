//
//  ShazamDetail.swift
//  ShazamKit-Demo
//
//  Created by Aaryan Kothari on 09/06/21.
//

import SwiftUI

struct ShazamDetail: View {
    // MARK: PROPERTIES
    let media: SHMedia
    
    // MARK: BODY
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
            AsyncImage(url: media.image) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .blur(radius: 10)
            } placeholder: {
                Color.black
            } // ASYNC IMAGE
        VStack {
            AsyncImage(url: media.image) { image in
                image
                    .resizable()
                    .frame(width: 250, height: 250)
                    .cornerRadius(7)
                    .shadow(radius: 10)
            } placeholder: {
                Color.black
            } // ASYNC IMAGE
            
            Text(media.name)
                .foregroundColor(.white)
                .font(.system(size: 30, weight: .black))
            Text(media.artist)
                .foregroundColor(.white)
                .bold()
            Link(destination: media.mediaUrl) {
               Text(" View in Apple Music")
                    .foregroundColor(.white)
                    .bold()
                    .padding()
                    .background(.pink)
                    .cornerRadius(6)
            } // LINK
            .padding(50)
        } // VSTACK
        } // ZSTACK
        .frame(width: UIScreen.main.bounds.width)
        .edgesIgnoringSafeArea(.all)
    }
}

// MARK: PREVIEW
struct ShazamDetail_Previews: PreviewProvider {
    static var previews: some View {
        ShazamDetail(media: SHMedia.data)
    }
}
