//
//  MailSigninManager.swift
//  BulletinBoard
//
//  Created by Goorer on 2021/03/18.
//

import Foundation
import SwiftUI
import FirebaseAuth
    

final class MailManager : ObservableObject {
    let FBauth = FirebaseAuth.Auth.auth()
    
    // UserCreate
    func CreateAccountMail(mailaddress:String,password:String) {
        FBauth.createUser(withEmail: mailaddress, password: password, completion: { result,err in
            if let user = result?.user {
                print("Create New Acccount:\(user)")
            }else {
                print("Error:\(err.debugDescription)")
            }
        })
    }
}
