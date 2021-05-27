//
//  HourlyViewCell.swift
//  weatherBox2
//
//  Created by Ścibor Budkowski on 27/04/2021.
//

import UIKit

class HourlyViewCell: UICollectionViewCell {
    
    public static let identifier = String(describing: self)
    
    private var data: WeatherHourly!
    
    private let cellView: UIView = {
        let view = UIView()
        view.layer.borderColor = UIColor.darkGray.cgColor
        view.layer.borderWidth = 1.0
        view.layer.masksToBounds = true
        view.layer.cornerRadius = 15
        view.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        
        return view
    }()
    
    private let hourLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.AvenirNext(.regular, size: 12)
        label.textAlignment = .center
        
        return label
    }()
    
    private let iconImageView: UIImageView = {
        let view = UIImageView()
        
        return view
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.AvenirNext(.regular, size: 12)
        label.textAlignment = .center
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setupView()
    }
    
    override class func awakeFromNib() {
        super.awakeFromNib()
    }
    
    public func configure(with model: WeatherHourly, dayPart: DayParts) {
        self.data = model
        
        hourLabel.text = data.time.getHourAsString()
        let id = data.weather[0].id
        guard let name = weatherTypes.first(where: { $0.type == id }) else { return }
        let nameWithDayPart = "\(name.icon)_\(dayPart.rawValue.lowercased())"
        
        iconImageView.image = UIImage(named: nameWithDayPart)
        let temperature = Int(data.temperature)
        temperatureLabel.text = String(format: "%d°C", temperature)
    }
    
    private func setupView() {
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor),
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor)
        ])

        contentView.addSubview(cellView)
        contentView.addSubview(hourLabel)
        contentView.addSubview(iconImageView)
        contentView.addSubview(temperatureLabel)
        
        cellView.frame = CGRect(x: 0, y: 0, width: 50, height: contentView.height).integral
        hourLabel.frame = CGRect(x: 0, y: 5, width: contentView.width, height: 12).integral
        iconImageView.frame = CGRect(x: 5, y: hourLabel.bottom + 3, width: contentView.width - 10, height: contentView.width - 10).integral
        temperatureLabel.frame = CGRect(x: 0, y: iconImageView.bottom + 3, width: contentView.width, height: 12).integral
    }
}
