
import UIKit

final class CountryCell: UITableViewCell {
    private let nameRegionLabel = UILabel()
    private let codeLabel = UILabel()
    private let capitalLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    required init?(coder: NSCoder) { super.init(coder: coder); setup() }

    private func setup() {
        nameRegionLabel.font = .preferredFont(forTextStyle: .headline)
        nameRegionLabel.adjustsFontForContentSizeCategory = true
        nameRegionLabel.numberOfLines = 0

        codeLabel.font = .preferredFont(forTextStyle: .headline)
        codeLabel.adjustsFontForContentSizeCategory = true
        codeLabel.setContentHuggingPriority(.required, for: .horizontal)

        capitalLabel.font = .preferredFont(forTextStyle: .subheadline)
        capitalLabel.textColor = .secondaryLabel
        capitalLabel.adjustsFontForContentSizeCategory = true
        capitalLabel.numberOfLines = 0

        let top = UIStackView(arrangedSubviews: [nameRegionLabel, codeLabel])
        top.axis = .horizontal
        top.alignment = .firstBaseline
        top.distribution = .fill
        top.spacing = 8

        let v = UIStackView(arrangedSubviews: [top, capitalLabel])
        v.axis = .vertical
        v.spacing = 6
        contentView.addSubview(v)
        v.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            v.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            v.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            v.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            v.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }

    func configure(with c: Country) {
        nameRegionLabel.text = "\(c.name), \(c.region)"
        codeLabel.text = c.code
        capitalLabel.text = c.capital
        nameRegionLabel.accessibilityLabel = "\(c.name), region \(c.region)"
        codeLabel.accessibilityLabel = "Code \(c.code)"
        capitalLabel.accessibilityLabel = "Capital \(c.capital)"
    }
}
