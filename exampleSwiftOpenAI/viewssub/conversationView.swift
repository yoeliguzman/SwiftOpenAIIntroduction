//
//  conversationView.swift
//  exampleSwiftOpenAI
//
//  Created by Kevin Amaya on 14/11/24.
//

import SwiftUI

struct conversationView: View {
   
    @EnvironmentObject var viewModel : ViewModel
    
    
    var body: some View {
        ScrollView{
            ForEach(viewModel.messages){
                message in TextMessageView(message: message)
            }
        }
    }
}

struct conversationView_Previews: PreviewProvider {
    static var previews: some View {
        conversationView().environmentObject(ViewModel())
    }
}
