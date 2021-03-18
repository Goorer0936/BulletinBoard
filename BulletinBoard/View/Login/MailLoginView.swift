//
//  MailLoginView.swift
//  BulletinBoard
//
//  Created by Goorer on 2021/03/18.
//

import SwiftUI
import PKHUD

struct MailLoginView: View {
    @ObservedObject private var mailmanager = MailManager()
    @State private var mailaddress : String = ""
    @State private var password : String = ""
    @State private var alerttitle :String = ""
    @State private var alertmessage : String = ""
    @State private var isalert : Bool = false
    var body: some View {
        VStack {
            VStack {
                TextField("メールアドレスを入力してください。", text: self.$mailaddress)
                    .font(.system(size: 15))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none) //自動大文字化停止
                    .multilineTextAlignment(.center)
                Spacer().frame(height:20)
                SecureField("パスワードを入力してください。", text: self.$password)
                    .font(.system(size: 15))
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .autocapitalization(.none)
                    .multilineTextAlignment(.center) //中央よせ
            }.padding(.horizontal, 10.0)
            Spacer().frame(height:80)
            Button(action: {
                if self.mailaddress != "" && self.password != ""{
                    mailmanager.CreateAccountMail(mailaddress: self.mailaddress, password: self.password,cmc: {(result:Int) in
                        if result == 0 {
                            HUD.flash(.labeledSuccess(title: "登録完了", subtitle: ""), delay: 1.0)
                        }else if result == 1 {
                            self.alerttitle = "エラー"
                            self.alertmessage = "メールアドレスの形式が違います。"
                            self.isalert = true
                        }else if result == 2 {
                            self.alerttitle = "エラー"
                            self.alertmessage = "パスワードが間違っています。"
                            self.isalert = true
                        }else if result == 3 {
                            self.alerttitle = "エラー"
                            self.alertmessage = "アカウントが存在しません。"
                            self.isalert = true
                        }else if result == 4 {
                            self.alerttitle = "エラー"
                            self.alertmessage = "アカウントが無効です。"
                            self.isalert = true
                        }else if result == 5 {
                            self.alerttitle = "エラー"
                            self.alertmessage = "エラーが発生しました。\n 時間をおいて再度お試しください。"
                            self.isalert = true
                        }
                    })
                }else {
                    self.alerttitle = "エラー"
                    self.alertmessage = "入力してください。"
                    self.isalert = true
                }
            }, label: {
                Text("ログイン")
            })
            .alert(isPresented:self.$isalert){
                Alert(title: Text(self.alerttitle), message: Text(self.alertmessage), dismissButton: .destructive(Text("OK")))
            }
        }
    }
}

struct MailLoginView_Previews: PreviewProvider {
    static var previews: some View {
        MailLoginView()
    }
}
