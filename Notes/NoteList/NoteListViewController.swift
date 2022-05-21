//
//  ViewController.swift
//  Notes
//
//  Created by Кирилл  Геллерт on 30.01.2022.
//

import UIKit

protocol NoteListViewControllerDelegate: AnyObject {
    func refreshNoteList()
    func deleteNote(note: Note)
}

class NoteListViewController: UIViewController {
    
    private var noteList: [Note] = [] {
        didSet {
            if let label = notesCountLabel.customView as? UILabel {
                label.text = "\(noteList.count) \(noteList.count.inclineEnding())"
            }
        }
    }
    
    private lazy var searchController: UISearchController = {
        let searchController = UISearchController()
        searchController.searchBar.delegate = self
        searchController.delegate = self
        searchController.searchBar.placeholder = "Поиск"
        searchController.searchBar.searchTextField.backgroundColor = .clear
        
        return searchController
    }()
    
    private lazy var noteListTableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .insetGrouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NoteListTableViewCell.self, forCellReuseIdentifier: NoteListTableViewCell.reuseId)
        tableView.separatorColor = .white.withAlphaComponent(0.15)
        tableView.backgroundColor = .black.withAlphaComponent(0.1)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    private let notesCountLabel: UIBarButtonItem = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
        label.font = .preferredFont(forTextStyle: .footnote)
        label.textColor = .white
        
        return UIBarButtonItem(customView: label)
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillNotes()
        setupView()
    }
    
    private func fillNotes() {
        if UserDefaults.isFirstLaunch() {
            let welcomeNote = createNote()
            welcomeNote.text = K.String.firstNoteText
        } else {
            noteList = CoreDataManager.shared.getNotes()
        }
    }
    
    private func setupView() {
        view.backgroundColor = .black
        view.addSubview(noteListTableView)
        setupNavigationBar()
        setupToolbar()
        setupConstraints()
    }
    
    private func setupNavigationBar() {
        guard let navigationController = navigationController else {
            return
        }
        title = K.String.noteTitle
        navigationItem.searchController = searchController
        navigationController.navigationBar.barStyle = .black
        navigationController.navigationBar.prefersLargeTitles = true
        navigationController.navigationBar.tintColor = K.Color.buttonTint
        navigationItem.setRightBarButton(UIBarButtonItem(image: UIImage(systemName: "ellipsis.circle"),
                                                         style: .plain,
                                                         target: self,
                                                         action: nil), animated: false)
    }
    
    @objc private func didTapAddButton() {
        toNoteViewController(note: createNote())
    }
    
    private func createNote() -> Note {
        let note = CoreDataManager.shared.createNote()
        noteList.insert(note, at: 0)
        noteListTableView.insertRows(at: [IndexPath(row: 0, section: 0)], with: .automatic)
        
        return note
    }
    
    private func toNoteViewController(note: Note) {
        guard let navigationController = navigationController else {
            return
        }
        let noteViewController = NoteViewController(note: note)
        noteViewController.noteListViewControllerDelegate = self
        navigationController.pushViewController(noteViewController, animated: true)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            noteListTableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            noteListTableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            noteListTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: -5),
            noteListTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 5)
        ])
    }
    
    private func indexForNote(note: Note, in list: [Note]) -> IndexPath {
        let row = Int(list.firstIndex(where: { $0 == note }) ?? 0)
        
        return IndexPath(row: row, section: 0)
    }
    
    private func setupToolbar() {
        navigationController?.toolbar.barTintColor = .black
        navigationController?.toolbar.tintColor = K.Color.buttonTint

        navigationController?.isToolbarHidden = false
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: self, action: nil)
        
        let addButton = UIBarButtonItem(image: UIImage(systemName: "square.and.pencil"),
                                        style: .plain,
                                        target: self,
                                        action: #selector(didTapAddButton))
        toolbarItems = [flexibleSpace, notesCountLabel, flexibleSpace, addButton]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.toolbar.isTranslucent = true
    }
    
}

extension NoteListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return noteList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoteListTableViewCell.reuseId,
                                                       for: indexPath) as? NoteListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.configure(with: noteList[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        noteListTableView.deselectRow(at: indexPath, animated: true)
        toNoteViewController(note: noteList[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            deleteNote(note: noteList[indexPath.row])
        }
    }
    
    func search(_ text: String?) {
        noteList = CoreDataManager.shared.getNotes(filter: text)
        noteListTableView.reloadData()
    }
        
}

extension NoteListViewController: NoteListViewControllerDelegate {
    
    func deleteNote(note: Note) {
        let indexPath = indexForNote(note: note, in: noteList)
        noteList.remove(at: indexForNote(note: note, in: noteList).row)
        noteListTableView.deleteRows(at: [indexPath], with: .automatic)
        CoreDataManager.shared.deleteNote(note)
    }
    
    func refreshNoteList() {
        noteList = noteList.sorted { $0.lastUpdated > $1.lastUpdated }
        noteListTableView.reloadData()
    }
    
}

extension NoteListViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let text = searchText == "" ? nil : searchText
        search(text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        search(nil)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        search(searchBar.text)
    }
    
}
