//
//  CodingExerciseApp.swift
//  CodingExercise
//
//  Created by Thomas Prezioso Jr on 3/2/21.
//

import SwiftUI

@main
struct CodingExerciseApp: App {
    var body: some Scene {
        WindowGroup {
            SearchForArtist()
                .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
        }
    }
}
extension UIApplication {
    func addTapGestureRecognizer() {
        guard let window = windows.first else { return }
        let tapGesture = UITapGestureRecognizer(target: window, action: #selector(UIView.endEditing))
        tapGesture.requiresExclusiveTouchType = false
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        window.addGestureRecognizer(tapGesture)
    }
}

extension UIApplication: UIGestureRecognizerDelegate {
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true // set to `false` if you don't want to detect tap during other gestures
    }
}
