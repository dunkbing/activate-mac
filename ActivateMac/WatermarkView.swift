//
//  WatermarkView.swift
//  ActivateMac
//
//  Created by Bùi Đặng Bình on 5/4/25.
//

import SwiftUI

struct WatermarkView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 2) {
            Text("Activate macOS")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white.opacity(0.6))
            Text("Go to Settings to activate macOS")
                .font(.system(size: 14, weight: .regular))
                .foregroundColor(.white.opacity(0.6))
        }
        .padding(.leading, 12)
        .padding(.bottom, 12)
    }
}
