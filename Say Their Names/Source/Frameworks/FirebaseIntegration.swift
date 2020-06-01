//
//  FirebaseIntegration.swift
//  Say Their Names
//
//  Created by Marina Gornostaeva on 01/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift

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
    
    
    // MARK: - Querying data -
    
    // https://firebase.google.com/docs/firestore/query-data/get-data
    
    func getPeople(completion: @escaping (Result<[Person], Error>) -> Void) {
        db.collection("people").getDocuments { (snapshot, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                let people = snapshot.documents.compactMap({ (documentSnapshot: QueryDocumentSnapshot) -> Person? in
                    do {
                        return try documentSnapshot.data(as: Person.self)
                    }
                    catch {
                        print(error)
                        return nil
                    }
                })
                completion(.success(people))
            }
        }
    }
}
