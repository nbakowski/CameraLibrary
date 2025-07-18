//
//  Styles.swift
//  CameraLibrary
//
//  Created by Nikodem Bąkowski on 18/07/2025.
//
import SwiftUI

struct DescriptionStyle: ViewModifier {

    func body(content: Content) -> some View {
        content
            .font(.footnote)
            .scaledToFit()
            .foregroundColor(Color.black)
    }
}

struct NameStyle: ViewModifier {
    
    let chosenFontColor: Color

    func body(content: Content) -> some View {
        content
            .font(.title)
            .fontWeight(.bold)
            .scaledToFit()
            .minimumScaleFactor(0.5)
            .foregroundColor(chosenFontColor)
    }
}
