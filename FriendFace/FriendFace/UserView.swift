//
//  UserView.swift
//  FriendFace
//
//  Created by Christoph on 29.03.24.
//

import SwiftUI

struct UserView: View {
    let user: User
    
    var body: some View {
        VStack(alignment: .leading) {
            //Text(user.name)
            //    .font(.largeTitle)
            Section {
                Text(user.company)
                    .font(.title)
                Text(user.email)
                Text(user.address)
                Text(user.about)
            }
            List(user.friends, id: \.id) { friend in
                Text(friend.name)
            }
        }
        .navigationTitle(user.name)
    }
}


#Preview {
    let defaultUser = User(id: "1", isActive: true, name: "John Doe", age: 30, company: "Example Inc.", email: "john.doe@example.com", address: "123 Main St, Anytown, USA", about: "A short description about John Doe.", registered: Date(), friends: [])
    return UserView(user: defaultUser)
}
