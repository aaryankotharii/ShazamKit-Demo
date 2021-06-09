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
        VStack {
            AsyncImage(url: media.image)
        }
    }
}

struct ShazamDetail_Previews: PreviewProvider {
    static var previews: some View {
        ShazamDetail(media: SHMedia.data)
    }
}
