//
//  TextMessageView.swift
//  exampleSwiftOpenAI
//
//  Created by Kevin Amaya on 14/11/24.
//

import SwiftUI
import SwiftOpenAI

struct TextMessageView: View {
    var message: MessageChatGPT
    
    var body: some View {
        HStack{
            
            if message.role == .user{
                Spacer()
                Text(message.text)
                    .multilineTextAlignment(.trailing)
                    .foregroundColor(.white)
                    .padding(.all, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.blue)
                    )
                    .frame(maxWidth: 240, alignment: .trailing)
            }else{
                Text(message.text)
                    .multilineTextAlignment(.leading)
                    .foregroundColor(.white)
                    .padding(.all, 10)
                    .background(
                        RoundedRectangle(cornerRadius: 16)
                            .fill(.gray)
                    )
                    .frame(maxWidth: 240, alignment:.leading)
                Spacer()
            }
            
        }
    }
}

struct TextMessageView_Previews: PreviewProvider {
    static let chatGPTMessagge: MessageChatGPT = .init(text: "Hola, estoy aqui para ayudarte", role: .system)
    static let myMessage: MessageChatGPT = .init(text: "que hace swift openai?", role: .user)
    static var previews: some View {
        
        Group{
            TextMessageView(message: self.chatGPTMessagge)
                .previewDisplayName("Chatgtp mensaje")
            TextMessageView(message: self.myMessage)
                .previewDisplayName("Mi mensaje")
        }
        .previewLayout(.sizeThatFits)
    
    }
}
