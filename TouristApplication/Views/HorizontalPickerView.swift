import SwiftUI

/* Based on Jonathan Zufi's custom picker view: https://medium.com/@shrineofapple/a-custom-replacement-for-the-horizontal-pickercontrol-f38fb05d22d5
 https://github.com/jonathanzufi/CustomPickerSwiftUI
 */

// View that shows all categories/tags
struct HorizontalPickerView: View {
    
    @Binding var selectedIndex: Int
    @State private var currentIndex: Int = 0
    @Namespace private var ns
    
    init(selectedIndex: Binding<Int>) {
        _selectedIndex = selectedIndex
    }
    var body: some View {
        VStack(alignment: .center) {
            
            ScrollView(.horizontal, showsIndicators: false) {
                
                ScrollViewReader { scrollView in
                    
                    HStack(spacing: 35) {
                        
                        ForEach(tags, id: \.self) { item in
                            if item.id == currentIndex {
                                ZStack() {
                                    Text(item.name)
                                        .bold()
                                        .layoutPriority(1)
                                    VStack() {
                                        Rectangle().frame(height: 2)
                                            .padding(.top, 20)
                                    }
                                    // animation of the highlighted line
                                    .matchedGeometryEffect(id: "animation", in: ns)
                                }
                            } else {
                                Text(item.name)
                                    .onTapGesture {
                                        withAnimation {
                                            currentIndex = item.id
                                            selectedIndex = currentIndex
                                            // scroll to correct item to keep it in view
                                            scrollView.scrollTo(item)
                                        }
                                    }
                            }
                        }
                    }
                    .padding(.leading, 10)
                    .padding(.trailing, 20)
                }
            }
        }
        .padding()
    }
}

struct HorizontalPickerView_Previews: PreviewProvider {
    static var previews: some View {
        HorizontalPickerView(selectedIndex: .constant(0))
    }
}
