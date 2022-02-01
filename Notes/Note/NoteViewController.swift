//
//  NoteViewController.swift
//  Notes
//
//  Created by Кирилл  Геллерт on 01.02.2022.
//

import UIKit

class NoteViewController: UIViewController {
    
    private lazy var noteView: UIView = {
        let noteView = NoteView()
        noteView.translatesAutoresizingMaskIntoConstraints = false
        return noteView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.addSubview(noteView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            noteView.topAnchor.constraint(equalTo: view.topAnchor),
            noteView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            noteView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            noteView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
}
