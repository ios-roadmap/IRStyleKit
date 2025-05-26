//
//  ScrollViewBootcamp.swift
//  IRStyleKit
//
//  Created by Ömer Faruk Öztürk on 26.05.2025.
//

import SwiftUI

struct ScrollViewBootcamp: View {
    
    @State private var scrollPosition: Int? = nil
    
    var body: some View {
        VStack {
            Button {
                scrollPosition = (0..<20).randomElement()
            } label: {
                Text("SCROLL to 10")
            }

            
            ScrollView(.horizontal) {
                HStack(spacing: 30) {
                    ForEach(0..<20) { index in
                        Rectangle()
                            .fill(
                                Color.yellow.opacity(0.3)
                            )
                            .frame(width: 300, height: 300)
                            .overlay {
                                Text("\(index)")
                                    .font(.largeTitle)
                            }
                            .frame(maxWidth: .infinity)
//                            .containerRelativeFrame(.horizontal, alignment: .center) //Scroll yapıyı tekli container üzerinden yapıyor.
                            .id(index)
                            .scrollTransition(.interactive) { content, phase in
                                content //phase kullanarak content üzerinde özel geçişler
                                    .opacity(phase.isIdentity ? 1 : 0)
                                    .offset(y: phase.isIdentity ? 0 : -100)
                            }
                            .cornerRadius(12)
                            .padding(.horizontal)
                    }
                }
            }
            .scrollTargetLayout()
            .scrollTargetBehavior(.viewAligned) //İlk önce target ile belirlenmesi gerekiyor sonra davranış tipini seçiyoruz. Ardından istersek paging ile sayfa sayfa scroll yapıp ya da rectangle özelinde ufak bir kaydırma animasyonu eklenebikir.
            .scrollBounceBehavior(.basedOnSize) //Ekranda yeteri kadar yoksa scroll yapmıyor. Eğer always olursa standart hali her zaman
            .scrollPosition(id: $scrollPosition, anchor: .center) //indexe scroll
            .animation(.smooth, value: scrollPosition)
        }
    }
}

#Preview {
    ScrollViewBootcamp()
}
