//
//  FirebaseAuth.swift
//  NP
//
//  Created by Рушан Киньягулов on 10.01.2022.
//

import Foundation
import Firebase

class FirebaseAuth {
    
    func authWithNumber(phoneNumber: String, completion: @escaping (Result<String, Error>) -> Void) {
        PhoneAuthProvider.provider()
            .verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] verificationID, error in
              if let error = error {
                  completion(.failure(error))
                return
              } else {
                  guard let verifyId = verificationID else { return }
                  completion(.success(verifyId))
                  UserDefaults.standard.set(verifyId, forKey: "verificationID")
              }
          }
    }
    
    func checkSms<T: AnyObject>(smsCode: String, verifyID: String, completion: @escaping (Result<T?, Error>) -> Void) {
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verifyID, verificationCode: smsCode)
        Auth.auth().languageCode = "ru"
        Auth.auth().signIn(with: credential) { [weak self] success, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(nil))
            }
        }
    }
    
    func getDisplayName(completion: @escaping (String) -> Void) {
        guard let name = Auth.auth().currentUser?.displayName else { return }
        completion(name)
    }
}

