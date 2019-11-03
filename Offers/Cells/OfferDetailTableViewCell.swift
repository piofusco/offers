//
// Created by gideon on 11/3/19.
// Copyright (c) 2019 piofusco. All rights reserved.
//

import UIKit

import SnapKit

class OfferDetailTableViewCell: UITableViewCell {
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.demiBold.font(withSize: 12)
        label.numberOfLines = 0
        return label
    }()

    private var valueLabel: UILabel = {
        let label = UILabel()
        label.font = Fonts.regular.font(withSize: 12)
        label.numberOfLines = 0
        return label
    }()

    override init(style: CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)

        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) is not supported")
    }
}

extension OfferDetailTableViewCell {
    private func setupViews() {
        contentView.addSubview(nameLabel)
        contentView.addSubview(valueLabel)
    }

    private func setupConstraints() {
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.contentView.snp.leading).inset(10)
            make.top.equalTo(self.contentView.snp.top).inset(10)
        }

        valueLabel.snp.makeConstraints { make in
            make.leading.equalTo(self.contentView.snp.leading).inset(10)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.trailing.equalTo(self.contentView.snp.trailing).inset(10)
            make.bottom.equalTo(self.contentView.snp.bottom).inset(10)
        }
    }
}

extension OfferDetailTableViewCell {
    func setContent(forLabel label: String, forValue value: String) {
        nameLabel.text = label
        valueLabel.text = value
    }
}
