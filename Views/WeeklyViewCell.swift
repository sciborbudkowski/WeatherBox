//
//  WeeklyViewCell.swift
//  weatherBox2
//
//  Created by Ścibor Budkowski on 20/05/2021.
//

import UIKit

struct WeeklyViewModel {
    
    public let dayOfWeek: String
    public let rainProbability: String
    public let wind: String
    public let dayTemperature: String
    public let nightTemperature: String
    public let weatherIcon: String
    public let windIcon: String
}

class WeeklyViewCell: UICollectionViewCell {
    
    public static let identifier = String(describing: self)
    
    private var data: WeeklyViewModel!
    
    private let dayOfWeekLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.AvenirNext(.regular, size: 12)
        label.textAlignment = .center
        
        return label
    }()
    
    private let rainProbabilityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.AvenirNext(.regular, size: 12)
        label.textAlignment = .right
        
        return label
    }()
    
    private let windLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.AvenirNext(.regular, size: 12)
        label.textAlignment = .right
        
        return label
    }()
    
    private let dayTemperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.AvenirNext(.regular, size: 12)
        label.textAlignment = .center
        
        return label
    }()
    
    private let nightTemperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .gray
        label.font = UIFont.AvenirNext(.regular, size: 12)
        label.textAlignment = .center
        
        return label
    }()
    
    private let cellHView: UIStackView = {
        let view = UIStackView()
        view.alignment = .center
        view.distribution = .fillEqually
        view.axis = .horizontal
        
        return view
    }()
    
    private let cellWindView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private let cellRainView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private let windIcon: UIImageView = {
        let view = UIImageView()
        
        return view
    }()

    private let weatherIcon: UIImageView = {
        let view = UIImageView()
        
        return view
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
    
    private func setupView() {
        contentView.addSubview(cellHView)
        
        cellHView.frame = CGRect(x: 0, y: 0, width: contentView.width, height: contentView.height).integral
        
        cellWindView.addSubview(windLabel)
        cellWindView.addSubview(windIcon)
        
        cellWindView.translatesAutoresizingMaskIntoConstraints = false
        cellWindView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        cellWindView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        windLabel.translatesAutoresizingMaskIntoConstraints = false
        windLabel.leftAnchor.constraint(equalTo: cellWindView.leftAnchor).isActive = true
        windLabel.topAnchor.constraint(equalTo: cellWindView.topAnchor).isActive = true
        windLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        windIcon.translatesAutoresizingMaskIntoConstraints = false
        windIcon.widthAnchor.constraint(equalToConstant: 15).isActive = true
        windIcon.heightAnchor.constraint(equalToConstant: 15).isActive = true
        windIcon.leftAnchor.constraint(equalTo: windLabel.rightAnchor, constant: 5).isActive = true

        cellRainView.addSubview(rainProbabilityLabel)
        cellRainView.addSubview(weatherIcon)
        
        cellRainView.translatesAutoresizingMaskIntoConstraints = false
        cellRainView.widthAnchor.constraint(equalToConstant: 70).isActive = true
        cellRainView.heightAnchor.constraint(equalToConstant: 15).isActive = true
        rainProbabilityLabel.translatesAutoresizingMaskIntoConstraints = false
        rainProbabilityLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        rainProbabilityLabel.topAnchor.constraint(equalTo: cellRainView.topAnchor).isActive = true
        rainProbabilityLabel.leftAnchor.constraint(equalTo: cellRainView.leftAnchor).isActive = true
        weatherIcon.translatesAutoresizingMaskIntoConstraints = false
        weatherIcon.widthAnchor.constraint(equalToConstant: 15).isActive = true
        weatherIcon.heightAnchor.constraint(equalToConstant: 15).isActive = true
        weatherIcon.leftAnchor.constraint(equalTo: rainProbabilityLabel.rightAnchor, constant: 5).isActive = true
        
        cellHView.addArrangedSubview(dayOfWeekLabel)
        cellHView.addArrangedSubview(cellRainView)
        cellHView.addArrangedSubview(cellWindView)
        cellHView.addArrangedSubview(dayTemperatureLabel)
        cellHView.addArrangedSubview(nightTemperatureLabel)
    }
    
    public func configure(with model: WeeklyViewModel) {
        self.data = model
        
        dayOfWeekLabel.text = data.dayOfWeek
        rainProbabilityLabel.text = data.rainProbability
        windLabel.text = data.wind
        dayTemperatureLabel.text = "\(data.dayTemperature)°C"
        nightTemperatureLabel.text = "\(data.nightTemperature)°C"
        windIcon.image = UIImage(named: data.windIcon)
        weatherIcon.image = UIImage(named: data.weatherIcon)
    }
}
