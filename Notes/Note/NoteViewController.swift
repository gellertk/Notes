//
//  NoteViewController.swift
//  Notes
//
//  Created by Кирилл  Геллерт on 01.02.2022.
//

import UIKit
import CoreData

class NoteViewController: UIViewController {
    
    static let buttonsColor = UIColor.systemYellow
    
    private var selectedNote: Note?
    
    init(note: Note? = nil) {
        self.selectedNote = note
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var noteTextView: NoteTextView = {
        let noteView = NoteTextView(note: selectedNote)
        noteView.noteViewControllerDelegate = self
        noteView.translatesAutoresizingMaskIntoConstraints = false
        return noteView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    private func setupView() {
        view.addSubview(noteTextView)
        setupConstraints()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        guard let navigationController = navigationController else {
            return
        }
        navigationController.navigationBar.tintColor = NoteViewController.buttonsColor
        navigationController.navigationBar.prefersLargeTitles = false
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            noteTextView.topAnchor.constraint(equalTo: view.topAnchor),
            noteTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            noteTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            noteTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func deleteNote() {
      
    }
    
}

extension NoteViewController: NoteTextViewDelegate {
    
    @objc private func didTapDoneButton() {
        noteTextView.resignFirstResponder()
    }
    
    @objc func didKeyboardShownOrHiden() {
        if navigationItem.rightBarButtonItem == nil {
            let doneButton = UIBarButtonItem(title: "Готово",
                                             style: .plain,
                                             target: self,
                                             action: #selector(didTapDoneButton))
            
            doneButton.setTitleTextAttributes([
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 17, weight: .semibold)
            ], for: .normal)
            navigationItem.setRightBarButton(doneButton, animated: false)
            navigationItem.rightBarButtonItem?.tintColor = NoteViewController.buttonsColor
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
    private func saveNote() {
        
    }
    
    public func didAction(text: String) {
        selectedNote?.text = text
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        print("text did editing")
    }
}
