//
//  ShazamDetail.swift
//  ShazamKit-Demo
//
//  Created by Aaryan Kothari on 09/06/21.
//

import SwiftUI

struct ShazamDetail: View {
    let media: SHMedia
    var body: some View {
        ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
            AsyncImage(url: media.image) { image in
                image
                    .resizable()
                    .scaledToFill()
                    .blur(radius: 10)
            } placeholder: {
                Color.black
            }
        VStack {
            AsyncImage(url: media.image) { image in
                image
                    .resizable()
                    .frame(width: 250, height: 250)
                    .cornerRadius(7)
                    .shadow(radius: 10)
            } placeholder: {
                Color.black
            }
            
            Text(media.name)
                .font(.system(size: 30, weight: .black))
                .foregroundColor(.white)
            Text(media.artist)
                .bold()
                .foregroundColor(.secondary)
            Link(destination: media.mediaUrl) {
               Text(" View in Apple Music")
                    .foregroundColor(.white)
                    .bold()
                    .padding()
                    .background(.pink)
                    .cornerRadius(6)
            }
            .padding(50)
        }
        }
        .frame(width: UIScreen.main.bounds.width)
        .edgesIgnoringSafeArea(.all)
    }
}

struct ShazamDetail_Previews: PreviewProvider {
    static var previews: some View {
        ShazamDetail(media: SHMedia.data)
    }
}
