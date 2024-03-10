//
//  TextView.swift
//  Countries
//
//  Created by Anatolii Shumov on 10.03.2024.
//

import SwiftUI

struct TextView: View {
    let title: String
    let description: String
    var alignment: VerticalAlignment
    
    init(title: String, description: String, alignment: VerticalAlignment = .center) {
        self.title = title
        self.description = description
        self.alignment = alignment
    }
    
    var body: some View {
        HStack(alignment: alignment) {
            Text(title)
            Text(description)
                .bold()
        }
        .padding(.bottom, 10)
    }
}

#Preview {
    TextView(title: "", description: "")
}
