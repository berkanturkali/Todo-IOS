//

import SwiftUI

struct ProfileScreen: View {
    
    @EnvironmentObject var appState: AppState
    
    @StateObject var viewModel = ProfileScreenViewModel()
    
    init() {
        UIPageControl.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack {
            Color.background.ignoresSafeArea()
            ScrollView {
                VStack {
                    ZStack(alignment: .top) {
                        
                        VStack(spacing: 16) {
                            if(viewModel.showLoadingOnTheProfileSection) {
                                ZStack {
                                    TodoLoadingIndicator(size: 50).padding(50)
                                }
                            } else {
                                ProfileImage()
                                VStack(spacing: 16) {
                                    
                                    if let fullName = viewModel.profileInfo?.fullname {
                                        Text(fullName)
                                            .foregroundColor(.text)
                                            .font(.custom(Typeface.medium, size: 18))
                                    }
                                    
                                    if let email = viewModel.profileInfo?.email {
                                        Text(email)
                                            .accentColor(.text)
                                            .foregroundColor(.text)
                                            .font(.custom(Typeface.medium, size: 16))
                                    }
                                    
                                }
                                
                            }
                            
                        }
                        .padding(.vertical, 30)
                        
                        Button(action: {
                            UserDefaults.standard.removeObject(forKey: Constants.tokenKey)
                            UserDefaults.standard.removeObject(forKey: Constants.userIdKey)
                            withAnimation(.easeInOut) {
                                appState.isLoggedIn = false
                            }
                        }) {
                            ZStack {
                                Circle()
                                    .fill(Color.background)
                                    .frame(width: 20, height: 20)
                                    .modifier(ShadowModifier(x: 2, y: 1))
                                Image(systemName: "power.circle")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(Color.text)
                                    .frame(width: 20, height: 20)
                                    .clipShape(Circle())
                                
                            }
                            
                            .frame(maxWidth: .infinity, alignment: .trailing)
                            .padding(.horizontal)
                            .padding(.top)
                        }
                        
                    }
                    
                    .frame(maxWidth: .infinity)
                    .modifier(BackgroundModifier(shadowX: 12, shadowY: 12))
                    .padding(.top)
                    .padding(.horizontal, 32)
                    
                    
                    VStack {
                        Text(LocalizedStrings.statistics)
                            .foregroundColor(.text)
                            .font(.custom(Typeface.bold, size: 25))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Divider()
                        
                        
                        Spacer()
                        
                        ScrollView(.horizontal, showsIndicators: false) {
                            LazyHStack(spacing: 0) {
                                ForEach(viewModel.stats, id: \.self) { stat in
                                    StatisticItem(stat: stat)
                                        .padding(.vertical)
                                        .padding(.horizontal, 20)
                                        .containerRelativeFrame(.horizontal)
                                        .scrollTransition(
                                            .animated,
                                            axis:.horizontal
                                        ) {
                                            content,
                                            phase in
                                            content
                                                .opacity(
                                                    phase.isIdentity ? 1.0 : 0.8
                                                )
                                                .scaleEffect(
                                                    phase.isIdentity ? 1.0 : 0.8
                                                )
                                        }
                                }
                            }
                            .scrollTargetLayout()
                        }
                        .padding(.top, 8)
                        .scrollTargetBehavior(.viewAligned)
                    }
                    .padding(.top, 20)
                    .padding(.horizontal)
                    
                }
            }
        }
    }
}

#Preview {
    ProfileScreen()
        .environmentObject(AppState())
}
