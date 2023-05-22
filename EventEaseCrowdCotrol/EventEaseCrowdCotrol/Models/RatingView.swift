//
//  RatingView.swift
//  EventEaseCrowdCotrol
//
//  Created by Kino Porteous on 4/5/23.
//

import SwiftUI

struct RatingView :View {
    var rating: Int
    var body: some View{
        HStack(spacing: 4){
            ForEach(1...5, id: \.self) { index in
                Image(systemName: "star.fill")
                    .font(.caption2)
                    .foregroundColor(index <= rating ? .yellow : .gray.opacity(0.5))
            }
            Text("(\(rating))")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.yellow)
                .padding(.leading, 5)
        }
    }
}
