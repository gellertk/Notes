//
//  NoteViewController.swift
//  Notes
//
//  Created by Кирилл  Геллерт on 01.02.2022.
//

import UIKit
import CoreData

class NoteViewController: UIViewController {
    
    private let buttonsColor = UIColor.systemYellow
    private var note: Note?
    public weak var noteListViewControllerDelegate: NoteListViewControllerDelegate?
    
    init(note: Note? = nil) {
        self.note = note
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var noteTextView: NoteTextView = {
        let noteView = NoteTextView(note: note)
        noteView.noteViewControllerDelegate = self
        noteView.delegate = self
        noteView.translatesAutoresizingMaskIntoConstraints = false
        return noteView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if noteTextView.text.isEmpty {
            noteTextView.becomeFirstResponder()
        }
        navigationController?.navigationBar.prefersLargeTitles = false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupView() {
        view.backgroundColor = .blue
        view.addSubview(noteTextView)
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            noteTextView.topAnchor.constraint(equalTo: view.topAnchor),
            noteTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            noteTextView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            noteTextView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func updateNote() {
        note?.lastUpdated = Date()
        CoreDataManager.shared.save()
        noteListViewControllerDelegate?.refreshNoteList()
    }
    
    private func deleteNote() {
        guard let note = note else {
            return
        }
        noteListViewControllerDelegate?.deleteNote(note: note)
    }
    
    @objc private func didTapDoneButton() {
        noteTextView.resignFirstResponder()
    }
    
}

extension NoteViewController: NoteTextViewDelegate {
    
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
            navigationItem.rightBarButtonItem?.tintColor = buttonsColor
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    
}

extension NoteViewController: UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        note?.text = textView.text
        if note?.text.isEmpty ?? true {
            deleteNote()
        } else {
            updateNote()
        }
    }
        
}
