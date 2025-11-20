//
//  MultipleOptionsView.swift
//  CommunityApp
//
//  Created by Jayden Seto on 2025-11-17.
//

import SwiftUI

struct MultipleSelectionRow: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.medium)
                .padding()
                .frame(maxWidth: .infinity)
                .background(isSelected ? Color.blue.opacity(0.8) : Color.gray.opacity(0.2))
                .foregroundColor(isSelected ? .white : .black)
                .cornerRadius(15)
        }.buttonStyle(.plain)
    }
}
