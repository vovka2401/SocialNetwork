import SwiftUI

struct MainMessagesView: View {
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("Custom nav bar")
                    Spacer()
                }
                ScrollView {
                    ForEach(1...10, id: \.self) { num in
                        VStack {
                            HStack(spacing: 16) {
                                Image(systemName: "person.fill")
                            }
                        }
                    }
                }
            }
        }
    }
}

struct MainMessagesView_Previews: PreviewProvider {
    static var previews: some View {
        MainMessagesView()
    }
}
