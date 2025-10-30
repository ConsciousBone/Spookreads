//
//  OpenAI.swift
//  Spookreads
//
//  Created by Evan Plant on 30/10/2025.
//

import Foundation

private enum APIConfig { // user changable thingy
    private static let key = "apiURL"
    private static let defaultURL = "https://leafyapi.consciousb.one/v1/chat/completions"
    
    static var apiURLString: String {
        get {
            UserDefaults.standard.string(forKey: key) ?? defaultURL
        }
        set {
            UserDefaults.standard.set(newValue, forKey: key)
        }
    }
}

private struct ChatRequest: Encodable {
    let model: String
    let messages: [Message]
    
    struct Message: Encodable {
        let role: String
        let content: [Content]
    }
    
    struct Content: Encodable {
        let type: String
        let text: String?
    }
}

let proxySecret: String = {
    guard let url = Bundle.main.url(forResource: "proxysecret", withExtension: "txt"),
          let data = try? Data(contentsOf: url),
          let s = String(data: data, encoding: .utf8)?
            .trimmingCharacters(in: .whitespacesAndNewlines),
          !s.isEmpty else {
        fatalError("proxysecret.txt missing or empty")
    }
    return s
}()

func cleanAIJSON(_ text: String) -> String {
    text
        .replacingOccurrences(of: "```json", with: "")
        .replacingOccurrences(of: "```", with: "")
        .trimmingCharacters(in: .whitespacesAndNewlines)
}

func sendRequestToAI(
    prompt: String,
    completion: @escaping (Result<String, Error>) -> Void
) {
    let reqBody = ChatRequest(
        model: "gpt-4o-mini",
        messages: [
            .init(
                role: "user",
                content: [
                    .init(
                        type: "text",
                        text: prompt
                    )
                ]
            )
        ]
    )
    
    let encoder = JSONEncoder()
    guard let json = try? encoder.encode(reqBody) else {
        completion(.failure(NSError(
            domain: "Spookreads",
            code: 2,
            userInfo: [NSLocalizedDescriptionKey: "json encoding failed"]
        )))
        return
    }
    
    // send the stuffs to closedai
    var req = URLRequest(url: URL(string: APIConfig.apiURLString)!)
}
