import SwiftUI
internal import Combine

struct CallingView: View {
    @State private var currentTime = Date()
    @State private var navigateToMainTab = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private var timeFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter
    }
    
    var body: some View {
        NavigationStack {
            GeometryReader { geometry in
                ZStack {
                    Color.black.ignoresSafeArea()
                    
                    VStack(spacing: geometry.size.height * 0.05) {
                        Spacer()
                        
                        // Calling status
                        VStack(spacing: geometry.size.height * 0.02) {
                            Text("Calling...")
                                .font(.custom("Poppins-SemiBold", size: geometry.size.width * 0.08))
                                .foregroundColor(.gray)
                            
                            Text("119 Emergency Service")
                                .font(.custom("Poppins-SemiBold", size: geometry.size.width * 0.08))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                        }
                        
                        Spacer()
                        Spacer()
                        
                        
                        
                        
                        // Cancel call button (red circle with phone icon)
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                navigateToMainTab = true
                            }
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color.red)
                                    .frame(width: geometry.size.width * 0.3, height: geometry.size.width * 0.3)
                                
                                Image(systemName: "phone.fill")
                                    .font(.system(size: geometry.size.width * 0.1))
                                    .foregroundColor(.white)
                                    .rotationEffect(.degrees(135))
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                        
                        Spacer()
                    }
                    .navigationDestination(isPresented: $navigateToMainTab) {
                        MainTabView(initialTab: 1)
                            .navigationBarBackButtonHidden(true)
                            .transition(.asymmetric(
                                insertion: .move(edge: .trailing).combined(with: .opacity),
                                removal: .move(edge: .leading).combined(with: .opacity)
                            ))
                    }
                }
                .onReceive(timer) { input in
                    currentTime = input
                }
            }
            .navigationBarHidden(true)
        }
    }
    
    struct CallingView_Previews: PreviewProvider {
        static var previews: some View {
            CallingView()
        }
    }
}
