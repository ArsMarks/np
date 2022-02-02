//
//  EmailSender.swift
//  NP
//
//  Created by Рушан Киньягулов on 21.12.2021.
//

import Foundation

class EmailSender {
    static let email = ""
    static let apiKey = ""
    static let senderName = "naPetrovskom"
    static let senderEmail = "news@evspb.ru"
    static let subject = "New lead"
    static let listId = "20028626"

    static var urlQuote: URLComponents = {
        var resultURL = URLComponents()
        resultURL.scheme = "https"
        resultURL.host = "api.unisender.com"
        resultURL.path = "/ru/api/sendEmail"
        return resultURL
    }()

    static func setupURL(body: String) {
        urlQuote.queryItems = [URLQueryItem(name: "format", value: "json"),
                               URLQueryItem(name: "api_key", value: apiKey),
                               URLQueryItem(name: "email", value: email),
                               URLQueryItem(name: "sender_name", value: senderName),
                               URLQueryItem(name: "sender_email", value: senderEmail),
                               URLQueryItem(name: "subject", value: subject),
                               URLQueryItem(name: "body", value: body),
                               URLQueryItem(name: "list_id", value: listId)]
    }

    static func sendEmail(body: String) {
        setupURL(body: body)
        URLSession.shared.dataTask(with: urlQuote.url!) { data, response, error in
                if let error = error {
                    print("Error took place \(error)")
                    return
                }

                if let response = response as? HTTPURLResponse {
                    print("Response HTTP Status code: \(response.statusCode)")
                }

                if let data = data, let dataString = String(data: data, encoding: .utf8) {
                    print("Response data string:\n \(dataString)")
                }
        }.resume()
    }
}
