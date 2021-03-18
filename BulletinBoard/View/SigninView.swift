//
//  SigninView.swift
//  BulletinBoard
//
//  Created by Goorer on 2021/03/18.
//

import SwiftUI

struct SigninView: View {
    @State private var ismailviewshow : Bool = false
    var body: some View {
        Button(action: {
            self.ismailviewshow = true
        }, label: {
            Text("CreateButton")
        })
        .sheet(isPresented:self.$ismailviewshow){
            MailSigninView()
        }
    }
}

struct SigninView_Previews: PreviewProvider {
    static var previews: some View {
        SigninView()
    }
}
