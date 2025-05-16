//
//  ThemedButton.swift
//  IRStyleKit
//
//  Created by Ömer Faruk Öztürk on 16.05.2025.
//

import SwiftUI
internal import IRResources

struct ThemedButton<Label: View>: View {
    let action: () -> Void
    @ViewBuilder let label: () -> Label

    var body: some View {
        Button(action: action) { label() }
            .buttonStyle(.borderedProminent)
            .tint(AppColors.primary)
    }
}

///Hedeflenen Videolar:
///https://www.youtube.com/watch?v=pXmBRK1BjLw&list=PLwvDm4Vfkdphc1LLLjCaEd87BEg07M97y&index=12
///https://www.youtube.com/watch?v=MQl4DlDf_5k&list=PLwvDm4Vfkdphc1LLLjCaEd87BEg07M97y&index=4&t=2s
///https://www.youtube.com/watch?v=3QZTGatsI-c&list=PLwvDm4VfkdphPRGbtiY-X3IZsUXFi6595&index=3
///https://www.youtube.com/watch?v=S9eQd76oFHk&list=PLwvDm4VfkdphPRGbtiY-X3IZsUXFi6595&index=4
///https://www.youtube.com/watch?v=vHvb7LH8VuE&list=PLwvDm4VfkdphqETTBf-DdjCoAvhai1QpO&index=19&t=111s
///https://www.youtube.com/watch?v=pN5ZMV_3npE&list=PLwvDm4VfkdphqETTBf-DdjCoAvhai1QpO&index=67
///https://www.youtube.com/watch?v=pN5ZMV_3npE&list=PLwvDm4VfkdphqETTBf-DdjCoAvhai1QpO&index=67
///https://www.youtube.com/watch?v=wSmTbtOwgbE&list=PLwvDm4Vfkdphr2Dl4sY4rS9PLzPdyi8PM&index=14&t=4s
///https://www.youtube.com/watch?v=-JLenSTKEcA&list=PLwvDm4Vfkdphr2Dl4sY4rS9PLzPdyi8PM&index=10&t=911s
///https://www.youtube.com/watch?v=gRKlprUj-I8&list=PLwvDm4VfkdpiLvzZFJI6rVIBtdolrJBVB&index=12
///https://www.youtube.com/watch?v=hCpM95KHb_Q&list=PLwvDm4VfkdpiagxAXCT33Rkwnc5IVhTar&index=36
///https://www.youtube.com/watch?v=tkOnXG-sNks&list=PLwvDm4VfkdphqETTBf-DdjCoAvhai1QpO&index=34&t=1187s
