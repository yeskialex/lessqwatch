import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    var initialTab: Int = 0

    init(initialTab: Int = 0) {
        self.initialTab = initialTab
    }

    var body: some View {
        TabView(selection: $selectedTab) {
            ActiveHikeView()
                .tag(0)

            EmergencyView()
                .tag(1)
        }
        .tabViewStyle(.page)
        .onAppear {
            selectedTab = initialTab
        }
    }
}

struct MainTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
