//
//  ViewModel.swift
//  exampleSwiftOpenAI
//

import Foundation
import SwiftOpenAI

final class ViewModel: ObservableObject {
    @Published var messages:[MessageChatGPT] = [
    .init(text:"Hola !, Soy asistente de soporte tecnico dime en que puedo ayudarte!", role: .system)
    ]
    @Published var currentMessage : MessageChatGPT = .init(text: "", role: .assistant)
    
    var openAI = SwiftOpenAI(apiKey: "Me da error en GIT cuanto dejo la apikey aqui")
   
    func send(message: String) async {
       
        let optionalParameters = ChatCompletionsOptionalParameters(temperature: 0.7, stream: true, maxTokens: 200)
        
        
        await MainActor.run{
            let myMessage = MessageChatGPT(text: message, role: .user)
            self.messages.append(myMessage)
            
            self.currentMessage = MessageChatGPT(text: "", role: .assistant)
            self.messages.append(self.currentMessage)
        }
        do {
            let stream = try await openAI.createChatCompletionsStream(model: .gpt3_5(.turbo), messages: messages, optionalParameters: optionalParameters)
            
            for try await response in stream {
                print(response)
                await onReceive(newMessage: response)
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    @MainActor
    private func onReceive(newMessage: ChatCompletionsStreamDataModel){
        let lastMessage = newMessage.choices[0]
        
        guard lastMessage.finishReason == nil else {
            print("Finished streaming messages")
            return
        }
        
        guard let content = lastMessage.delta?.content else{
            print("message with no content")
            return
        }
        
        currentMessage.text = currentMessage.text + content
        messages[messages.count - 1].text = currentMessage.text
    }
}
