//
//  AnimalListCell.swift
//  Petfinder
//
//  Created by Dimitri Sopov on 7/3/22.
//

import UIKit

public final class AnimalListCell: UITableViewCell {

    // MARK: - Properties
    public static let identifier = "AnimalListCell"

    private let viewContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .darkGray
        return view
    }()

    private let labelName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 25.0)
        label.textColor = .white
        label.accessibilityIdentifier = "default"
        return label
    }()

    private let imagePhoto: PetfinderImageView = {
        let image = PetfinderImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "animal_placeholder")
        image.accessibilityIdentifier = "default"
        return image
    }()

    public override func layoutSubviews() {
        super.layoutSubviews()
    }

    // MARK: - Initializer
    override public init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AnimalListCell {

    public func setup(with model: AnimalListModel) {
        labelName.text = model.name

        if let url = model.photo?.url {
            imagePhoto.load(url: url)
        }
    }

    private func setupLayout() {
        backgroundColor = .clear
        selectionStyle = .none

        contentView.addSubview(viewContainer)
        viewContainer.addSubview(imagePhoto)
        viewContainer.addSubview(labelName)

        let rColor = UIColor.black
        viewContainer.backgroundColor = rColor
        viewContainer.layer.borderWidth = 2
        viewContainer.layer.borderColor = rColor.cgColor
        viewContainer.layer.cornerRadius = 10
        viewContainer.layer.masksToBounds = true

        NSLayoutConstraint.activate([
            viewContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2.5),
            viewContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2.5),
            viewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2.5),
            viewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2.5),

            imagePhoto.widthAnchor.constraint(equalToConstant: 100),
            imagePhoto.heightAnchor.constraint(equalToConstant: 100),
            imagePhoto.topAnchor.constraint(equalTo: viewContainer.topAnchor),
            imagePhoto.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor),
            imagePhoto.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor),

            labelName.leadingAnchor.constraint(equalTo: imagePhoto.trailingAnchor, constant: 10),
            labelName.topAnchor.constraint(equalTo: viewContainer.topAnchor),
            labelName.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor),
            labelName.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -10)
        ])
    }
}
