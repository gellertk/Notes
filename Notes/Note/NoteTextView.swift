//
//  NoteTextView.swift
//  Notes
//
//  Created by Кирилл  Геллерт on 01.02.2022.
//

import UIKit

protocol NoteTextViewDelegate: UITextViewDelegate {
    func didKeyboardShownOrHiden()
}

class NoteTextView: UITextView {
        
    static let contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        
    private let note: Note?
    private var isKeyboardShown = false
        
    public weak var noteViewControllerDelegate: NoteTextViewDelegate?
    
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
        contentInset = NoteTextView.contentInset
        setupText()
    }
    
    private func setupText() {
        guard let note = note else {
            return
        }
        text = "\(note.text ?? "")"
    }
    
    @objc private func didKeyboardShowOrHide(notification: Notification) {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue,
              let noteViewControllerDelegate = noteViewControllerDelegate else {
            return
        }
        let keyboardViewEndFrame = convert(keyboardValue.cgRectValue, to: window)
        if notification.name == UIResponder.keyboardWillHideNotification, isKeyboardShown {
            noteViewControllerDelegate.didKeyboardShownOrHiden()
            isKeyboardShown = false
        } else if notification.name == UIResponder.keyboardWillShowNotification, !isKeyboardShown {
            contentInset = UIEdgeInsets(top: 5,
                                        left: 5,
                                        bottom: keyboardViewEndFrame.height - safeAreaInsets.bottom,
                                        right: 5)
            noteViewControllerDelegate.didKeyboardShownOrHiden()
            isKeyboardShown = true
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
