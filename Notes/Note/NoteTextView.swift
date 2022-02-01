//
//  NoteTextView.swift
//  Notes
//
//  Created by Кирилл  Геллерт on 01.02.2022.
//

import UIKit

class NoteTextView: UITextView {

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init() {
        super.init(frame: CGRect(x: 0, y: 0, width: 250.0, height: 100.0),
                   textContainer: nil)
        setupView()
    }
    
    private func setupView() {
        //backgroundColor = .white
        backgroundColor = .black.withAlphaComponent(0.1)
        contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        textColor = .white
        setupConstraints()
    }
    
    private func setupConstraints() {
        
    }

}
