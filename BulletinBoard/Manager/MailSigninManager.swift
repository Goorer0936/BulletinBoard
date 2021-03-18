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
    typealias CompletionClosure = ((_ result:Int) -> Void)
    
    // UserCreate
    func CreateAccountMail(mailaddress:String,password:String,cmc:@escaping CompletionClosure) {
        FBauth.createUser(withEmail: mailaddress, password: password, completion: { result,err in
            if err == nil{
                print("Create New Acccount")
                cmc(0)
            }else {
                if let errcode = AuthErrorCode(rawValue: err!._code){
                    switch errcode {
                    case .invalidEmail: //メールアドレスフォーマットエラー
                        cmc(1)
                    case .emailAlreadyInUse: //登録済メールアドレス
                        cmc(2)
                    default: 
                        cmc(3)
                    }
                }
            }
        })
    }
}
