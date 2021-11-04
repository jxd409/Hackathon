//
//  ProDashboardView.swift
//  HackathonLeadFinderApp
//
//  Created by Danielle Beben on 11/4/21.
//

import SwiftUI

struct ProDashboardView: View {
    var body: some View {
        Text("CONTRACT STATUS")
            .font(.largeTitle)
            .bold()
        
        //TO DO: "FOR EACH" For PROJECT
        HStack{
            VStack(alignment: .leading) {
                Divider()
                Text("Cindy Amato's Kitchen")
                    .padding(.leading, 30)
                Divider()
            }
            
            Spacer()
            Button(action: {
                // What to perform
            }) {
                // How the button looks like
            }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                //.padding(10)
                .border(Color.green, width: 2)
                .frame(width: 15, height: 15)
                .cornerRadius(40)
                .padding(.bottom, 5)
                .padding(.trailing, 30)
        }
        HStack{
            VStack(alignment: .leading) {
                Text("Doug Evan's - Living Room")
                    .padding(.leading, 30)
                Divider()
            }
            
            Spacer()
            Button(action: {
                // What to perform
            }) {
                // How the button looks like
            }
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .border(Color.green, width: 2)
                .frame(width: 15, height: 15)
                .cornerRadius(40)
                .padding(.bottom, 5)
                .padding(.trailing, 30)
        }
        HStack{
            VStack(alignment: .leading) {
                Text("Kelly Fleming's - Upstairs")
                    .padding(.leading, 30)
                Divider()
            }
            
            Spacer()
            Button(action: {
                // What to perform
            }) {
                // How the button looks like
            }
                .padding()
                .background(Color.yellow)
                .foregroundColor(.white)
                //.padding(10)
                .border(Color.yellow, width: 2)
                .frame(width: 15, height: 15)
                .cornerRadius(40)
                .padding(.bottom, 5)
                .padding(.trailing, 30)
        }
        HStack{
            VStack(alignment: .leading) {
                Text("Carter Jones' Bathroom")
                    .padding(.leading, 30)
                Divider()
            }
            
            Spacer()
            Button(action: {
                // What to perform
            }) {
                // How the button looks like
            }
                .padding()
                .background(Color.yellow)
                .foregroundColor(.white)
                //.padding(10)
                .border(Color.yellow, width: 2)
                .frame(width: 15, height: 15)
                .cornerRadius(40)
                .padding(.bottom, 5)
                .padding(.trailing, 30)
        }
        HStack{
            VStack(alignment: .leading) {
                Text("Kara Minotti's Basement")
                    .padding(.leading, 30)
                Divider()
            }
            
            Spacer()
            Button(action: {
                // What to perform
            }) {
                // How the button looks like
            }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                //.padding(10)
                .border(Color.red, width: 2)
                .frame(width: 15, height: 15)
                .cornerRadius(40)
                .padding(.bottom, 5)
                .padding(.trailing, 30)
        }
        HStack{
            VStack(alignment: .leading) {
                Text("Ali Richardson's - Garage")
                    .padding(.leading, 30)
                Divider()
            }
            
            Spacer()
            Button(action: {
                // What to perform
            }) {
                // How the button looks like
            }
                .padding()
                .background(Color.yellow)
                .foregroundColor(.white)
                //.padding(10)
                .border(Color.yellow, width: 2)
                .frame(width: 15, height: 15)
                .cornerRadius(40)
                .padding(.bottom, 5)
                .padding(.trailing, 30)
        }
        HStack{
            VStack(alignment: .leading) {
                Text("Jim Toniolo's - Exterior")
                    .padding(.leading, 30)
                Divider()
            }
            
            Spacer()
            Button(action: {
                // What to perform
            }) {
                // How the button looks like
            }
                .padding()
                .background(Color.red)
                .foregroundColor(.white)
                //.padding(10)
                .border(Color.green, width: 2)
                .frame(width: 15, height: 15)
                .cornerRadius(40)
                .padding(.bottom, 5)
                .padding(.trailing, 30)
        }
    }
}

struct ProDashboardView_Previews: PreviewProvider {
    static var previews: some View {
        ProDashboardView()
    }
}
