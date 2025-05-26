//
//  ThemedButton.swift
//  IRStyleKit
//
//  Created by Ömer Faruk Öztürk on 16.05.2025.
//

//import SwiftUI
//internal import IRResources
//
//struct ThemedButton<Label: View>: View {
//    let action: () -> Void
//    @ViewBuilder let label: () -> Label
//
//    var body: some View {
//        Button(action: action) { label() }
//            .buttonStyle(.borderedProminent)
//            .tint(AppColors.primary)
//    }
//}

///Hedeflenen Videolar:
///https://www.youtube.com/watch?v=pXmBRK1BjLw&list=PLwvDm4Vfkdphc1LLLjCaEd87BEg07M97y&index=12 ViewBuilder:
///
///https://www.youtube.com/watch?v=MQl4DlDf_5k&list=PLwvDm4Vfkdphc1LLLjCaEd87BEg07M97y&index=4&t=2s ViewModifier
///
///https://www.youtube.com/watch?v=3QZTGatsI-c&list=PLwvDm4VfkdphPRGbtiY-X3IZsUXFi6595&index=3 SDWebImage
///
///https://www.youtube.com/watch?v=S9eQd76oFHk&list=PLwvDm4VfkdphPRGbtiY-X3IZsUXFi6595&index=4 Kingfisher
///
///https://www.youtube.com/watch?v=vHvb7LH8VuE&list=PLwvDm4VfkdphqETTBf-DdjCoAvhai1QpO&index=19&t=111s LazyVGrid
///
///https://www.youtube.com/watch?v=pN5ZMV_3npE&list=PLwvDm4VfkdphqETTBf-DdjCoAvhai1QpO&index=67 SafeAreaInsets
///
///https://www.youtube.com/watch?v=wSmTbtOwgbE&list=PLwvDm4Vfkdphr2Dl4sY4rS9PLzPdyi8PM&index=14&t=4s Sendable
///
///https://www.youtube.com/watch?v=-JLenSTKEcA&list=PLwvDm4Vfkdphr2Dl4sY4rS9PLzPdyi8PM&index=10&t=911s Struct vs Class vs Actor,
///
///https://www.youtube.com/watch?v=gRKlprUj-I8&list=PLwvDm4VfkdpiLvzZFJI6rVIBtdolrJBVB&index=12 Structs
///
///https://www.youtube.com/watch?v=hCpM95KHb_Q&list=PLwvDm4VfkdpiagxAXCT33Rkwnc5IVhTar&index=36 ScrollView
///https://www.youtube.com/watch?v=tkOnXG-sNks&list=PLwvDm4VfkdphqETTBf-DdjCoAvhai1QpO&index=34&t=1187s
///https://www.youtube.com/watch?v=uK1wKIY49z0&list=PLwvDm4Vfkdphc1LLLjCaEd87BEg07M97y&index=4&t=2s
///https://www.youtube.com/watch?v=pXmBRK1BjLw&list=PLwvDm4Vfkdphc1LLLjCaEd87BEg07M97y&index=12&t=1s
///https://www.youtube.com/watch?v=1GYKyQHVDWw&list=PLwvDm4Vfkdphc1LLLjCaEd87BEg07M97y&index=15&t=1306s
///https://www.youtube.com/watch?v=K91rKH_O8BY&list=PLwvDm4Vfkdphc1LLLjCaEd87BEg07M97y&index=29&t=3s
///https://www.youtube.com/watch?v=lncOFL3Qsns&list=PLwvDm4Vfkdphc1LLLjCaEd87BEg07M97y&index=30
///https://www.youtube.com/watch?v=GZ-hQWMjT0s&list=PLwvDm4VfkdphqETTBf-DdjCoAvhai1QpO&index=63&t=15s&pp=gAQBiAQB
