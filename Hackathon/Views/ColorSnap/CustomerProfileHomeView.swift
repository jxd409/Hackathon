//
//  CustomerProfileHome.swift
//  HackathonLeadFinderApp
//
//  Created by Danielle Beben on 11/3/21.
//

import SwiftUI

struct CustomerProfileHomeView: View {
    var body: some View {
        //Spacer()
        Text("MY PROJECTS")
            .font(.largeTitle)
            .bold()
        Text("Create Project")
            .fontWeight(.bold)
            .font(.title)
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .padding(10)
            .border(Color.blue, width: 5)
        //Spacer()
        Text("MY CURRENT PROJECTS")
            .bold()
        
        //TO DO: "FOR EACH" For PROJECT
        HStack{
            VStack(alignment: .leading) {
                Divider()
                Text("Kitchen")
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
                Text("Living Room")
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
                Text("Upstairs")
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
                Text("Bathroom")
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
                Text("Basement")
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
                Text("Garage")
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
                Text("Exterior")
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
        //Text("MY PROJECTS")
    }
}

struct CustomerProfileHomeView_Previews: PreviewProvider {
    static var previews: some View {
        CustomerProfileHomeView()
    }
}


//TO DO:
//1. "+" Add New Project
//2. Display A List of Projects
//3. Ability to Select a Project
//4. Add a "Find a Pro" -> Navigate to ProContractorView

//PROJECT STATES:
//NONE
//REQUESTED (Gray)
//ACCEPTED (Green)
//REJECTED (Red)
