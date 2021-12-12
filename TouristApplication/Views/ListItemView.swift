import SwiftUI

struct ListItemView: View {
    var fetchedData: PlaceData?
    var body: some View {
        VStack(alignment: .leading, spacing: 10, content: {
            Text(fetchedData?.name ?? "No name available")
                .font(.title2)
                .fontWeight(.heavy)
                .foregroundColor(.black)
            
            Text(fetchedData!.infoUrl!)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.gray)
            
            Text(fetchedData!.descriptions!.intro!)
                .font(.caption)
                .fontWeight(.bold)
                .foregroundColor(.gray)
        })
    }
}

struct ListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ListItemView()
    }
}
