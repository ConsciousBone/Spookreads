//
//  AboutView.swift
//  AutoBooks
//
//  Created by Evan Plant on 20/03/2026.
//

import SwiftUI

struct AboutView: View {
    let displayName = Bundle.main.infoDictionary?["CFBundleDisplayName"] as? String ?? "AutoBooks"
    // version stuff, ty searchino!
    let appVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "Unknown"
    let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "Unknown"
    
    @Environment(\.openURL) var openURL
    
    @AppStorage("showTesting") private var showTesting = false
    
    var body: some View {
        List {
            Section { // app icon + version/build text
                HStack { // needed to center the content in the section bc swiftui be strange like that
                    Spacer()
                    HStack {
                        // thanks to this stackoverflow post!!
                        // https://stackoverflow.com/a/79534287
                        Image(uiImage: Bundle.main.icon ?? UIImage())
                            .resizable()
                            .scaledToFill()
                            .clipped()
                            .clipShape(RoundedRectangle(cornerRadius: 26))
                            .frame(width: 100, height: 100, alignment: .center)
                            .padding()
                        
                        VStack {
                            Text(displayName)
                                .font(.title.bold())
                            Text("Version \(appVersion)")
                            Text("Build \(appVersion)")
                        }
                        .padding()
                    }
                    Spacer()
                }
            }
             
            // TODO: add sections crediting HC's Siege and Flavortown + links, this app's GH repo, and contact
            Section {
                Text("Originally developed for Hack Club's Siege, following a theme of \"spooky\", and updated for Hack Club's Flavortown!")
                
                Button {
                    print("hackclub")
                    if #available(iOS 26.0, *) {
                        openURL(URL(string: "https://hackclub.com/")!, prefersInApp: true)
                    } else {
                        openURL(URL(string: "https://hackclub.com/")!)
                    }
                } label: {
                    Label("Learn more about Hack Club", systemImage: "terminal")
                }
                
                Button {
                    print("siege")
                    if #available(iOS 26.0, *) {
                        openURL(URL(string: "https://siege.hackclub.com/")!, prefersInApp: true)
                    } else {
                        openURL(URL(string: "https://siege.hackclub.com/")!)
                    }
                } label: {
                    Label("Learn more about Siege", systemImage: "crown")
                }
                
                Button {
                    print("flavortown")
                    if #available(iOS 26.0, *) {
                        openURL(URL(string: "https://flavortown.hackclub.com/")!, prefersInApp: true)
                    } else {
                        openURL(URL(string: "https://flavortown.hackclub.com/")!)
                    }
                } label: {
                    Label("Learn more about Flavortown", systemImage: "fork.knife")
                }
            }
            
            Section {
                Text("This app is fully open source! You can see its source code on GitHub.")
                
                Button {
                    print("github")
                    if #available(iOS 26.0, *) {
                        openURL(URL(string: "https://github.com/ConsciousBone/AutoBooks")!, prefersInApp: true)
                    } else {
                        openURL(URL(string: "https://github.com/ConsciousBone/AutoBooks")!)
                    }
                } label: {
                    Label("Open GitHub repository", systemImage: "terminal")
                }
            }
            
            Section {
                Text("Found a bug? Have a feature request? Contact me!")
                
                Button {
                    print("email")
                    openURL(URL(string: "mailto:apps@consciousb.one")!)
                } label: {
                    Label("Send an email", systemImage: "envelope")
                }
            }
            
            Section {
                Toggle(isOn: $showTesting) {
                    Label("Show debug tools", systemImage: "ant")
                }
                .tint(.red)
            } footer: {
                Text("You should typically keep this off, but if you need to debug anything or you're curious how the app works, turn it on!")
            }
        }
    }
}

#Preview {
    AboutView()
}
