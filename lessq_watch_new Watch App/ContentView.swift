import SwiftUI
internal import Combine

struct ContentView: View {
    // 1. State variable to hold the current time.
    // The view will automatically update when this changes.
    @State private var currentTime = Date()
    @State private var navigateToMain = false

    // 2. A timer that fires every second to update the time.
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    // A helper to format the date into a "HH:mm" string
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }

    var body: some View {
        NavigationStack {
            // Debug: Print available fonts (remove this after testing)
            let _ = print("Available fonts: \(UIFont.familyNames)")
            let _ = print("Poppins variants: \(UIFont.fontNames(forFamilyName: "Poppins"))")
            // ZStack is used to layer views on top of each other (like layers in Photoshop)
            ZStack {
            // MARK: - Background Image
            // This is the bottom layer.
            Image("watch") // Assumes your image is named "watch" in the assets
                .resizable() // Allows the image to be resized
                .scaledToFill() // Fills the screen, preserving aspect ratio
                .ignoresSafeArea() // Extends the image to the screen edges
                .overlay(Color.black.opacity(0.3)) // Adds a dark overlay to improve text readability

            // MARK: - Main Content
            // The central "Welcome" text - now tappable
            Button(action: {
                navigateToMain = true
            }) {
                Text("Welcome.")
                    .font(.custom("Poppins-SemiBold", size: 30))
                    .fontWeight(.bold)
                    .foregroundColor(.white)
            }
            .buttonStyle(PlainButtonStyle())
            }
            .onReceive(timer) { input in
                // 3. This code runs every time the timer fires (every second)
                currentTime = input
            }
            .navigationDestination(isPresented: $navigateToMain) {
                MainTabView()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
