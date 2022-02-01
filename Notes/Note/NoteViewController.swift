//
//  NoteViewController.swift
//  Notes
//
//  Created by Кирилл  Геллерт on 01.02.2022.
//

import UIKit

class NoteViewController: UIViewController {
    
    var note: Note?
    
    init(note: Note? = nil) {
        self.note = note
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var noteView: UIView = {
        let noteView = NoteView(note: note)
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
        setupNavigationController()
    }
    
    private func setupNavigationController() {
        guard let navigationController = navigationController else {
            return
        }
        navigationController.navigationBar.prefersLargeTitles = false
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
