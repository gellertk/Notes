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
        label.font = UIFont.systemFont(ofSize: 19, weight: .regular)
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
        backgroundColor = UIColor(white: 0.1, alpha: 1)
        [titleCellLabel, textCellLabel].forEach { view in
            view.translatesAutoresizingMaskIntoConstraints = false
            addSubview(view)
        }
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleCellLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleCellLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            titleCellLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            textCellLabel.leadingAnchor.constraint(equalTo: titleCellLabel.leadingAnchor),
            textCellLabel.topAnchor.constraint(equalTo: titleCellLabel.bottomAnchor, constant: 5),
            textCellLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20)
        ])
    }
    
    private func updateLabels(_ note: Note) {
        titleCellLabel.text = note.title
        textCellLabel.text = "\(note.date.convertToHumanReadableFormat()) \(note.text)"
    }
    
    public func setupCell(_ note: Note, isFirst: Bool, isLast: Bool) {
        updateLabels(note)
        setupCellCorners(isFirst: isFirst, isLast: isLast)
    }
    
    public func setupCellCorners(isFirst: Bool, isLast: Bool) {
        if isFirst, isLast {
            layer.cornerRadius = 10
            layer.maskedCorners = [
                .layerMinXMinYCorner,
                .layerMaxXMinYCorner,
                .layerMinXMaxYCorner,
                .layerMaxXMaxYCorner
            ]
        } else if isFirst {
            layer.cornerRadius = 10
            layer.maskedCorners = [
                .layerMinXMinYCorner,
                .layerMaxXMinYCorner,
            ]
        } else if isLast {
            createSeparatorLineView()
            layer.cornerRadius = 10
            layer.maskedCorners = [
                .layerMinXMaxYCorner,
                .layerMaxXMaxYCorner
            ]
        } else {
            createSeparatorLineView()
        }
    }
    
    //TODO: fix to reusable cell
    private func createSeparatorLineView() {
        let separatorLineView = UIView()
        addSubview(separatorLineView)
        separatorLineView.translatesAutoresizingMaskIntoConstraints = false
        separatorLineView.backgroundColor = .lightGray.withAlphaComponent(0.1)
        NSLayoutConstraint.activate([
            separatorLineView.heightAnchor.constraint(equalToConstant: 1),
            separatorLineView.topAnchor.constraint(equalTo: topAnchor),
            separatorLineView.leadingAnchor.constraint(equalTo: titleCellLabel.leadingAnchor),
            separatorLineView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
