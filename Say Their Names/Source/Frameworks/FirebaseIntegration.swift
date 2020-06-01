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
        let peopleRef = db.collection("people")
        
        peopleRef.fetch { (result: Result<[Person], Error>) in
            completion(result)
        }
    }
    
    func getDonations(person: Person, completion: @escaping (Result<[Donation], Error>) -> Void) {
        let donationIds = person.donations.map( { $0.documentID } )
        let relatedDonationsRef = db.collection("donation").whereField(FieldPath.documentID(), in: donationIds)
        
        relatedDonationsRef.fetch { (result: Result<[Donation], Error>) in
            completion(result)
        }
    }
}


// MARK: - Reusable -

fileprivate extension Query {
    
    func fetch<T: Codable>(_ type: T.Type = T.self, completion: @escaping (Result<[T], Error>) -> Void) {
        
        self.getDocuments { (snapshot: QuerySnapshot?, error) in
            if let error = error {
                completion(.failure(error))
            } else if let snapshot = snapshot {
                let objects = snapshot.documents.compactMap({ (documentSnapshot: QueryDocumentSnapshot) -> T? in
                    print("Parsing data: ", documentSnapshot.data())
                    do {
                        return try documentSnapshot.data(as: T.self)
                    }
                    catch {
                        print(error)
                        return nil
                    }
                })
                completion(.success(objects))
            }
        }
    }
}
