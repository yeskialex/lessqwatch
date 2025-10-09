import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            ActiveHikeView()
                .tag(0)

            EmergencyView()
                .tag(1)

            FindView()
                .tag(2)
        }
        .tabViewStyle(.page)
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
