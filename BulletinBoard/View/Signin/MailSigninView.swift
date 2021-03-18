//
//  MailSigninView.swift
//  BulletinBoard
//
//  Created by Goorer on 2021/03/18.
//

import SwiftUI
import PKHUD

struct MailSigninView: View {
    @ObservedObject private var mailmanager = MailManager()
    @State private var mailaddress : String = ""
    @State private var password : String = ""
    @State private var checkpassword : String = ""
    @State private var alerttitle :String = ""
    @State private var alertmessage : String = ""
    @State private var isalert : Bool = false
    @State private var islogin : Bool = false
    @State private var isloginviewshow : Bool = false
    var body: some View {
        VStack {
            VStack {
                TextField("メールアドレスを入力してください。", text: self.$mailaddress)
                    .font(.system(size: 15))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none) //自動大文字化停止
                    .multilineTextAlignment(.center)
                Spacer().frame(height:20)
                SecureField("8〜16文字のパスワードを入力してください。", text: self.$password)
                    .font(.system(size: 15))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .multilineTextAlignment(.center) //中央よせ
                Spacer().frame(height:20)
                SecureField("同じパスワードを再入力してください", text: self.$checkpassword)
                    .font(.system(size: 15))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .multilineTextAlignment(.center)
            }.padding(.horizontal, 10.0)
            Spacer().frame(height:80)
            Button(action: {
                if self.mailaddress != "" && self.password != "" && self.checkpassword != ""{
                    let result = PasswordChecker()
                    if result == 0 {
                        mailmanager.CreateAccountMail(mailaddress: self.mailaddress, password: self.password,cmc: {(result:Int) in
                            if result == 0 {
                                HUD.flash(.labeledSuccess(title: "登録完了", subtitle: ""), delay: 1.0)
                            }else if result == 1 {
                                self.alerttitle = "エラー"
                                self.alertmessage = "メールアドレスの形式が違います。"
                                self.isalert = true
                            }else if result == 2 {
                                self.alerttitle = "エラー"
                                self.alertmessage = "メールアドレスが登録済です。"
                                self.isalert = true
                                self.islogin = true
                            }else if result == 3 {
                                self.alerttitle = "エラー"
                                self.alertmessage = "エラーが発生しました。\n 時間をおいて再度お試しください。"
                                self.isalert = true
                            }
                        })
                    }
                }else {
                    self.alerttitle = "エラー"
                    self.alertmessage = "入力してください。"
                    self.isalert = true
                }
            }, label: {
                Text("アカウント作成")
            })
            .alert(isPresented:self.$isalert){
                Alert(title: Text(self.alerttitle), message: Text(self.alertmessage), dismissButton: .destructive(Text("OK")))
            }
            Spacer().frame(height:40)
            if self.islogin == true {
                Button(action: {
                    self.isloginviewshow = true
                }, label: {
                    Text("ログイン")
                })
                .sheet(isPresented:self.$isloginviewshow){
                    MailLoginView()
                }
            }
        }
    }
    
    private func PasswordChecker() -> Int{
        var result : Int = 0
        if self.password.count < 8 || self.password.count > 16 {
            self.alerttitle = "エラー"
            self.alertmessage = "8〜16文字でパスワードを入力してください。"
            self.isalert = true
            self.password = ""
            self.checkpassword = ""
            result = 1
        }else if self.password.compare(self.checkpassword) != .orderedSame {
            self.alerttitle = "エラー"
            self.alertmessage = "パスワードが一致しません。"
            self.isalert = true
            self.password = ""
            self.checkpassword = ""
            result = 1
        }
        return result
    }
}

struct MailSigninView_Previews: PreviewProvider {
    static var previews: some View {
        MailSigninView()
    }
}
