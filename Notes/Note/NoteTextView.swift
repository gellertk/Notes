//
//  NoteTextView.swift
//  Notes
//
//  Created by Кирилл  Геллерт on 01.02.2022.
//

import UIKit

class NoteTextView: UITextView {
    
    private let note: Note?
    private var isKeyboardShown = false
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(note: Note?) {
        self.note = note
        super.init(frame: CGRect.zero, textContainer: nil)
        setupView()
        addObservers()
    }
    
    private func addObservers() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didKeyboardShowOrHide(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(didKeyboardShowOrHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    private func setupView() {
        font = UIFont.preferredFont(forTextStyle: .body)
        backgroundColor = .black
        textColor = .white
        contentInset = Constants.contentInset
        setupText()
    }
    
    private func setupText() {
        guard let note = note else {
            return
        }
        text = "\(note.text ?? "")"
    }
    
    @objc private func didKeyboardShowOrHide(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else {
            return
        }
        let keyboardViewEndFrame = convert(keyboardValue.cgRectValue, to: window)
        if notification.name == UIResponder.keyboardWillHideNotification, isKeyboardShown {
            isKeyboardShown = false
        } else if notification.name == UIResponder.keyboardWillShowNotification, !isKeyboardShown {
            contentInset.bottom = keyboardViewEndFrame.height - safeAreaInsets.bottom
            isKeyboardShown = true
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
