//
//  File.swift
//  Trigger Tracker
//
//  Created by Tucker Mogren on 3/5/19.
//  Copyright © 2019 TuckerMogren. All rights reserved.
//

import Foundation
import Firebase

class dataBaseCallsTest
{
    var db: Firestore!

    
    func addElement1 ()
    {
        var ref: DocumentReference? = nil
        ref = db.collection("users").addDocument(data: [
            "uid": Auth.auth().currentUser?.uid as Any,
            "firstName": "Tucker",
            "lastName": "Mogren",
            "birthDate": "01241996" ])
        {err in
            if let err = err {
                print("ERROR: \(err) - Trying to add document.")
            }else {
                print("Document was added with ID: \(ref!.documentID)")
            }
        }
    }
    
    func displayData()
    {
        db.collection("users").getDocuments() { (QuerySnapshot, err) in
            if let err = err {
                print("ERROR: \(err)")
            }else {
                for document in QuerySnapshot!.documents {
                    print("\(document.documentID) => \(document.data())");
                }
            }
        }
    }
    

    
}

