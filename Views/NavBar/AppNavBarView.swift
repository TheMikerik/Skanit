//
//  AppNavBarView.swift
//  skanit
//
//  Created by Michal Ručka on 09.08.2024.
//

import SwiftUI

struct AppNavBarView: View {
    var body: some View {
        CustomNavView {
            ZStack {
                Color.orange.ignoresSafeArea()
                
                CustomNavLink(
                    destination: Text("Desti")
                    .customNavigationTitle("Custommm")
                    .customNavigationBackButtonHidden(false)
                )
            }
            .customNavigationTitle("Home Screen")
        }
    }
}

#Preview {
    AppNavBarView()
}
