//
//  NoteListTableViewCell.swift
//  Notes
//
//  Created by Кирилл  Геллерт on 21.05.2022.
//

import UIKit

class NoteListTableViewCell: UITableViewCell {
    
    static let reuseId = "NoteListTableViewCell"

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with note: Note) {
        var configuration = UIListContentConfiguration.subtitleCell()
        configuration.text = note.title
        configuration.textProperties.font = .preferredFont(forTextStyle: .headline)
        configuration.textProperties.color = .white
        
        configuration.secondaryText = note.desc
        configuration.secondaryTextProperties.color = .gray
        configuration.secondaryTextProperties.font = .preferredFont(forTextStyle: .subheadline)
        
        configuration.textToSecondaryTextVerticalPadding = 4
        
        contentConfiguration = configuration
    }
    
}

private extension NoteListTableViewCell {
    
    func setupView() {
        backgroundColor = K.Color.cellBackground
    }
    
}
