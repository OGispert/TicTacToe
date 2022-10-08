//
//  CustomViews.swift
//  TicTacToe
//
//  Created by Othmar Gispert on 10/8/22.
//

import SwiftUI

struct SquaresView: View {
    var proxy: GeometryProxy

    var body: some View {
        Rectangle()
            .foregroundColor(.blue)
            .frame(width: proxy.size.width / 3 - 10,
                   height: proxy.size.width / 3 - 10,
                   alignment: .center)
    }
}

struct ImagesView: View {
    var systemName: String

    var body: some View {
        Image(systemName: systemName)
            .resizable()
            .frame(width: 40,
                   height: 40,
                   alignment: .center)
            .foregroundColor(.white)
    }
}
