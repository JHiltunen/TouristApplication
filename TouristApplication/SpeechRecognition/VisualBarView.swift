import SwiftUI

struct VisualBarView: View {
    var value: CGFloat
    let numberOfSamples: Int = 30
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 20)
                .fill(.black)
                // .fill(LinearGradient(gradient: Gradient(colors: [.red, .purple, .black]), startPoint: .top, endPoint: .bottom))
                .frame(width: (UIScreen.main.bounds.width - CGFloat(numberOfSamples) * 10) / CGFloat(numberOfSamples), height: value)
        }
    }
}
