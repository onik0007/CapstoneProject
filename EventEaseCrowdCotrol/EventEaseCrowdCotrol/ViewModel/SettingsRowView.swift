//
//  SettingsRowView.swift
//  EventEaseCrowdCotrol
//
//  Created by Kino Porteous on 5/15/23.
//

import SwiftUI

struct SettingsRowView: View {
    let imageName: String
    let title: String
    let tintColor: Color
    
    var body: some View{
        HStack(spacing: 12) {
            Image (systemName: imageName)
                .imageScale(.small)
                .font(.title)
                .foregroundColor(tintColor)
                .font(.system(size: 20))
            Text(title)
                .font(.subheadline)
                .foregroundColor(.black)
                .font(.system(size: 20))
        }
    }
}

/*struct SettingsRowView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsRowView(imageName: "gear", title: "version", tintColor: Color(.systemGray))
    }
}*/
