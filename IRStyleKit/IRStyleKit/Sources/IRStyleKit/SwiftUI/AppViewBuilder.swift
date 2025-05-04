//
//  AppViewBuilder.swift
//  IRStyleKit
//
//  Created by Ömer Faruk Öztürk on 4.05.2025.
//

import SwiftUI

struct AppViewBuilder<TabbarView: View, OnboardingView: View>: View {
    var showTabBar: Bool = false
    //Group
    @ViewBuilder var tabbarView: TabbarView
    @ViewBuilder var onboardingView: OnboardingView
    
    var body: some View {
        ZStack {
            if showTabBar {
                tabbarView
                    .transition(.move(edge: .trailing))
            } else {
                onboardingView
                    .transition(.move(edge: .leading))
            }
        }
        .animation(.smooth, value: showTabBar)
    }
}

private struct PreviewView: View {
    
    @State private var showTabBar: Bool = false
    
    var body: some View {
        AppViewBuilder(
            showTabBar: showTabBar,
            tabbarView: {
                ZStack {
                    Color.red.ignoresSafeArea()
                    Text("Tabbar")
                }
            },
            onboardingView: {
                ZStack {
                    Color.blue.ignoresSafeArea()
                    Text("Onboarding")
                }
            }
        )
        .onTapGesture {
            showTabBar.toggle()
        }
    }
}

#Preview(body: {
    PreviewView()
})

/*
Modüler yapıda olsaydık nelere dikkat etmeliydik?
ViewBuilder’lı yapıyı içeren modül, sadece SwiftUI’a bağımlı olmalı, başka modüllere değil.
Örn: UICommonKit ya da IRTransitionKit gibi bir modülde bu AppViewBuilder yer alabilir.
Dependency yönü tek yöne akmalı:
AppViewBuilder modülü hiçbir zaman IRJPH veya IRDashboard gibi ana app modüllerini bilmemeli.
Ana app, AppViewBuilder'ı kullanmalı ama tersi asla olmamalı (aksi takdirde circular dependency oluşur).
Generic ve özelleştirilebilir API sunulmalı:
Buradaki TabbarView ve OnboardingView gibi generic parametreler, modülü başkaları da kullanabilsin diye çok doğru bir yaklaşım.
Varsayılan animasyon veya geçişler injectable olmalı:
.transition(.move(edge: .trailing)) gibi değerler dışarıdan da override edilebilir yapıdaysa çok daha esnek olur.
*/
