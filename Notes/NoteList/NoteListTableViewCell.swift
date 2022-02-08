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
    
    private lazy var separatorLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray.withAlphaComponent(0.1)
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been imple®mented")
    }
    
    private func setupView() {
        contentView.layer.masksToBounds = true
        backgroundColor = UIColor(white: 0.1, alpha: 1)
        [titleCellLabel, textCellLabel, separatorLineView].forEach { view in
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
            textCellLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            
            separatorLineView.heightAnchor.constraint(equalToConstant: 1),
            separatorLineView.topAnchor.constraint(equalTo: topAnchor),
            separatorLineView.leadingAnchor.constraint(equalTo: titleCellLabel.leadingAnchor),
            separatorLineView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    private func updateLabels(_ note: Note) {
        titleCellLabel.text = "\(note.title)"
        textCellLabel.text = "\(note.desc)"
    }
    
    public func setup(_ note: Note, isFirst: Bool, isLast: Bool) {
        updateLabels(note)
        setupCorners(isFirst: isFirst, isLast: isLast)
    }
    
    public func setupCorners(isFirst: Bool, isLast: Bool) {
        if isFirst, isLast {
            layer.cornerRadius = 10
            layer.maskedCorners = [
                .layerMinXMinYCorner,
                .layerMaxXMinYCorner,
                .layerMinXMaxYCorner,
                .layerMaxXMaxYCorner
            ]
            separatorLineView.isHidden = true
        } else if isFirst {
            layer.cornerRadius = 10
            layer.maskedCorners = [
                .layerMinXMinYCorner,
                .layerMaxXMinYCorner,
            ]
            separatorLineView.isHidden = true
        } else if isLast {
            layer.cornerRadius = 10
            layer.maskedCorners = [
                .layerMinXMaxYCorner,
                .layerMaxXMaxYCorner
            ]
            separatorLineView.isHidden = false
        } else {
            layer.cornerRadius = 0
            separatorLineView.isHidden = false
        }
    }
    
}
