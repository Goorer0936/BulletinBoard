//
//  ContentView.swift
//  BulletinBoard
//
//  Created by Goorer on 2021/03/17.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var mailmanager = MailManager()
    var body: some View {
        Button(action: {
            mailmanager.CreateAccountMail(mailaddress: "aaaa@ssss.com", password: "bbbbbbbb")
        }, label: {
            Text("Create")
        })
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
