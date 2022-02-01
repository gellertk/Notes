//
//  NoteView.swift
//  Notes
//
//  Created by Кирилл  Геллерт on 01.02.2022.
//

import UIKit

class NoteView: UIView {
    
    private lazy var noteTextView: UITextView = {
       let textView = NoteTextView()
       return textView
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        [noteTextView].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            noteTextView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            noteTextView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            noteTextView.leadingAnchor.constraint(equalTo: leadingAnchor),
            noteTextView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

}