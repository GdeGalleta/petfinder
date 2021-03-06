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
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.textColor = K.Color.textDark
        label.accessibilityIdentifier = "default"
        return label
    }()

    private let labelDistance: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .right
        label.setContentCompressionResistancePriority(.required, for: .vertical)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.textColor = K.Color.textDark
        label.accessibilityIdentifier = "default"
        return label
    }()

    private let labelTitleAge: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
        label.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.textColor = K.Color.textLight
        label.accessibilityIdentifier = "default"
        label.text = "kAge".localized
        return label
    }()

    private let labelAge: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
        label.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = K.Color.textLight
        label.accessibilityIdentifier = "default"
        return label
    }()

    private let labelTitleGender: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(UILayoutPriority(999), for: .vertical)
        label.setContentCompressionResistancePriority(UILayoutPriority(999), for: .horizontal)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.textColor = K.Color.textLight
        label.accessibilityIdentifier = "default"
        label.text = "kGender".localized
        return label
    }()

    private let labelGender: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(UILayoutPriority(999), for: .vertical)
        label.setContentCompressionResistancePriority(UILayoutPriority(999), for: .horizontal)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = K.Color.textLight
        label.accessibilityIdentifier = "default"
        return label
    }()

    private let labelTitleSize: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(UILayoutPriority(998), for: .vertical)
        label.setContentCompressionResistancePriority(UILayoutPriority(998), for: .horizontal)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 15.0)
        label.textColor = K.Color.textLight
        label.accessibilityIdentifier = "default"
        label.text = "kSize".localized
        return label
    }()

    private let labelSize: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(UILayoutPriority(998), for: .vertical)
        label.setContentCompressionResistancePriority(UILayoutPriority(998), for: .horizontal)
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15.0)
        label.textColor = K.Color.textLight
        label.accessibilityIdentifier = "default"
        return label
    }()

    private lazy var stackFavorite: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.distribution = .fillProportionally
        stack.alignment = .fill
        stack.spacing = 1
        stack.addArrangedSubview(labelName)
        stack.addArrangedSubview(stackInfo)
        stack.addArrangedSubview(labelDistance)
        return stack
    }()

    private lazy var stackInfo: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.spacing = 0
        stack.backgroundColor = K.Color.backgroundDark

        let stackAge = UIStackView(arrangedSubviews: [labelTitleAge, labelAge])
        stackAge.translatesAutoresizingMaskIntoConstraints = false
        stackAge.axis = .vertical
        stack.addArrangedSubview(stackAge)

        let stackGender = UIStackView(arrangedSubviews: [labelTitleGender, labelGender])
        stackGender.translatesAutoresizingMaskIntoConstraints = false
        stackGender.axis = .vertical
        stack.addArrangedSubview(stackGender)

        let stackSize = UIStackView(arrangedSubviews: [labelTitleSize, labelSize])
        stackSize.translatesAutoresizingMaskIntoConstraints = false
        stackSize.axis = .vertical
        stack.addArrangedSubview(stackSize)
        return stack
    }()

    private let imagePhoto: PetfinderImageView = {
        let image = PetfinderImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.image = UIImage(named: "logo_placeholder")
        image.accessibilityIdentifier = "default"
        return image
    }()

    public var cellColor: UIColor = K.Color.backgroundLight {
        didSet {
            viewContainer.backgroundColor = cellColor
            viewContainer.layer.borderColor = cellColor.cgColor
        }
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
        labelDistance.text = "\(String(format: "%.2f", model.distance ?? 0.0)) \("kMilesFromYou".localized)"
        labelAge.text = model.age ?? "-"
        labelGender.text = model.gender ?? "-"
        labelSize.text = model.size ?? "-"

        imagePhoto.image = UIImage(named: "logo_placeholder")
        if let url = model.photo?.url {
            imagePhoto.load(url: url)
        }
    }

    private func setupLayout() {
        backgroundColor = .clear
        selectionStyle = .none

        contentView.addSubview(viewContainer)
        viewContainer.addSubview(imagePhoto)
        viewContainer.addSubview(stackFavorite)

        viewContainer.backgroundColor = cellColor
        viewContainer.layer.borderWidth = 2
        viewContainer.layer.borderColor = cellColor.cgColor
        viewContainer.layer.cornerRadius = 10
        viewContainer.layer.masksToBounds = true

        imagePhoto.layer.borderWidth = 2
        imagePhoto.layer.borderColor = K.Color.backgroundDark.cgColor
        imagePhoto.layer.cornerRadius = 10
        imagePhoto.layer.masksToBounds = true

        stackInfo.layer.cornerRadius = 10
        stackInfo.layer.masksToBounds = true

        NSLayoutConstraint.activate([
            viewContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2),
            viewContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2),
            viewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2),
            viewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2),

            imagePhoto.widthAnchor.constraint(equalToConstant: 100),
            imagePhoto.heightAnchor.constraint(greaterThanOrEqualTo: imagePhoto.widthAnchor),
            imagePhoto.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 2),
            imagePhoto.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor, constant: -2),
            imagePhoto.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor, constant: 2),

            stackFavorite.leadingAnchor.constraint(equalTo: imagePhoto.trailingAnchor, constant: 10),
            stackFavorite.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 2),
            stackFavorite.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor, constant: -2),
            stackFavorite.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -10)
        ])
    }
}
