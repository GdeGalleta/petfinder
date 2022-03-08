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
        label.numberOfLines = 2
        label.font = UIFont.boldSystemFont(ofSize: 25.0)
        label.textColor = .black
        label.accessibilityIdentifier = "default"
        return label
    }()

    private let labelTitleAge: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .vertical)
        label.setContentCompressionResistancePriority(UILayoutPriority(1000), for: .horizontal)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.textColor = .white
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
        label.font = UIFont.systemFont(ofSize: 18.0)
        label.textColor = .white
        label.accessibilityIdentifier = "default"
        return label
    }()

    private let labelTitleGender: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(UILayoutPriority(999), for: .vertical)
        label.setContentCompressionResistancePriority(UILayoutPriority(999), for: .horizontal)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.textColor = .white
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
        label.font = UIFont.systemFont(ofSize: 18.0)
        label.textColor = .white
        label.accessibilityIdentifier = "default"
        return label
    }()

    private let labelTitleSize: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.setContentCompressionResistancePriority(UILayoutPriority(998), for: .vertical)
        label.setContentCompressionResistancePriority(UILayoutPriority(998), for: .horizontal)
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 18.0)
        label.textColor = .white
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
        label.font = UIFont.systemFont(ofSize: 18.0)
        label.textColor = .white
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
        return stack
    }()

    private lazy var stackInfo: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .horizontal
        stack.distribution = .fillEqually
        stack.alignment = .center
        stack.spacing = 0
        stack.backgroundColor = .black

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
        image.image = UIImage(named: "logo_paw")
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
        labelAge.text = model.age ?? "-"
        labelGender.text = model.gender ?? "-"
        labelSize.text = model.size ?? "-"

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

        let rColor = UIColor.purple
        viewContainer.backgroundColor = rColor
        viewContainer.layer.borderWidth = 2
        viewContainer.layer.borderColor = rColor.cgColor
        viewContainer.layer.cornerRadius = 10
        viewContainer.layer.masksToBounds = true

        stackInfo.layer.cornerRadius = 10
        stackInfo.layer.masksToBounds = true

        NSLayoutConstraint.activate([
            viewContainer.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 2.5),
            viewContainer.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -2.5),
            viewContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 2.5),
            viewContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -2.5),

            imagePhoto.widthAnchor.constraint(equalToConstant: 100),
            imagePhoto.heightAnchor.constraint(greaterThanOrEqualTo: imagePhoto.widthAnchor),
            imagePhoto.topAnchor.constraint(equalTo: viewContainer.topAnchor),
            imagePhoto.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor),
            imagePhoto.leadingAnchor.constraint(equalTo: viewContainer.leadingAnchor),

            stackFavorite.leadingAnchor.constraint(equalTo: imagePhoto.trailingAnchor, constant: 10),
            stackFavorite.topAnchor.constraint(equalTo: viewContainer.topAnchor, constant: 10),
            stackFavorite.bottomAnchor.constraint(equalTo: viewContainer.bottomAnchor, constant: -10),
            stackFavorite.trailingAnchor.constraint(equalTo: viewContainer.trailingAnchor, constant: -10)
        ])
    }
}
