//
//  ActivityView.swift
//  FoodPin
//
//  Created by Stephen Lin on 3/9/24.
//

import Foundation
import SwiftUI

struct ActivityView: UIViewControllerRepresentable{
    var activityItems: [Any]
    var applicationActivities: [UIActivity]? = nil
    
    func makeUIViewController(context: Context) -> some UIViewController{
        let activityController = UIActivityViewController(activityItems: activityItems, applicationActivities: applicationActivities)
        return activityController
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context){
        
    }
}
