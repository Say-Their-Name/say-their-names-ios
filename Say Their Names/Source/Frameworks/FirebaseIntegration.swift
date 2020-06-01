//
//  FirebaseIntegration.swift
//  Say Their Names
//
//  Created by Marina Gornostaeva on 01/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation
import Firebase

/// Class responsible for working with Firebase
final class FirebaseIntegration {
    
    private var isFirebaseConfigured: Bool = false
    
    init() {
        
    }
    
    private var db: Firestore {
        if isFirebaseConfigured == false {
            FirebaseApp.configure()
            isFirebaseConfigured = true
            
        }
        return Firestore.firestore()
    }
    
    func read() {
        db.collection("people").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())")
                }
            }
        }
    }
}
