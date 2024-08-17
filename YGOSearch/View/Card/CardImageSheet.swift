import SwiftUI

struct CardImageSheet: View {
    var imageUrl: URL
    @Binding var isPresented: Bool
    @State private var scale: CGFloat = 1.0
    @State private var lastScaleValue: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var currentOffset: CGSize = .zero

    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .topTrailing) {
                AsyncImage(url: imageUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .edgesIgnoringSafeArea(.all)
                        .scaleEffect(scale)
                        .offset(x: offset.width, y: offset.height)
                        .gesture(
                            MagnificationGesture()
                                .onChanged { value in
                                    let delta = value / lastScaleValue
                                    lastScaleValue = value
                                    scale *= delta
                                    let newOffsetX = offset.width * delta
                                    let newOffsetY = offset.height * delta
                                    offset = CGSize(width: newOffsetX, height: newOffsetY)
                                }
                                .onEnded { _ in
                                    lastScaleValue = 1.0
                                }
                        )
                        .simultaneousGesture(
                            DragGesture()
                                .onChanged { gesture in
                                    self.offset = CGSize(width: currentOffset.width + gesture.translation.width,
                                                         height: currentOffset.height + gesture.translation.height)
                                }
                                .onEnded { _ in
                                    self.currentOffset = self.offset
                                }
                        )
                } placeholder: {
                    ProgressView()
                }
                
                Button(action: {
                    self.isPresented = false
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .imageScale(.large)
                        .padding(20)
                }
            }
        }
        .interactiveDismissDisabled()
    }
}
