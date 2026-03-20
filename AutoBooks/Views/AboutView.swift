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
        }
    }
}

#Preview {
    AboutView()
}
