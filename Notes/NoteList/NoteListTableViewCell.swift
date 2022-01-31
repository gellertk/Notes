//
//  NoteListTableViewCell.swift
//  Notes
//
//  Created by Кирилл  Геллерт on 01.02.2022.
//

import UIKit

class NoteListTableViewCell: UITableViewCell {
    
    private lazy var titleCellLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        return label
    }()
    
    private lazy var textCellLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        return label
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been imple®mented")
    }
    
    private func setupView() {
        backgroundColor = .darkGray
        [titleCellLabel, textCellLabel].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleCellLabel.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            titleCellLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),

            textCellLabel.leadingAnchor.constraint(equalTo: titleCellLabel.leadingAnchor),
            textCellLabel.topAnchor.constraint(equalTo: titleCellLabel.bottomAnchor, constant: 5)
        ])
    }
    
    public func updateLabels(_ note: Note) {
        titleCellLabel.text = note.title
        textCellLabel.text = note.text
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
