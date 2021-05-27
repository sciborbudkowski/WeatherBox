//
//  HomeViewController.swift
//  weatherBox2
//
//  Created by Ścibor Budkowski on 26/04/2021.
//

import UIKit
import Kingfisher
import SafariServices
import Jelly
import MapKit

class HomeViewController: UIViewController {
    
    private let timeout: Double = 360
    private let unsplashService = UnsplashService()
    private let weatherService = OpenWeatherService()
    
    private var placeName: String = ""
    private var location: CLLocation?
    private var weather: OpenWeather?
    private var airQuality: AirQuality?

    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.clipsToBounds = true
        view.isScrollEnabled = true
        view.backgroundColor = .clear
        view.isDirectionalLockEnabled = true
        
        return view
    }()
    
    private let backgroundImageView: UIImageView = {
        let view = UIImageView()
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
        
        let blurEffect = UIBlurEffect(style: .systemMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.alpha = 0.8
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        
        return view
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        
        return view
    }()
    
    private let infoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "info.circle"), for: .normal)
        button.tintColor = .white
        
        return button
    }()
    
    private let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.AvenirNext(.regular, size: 20)
        label.textAlignment = .center
        
        return label
    }()
    
    private let settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "line.horizontal.3.circle"), for: .normal)
        button.tintColor = .white
        
        return button
    }()
    
    private let weatherLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.AvenirNext(.regular, size: 12)
        label.textAlignment = .center
        
        return label
    }()
    
    private let airLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.AvenirNext(.regular, size: 12)
        label.textAlignment = .center
        
        return label
    }()
    
    private let weatherIcon: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        
        return view
    }()
    
    private let airIcon: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.layer.masksToBounds = true
        
        return view
    }()
    
    private let temperatureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.AvenirNext(.ultraLight, size: 80)
        label.textAlignment = .center
        
        return label
    }()
    
    private let aqiLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.AvenirNext(.ultraLight, size: 80)
        label.textAlignment = .center
        
        return label
    }()
    
    private let descriptionLabelsHStackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .center
        view.distribution = .fillEqually
        view.axis = .horizontal
        
        return view
    }()
    
    private let iconsHStackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .center
        view.distribution = .fillEqually
        view.axis = .horizontal
        
        return view
    }()
    
    private let valuesHStackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .center
        view.distribution = .fillEqually
        view.axis = .horizontal
        
        return view
    }()
    
    private let hourlyView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.estimatedItemSize = CGSize(width: 50, height: 80)
        layout.itemSize = CGSize(width: 50, height: 80)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        layout.scrollDirection = .horizontal
        
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.register(HourlyViewCell.self, forCellWithReuseIdentifier: HourlyViewCell.identifier)
        view.backgroundColor = .clear
        
        return view
    }()
    
    private let windHStackView: UIStackView = {
        let view = UIStackView()
        view.alignment = .center
        view.distribution = .fill
        view.axis = .horizontal
        
        return view
    }()
    
    private let windIcon: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.layer.masksToBounds = true
        
        return view
    }()
    
    private let compassView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private let compassIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "compass")
        view.contentMode = .scaleAspectFit
        view.layer.masksToBounds = true
        
        return view
    }()
    
    private let needleIcon: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "needle")
        view.contentMode = .scaleAspectFit
        view.layer.masksToBounds = true
        
        return view
    }()
    
    private let windDetailsHView: UIStackView = {
        let view = UIStackView()
        view.alignment = .center
        view.distribution = .fill
        view.axis = .vertical
        
        return view
    }()

    private let windNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.AvenirNext(.regular, size: 12)
        label.textAlignment = .center
        
        return label
    }()
    
    private let windSpeedLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.AvenirNext(.regular, size: 12)
        label.textAlignment = .center
        
        return label
    }()
    
    private let visibilityLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.AvenirNext(.regular, size: 12)
        label.textAlignment = .center
        
        return label
    }()
    
    private let pressureLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.AvenirNext(.regular, size: 12)
        label.textAlignment = .center
        
        return label
    }()
    
    private let windDirectionLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.AvenirNext(.regular, size: 12)
        label.textAlignment = .center
        
        return label
    }()
    
    private let weeklyView: UICollectionView = {
        let layout = UICollectionViewFlowLayout.init()
        layout.estimatedItemSize = CGSize(width: 50, height: 80)
        layout.itemSize = CGSize(width: 50, height: 80)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = 2
        layout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        view.register(WeeklyViewCell.self, forCellWithReuseIdentifier: WeeklyViewCell.identifier)
        view.backgroundColor = .clear
        
        return view
    }()
    
    private let hLine1: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        
        return view
    }()
    
    private let hLine2: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        
        return view
    }()
    
    private let hLine3: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        
        return view
    }()
    
    private let hLine4: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        
        return view
    }()
    
    private let hLine5: UIView = {
        let view = UIView()
        view.backgroundColor = .darkGray
        
        return view
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationService.instance.determineLocationCoords { [weak self](result) in
            guard let location = result else { print("2"); return }
            self?.location = location
            
            self?.weatherService.getForecast(location, completion: { (result, error) in
                guard let weather = result else { print("3"); return }
                self?.weather = weather
                self?.hourlyView.reloadData()
                self?.weeklyView.reloadData()
            })
        }
        
        LocationService.instance.determineLocationName { [weak self](result) in
            guard let result = result else {
                self?.placeName = ""
                self?.locationLabel.text = ""
                return
            }
            
            let name = "\(result.locality ?? ""), \(result.country ?? "")"
            self?.placeName = name
            self?.locationLabel.text = name
        }
        
        view.backgroundColor = .black
        
        hourlyView.delegate = self
        hourlyView.dataSource = self
        weeklyView.delegate = self
        weeklyView.dataSource = self
        scrollView.delegate = self
        
        setupView()
        setupTimer()
        loadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //scrollView.contentSize =
        //scrollView.contentSize = CGSize(width: contentView.width, height: contentView.height)
        scrollView.frame = view.bounds
        scrollView.contentSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height + 100)
        scrollView.contentInsetAdjustmentBehavior = .never
        scrollView.showsVerticalScrollIndicator = false
    }
    
    private func setupView() {
        let window = UIApplication.shared.windows[0]
        let safeY = window.safeAreaInsets.top
        
        view.addSubview(backgroundImageView)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.frame = view.bounds
        
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundImageView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20).isActive = true
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: safeY).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.heightAnchor.constraint(equalTo: scrollView.heightAnchor).isActive = true
        
        contentView.addSubview(infoButton)
        contentView.addSubview(locationLabel)
        contentView.addSubview(settingsButton)
        
        infoButton.translatesAutoresizingMaskIntoConstraints = false
        infoButton.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        infoButton.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        infoButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        infoButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        settingsButton.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        settingsButton.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        settingsButton.widthAnchor.constraint(equalToConstant: 20).isActive = true
        settingsButton.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        locationLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        locationLabel.leftAnchor.constraint(equalTo: infoButton.rightAnchor, constant: 10).isActive = true
        locationLabel.rightAnchor.constraint(equalTo: settingsButton.leftAnchor, constant: -10).isActive = true
        locationLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        
        contentView.addSubview(descriptionLabelsHStackView)
        descriptionLabelsHStackView.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabelsHStackView.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 20).isActive = true
        descriptionLabelsHStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        descriptionLabelsHStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        
        descriptionLabelsHStackView.addArrangedSubview(weatherLabel)
        descriptionLabelsHStackView.addArrangedSubview(airLabel)
        
        contentView.addSubview(iconsHStackView)
        iconsHStackView.translatesAutoresizingMaskIntoConstraints = false
        iconsHStackView.topAnchor.constraint(equalTo: descriptionLabelsHStackView.bottomAnchor, constant: 10).isActive = true
        iconsHStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor).isActive = true

        iconsHStackView.addArrangedSubview(weatherIcon)
        iconsHStackView.addArrangedSubview(airIcon)
        
        weatherIcon.heightAnchor.constraint(equalToConstant: 100).isActive = true
        airIcon.heightAnchor.constraint(equalToConstant: 100).isActive = true

        contentView.addSubview(valuesHStackView)
        valuesHStackView.translatesAutoresizingMaskIntoConstraints = false
        valuesHStackView.topAnchor.constraint(equalTo: iconsHStackView.bottomAnchor, constant: 10).isActive = true
        valuesHStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        valuesHStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true

        valuesHStackView.addArrangedSubview(temperatureLabel)
        valuesHStackView.addArrangedSubview(aqiLabel)
        
        contentView.addSubview(hLine1)
        hLine1.translatesAutoresizingMaskIntoConstraints = false
        hLine1.topAnchor.constraint(equalTo: valuesHStackView.bottomAnchor).isActive = true
        hLine1.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        hLine1.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        hLine1.heightAnchor.constraint(equalToConstant: 1).isActive = true

        contentView.addSubview(hourlyView)
        hourlyView.translatesAutoresizingMaskIntoConstraints = false
        hourlyView.topAnchor.constraint(equalTo: hLine1.bottomAnchor, constant: 10).isActive = true
        hourlyView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        hourlyView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        hourlyView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        contentView.addSubview(hLine2)
        hLine2.translatesAutoresizingMaskIntoConstraints = false
        hLine2.topAnchor.constraint(equalTo: hourlyView.bottomAnchor, constant: 10).isActive = true
        hLine2.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        hLine2.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        hLine2.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        contentView.addSubview(windHStackView)
        windHStackView.translatesAutoresizingMaskIntoConstraints = false
        windHStackView.topAnchor.constraint(equalTo: hLine2.bottomAnchor, constant: 10).isActive = true
        windHStackView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        windHStackView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        windHStackView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        
        windIcon.translatesAutoresizingMaskIntoConstraints = false
        windIcon.widthAnchor.constraint(equalToConstant: 80).isActive = true
        windIcon.heightAnchor.constraint(equalToConstant: 80).isActive = true
        windIcon.image = UIImage(named: "wind_freshBreeze")
        
        windDetailsHView.translatesAutoresizingMaskIntoConstraints = false
        windDetailsHView.addArrangedSubview(windNameLabel)
        windDetailsHView.addArrangedSubview(windSpeedLabel)
        windDetailsHView.addArrangedSubview(visibilityLabel)
        windDetailsHView.addArrangedSubview(pressureLabel)
        windDetailsHView.addArrangedSubview(windDirectionLabel)
        
        compassView.translatesAutoresizingMaskIntoConstraints = false
        compassView.addSubview(compassIcon)
        compassView.addSubview(needleIcon)
        compassView.widthAnchor.constraint(equalToConstant: 80).isActive = true
        compassView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        compassIcon.translatesAutoresizingMaskIntoConstraints = false
        compassIcon.widthAnchor.constraint(equalToConstant: 80).isActive = true
        compassIcon.heightAnchor.constraint(equalToConstant: 80).isActive = true
        needleIcon.translatesAutoresizingMaskIntoConstraints = false
        needleIcon.widthAnchor.constraint(equalToConstant: 50).isActive = true
        needleIcon.heightAnchor.constraint(equalToConstant: 50).isActive = true
        needleIcon.centerXAnchor.constraint(equalTo: compassIcon.centerXAnchor).isActive = true
        needleIcon.centerYAnchor.constraint(equalTo: compassIcon.centerYAnchor).isActive = true

        windHStackView.addArrangedSubview(windIcon)
        windHStackView.addArrangedSubview(windDetailsHView)
        windHStackView.addArrangedSubview(compassView)
        
        contentView.addSubview(hLine3)
        hLine3.translatesAutoresizingMaskIntoConstraints = false
        hLine3.topAnchor.constraint(equalTo: windHStackView.bottomAnchor, constant: 10).isActive = true
        hLine3.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        hLine3.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        hLine3.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        contentView.addSubview(weeklyView)
        weeklyView.translatesAutoresizingMaskIntoConstraints = false
        weeklyView.topAnchor.constraint(equalTo: hLine3.bottomAnchor, constant: 10).isActive = true
        weeklyView.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        weeklyView.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        weeklyView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        
        contentView.addSubview(hLine4)
        hLine4.translatesAutoresizingMaskIntoConstraints = false
        hLine4.topAnchor.constraint(equalTo: weeklyView.bottomAnchor, constant: 10).isActive = true
        hLine4.leftAnchor.constraint(equalTo: contentView.leftAnchor).isActive = true
        hLine4.rightAnchor.constraint(equalTo: contentView.rightAnchor).isActive = true
        hLine4.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    
    private func setupTimer() {
        Timer.scheduledTimer(withTimeInterval: timeout, repeats: true) { [weak self] _ in
            self?.loadData()
        }
    }
    
    private func loadData() {
        reloadBackgroundImage()
        reloadWeatherData()
        reloadAqiData()
    }
    
    private func reloadBackgroundImage() {
        unsplashService.getPhoto { [weak self] (photo, error) in
            guard let self = self else { print("self"); return }
            if let _ = error { print("error: \(error!)"); return }
            guard let photo = photo else { print("photo"); return }
            
            let url = URL(string: photo.urls.full)!
            let resource = ImageResource(downloadURL: url)
            UIView.animate(withDuration: 1.0) {
                self.backgroundImageView.alpha = 0.0
            }
            KingfisherManager.shared.retrieveImage(with: resource) { (result) in
                switch result {
                case .failure:
                    return
                case .success(let value):
                    self.backgroundImageView.image = value.image
                    UIView.animate(withDuration: 1.0) {
                        self.backgroundImageView.alpha = 0.8
                    }
                }
            }
        }
    }
    
    private func reloadWeatherData() {
        guard let location = self.location else { return }
        
        weatherService.getForecast(location) { [weak self] weather, error in
            if let _ = error { return }
            guard let weather = weather else { return }
            
            self?.weather = weather
            self?.populateWeatherDataIntoControls()
        }
    }
    
    private func reloadAqiData() {
        guard let location = self.location else { return }
        
        weatherService.getAirQuality(location) { [weak self] airQuality, error in
            if let _ = error { return }
            guard let airQuality = airQuality else { return }
            
            self?.airQuality = airQuality
            self?.populateAirQualityDataIntoControls()
        }
    }
    
    private func populateWeatherDataIntoControls() {
        guard let weather = self.weather else { return }
        
        let temperatureTextAttribue = NSMutableAttributedString(
            string: String(format: "%.0f", weather.current.temperature),
            attributes: [
                NSAttributedString.Key.font: UIFont.AvenirNext(.ultraLight, size: 80)
            ])
        temperatureTextAttribue.append(NSMutableAttributedString(
                        string: "°C",
                        attributes: [
                            NSAttributedString.Key.font: UIFont.AvenirNext(.regular, size: 20),
                            NSAttributedString.Key.baselineOffset: 45
                        ]))
        self.temperatureLabel.attributedText = temperatureTextAttribue
        
        guard let name = weatherTypes.first(where: { $0.type == weather.current.weather[0].id }) else { return }
        let dayPart = weather.daily.map { day -> DayParts in
            if day.time > day.sunrise && day.time < day.sunset {
                return DayParts.day
            }

            return DayParts.night
        }
        let nameWithDayPart = "\(name.icon)_\(dayPart.first!.rawValue.lowercased())"
        weatherIcon.image = UIImage(named: nameWithDayPart)
        
        weatherLabel.text = name.name.lowercased()
        
        guard let wind = windTypes.first(where: { $0.minMetric > weather.current.windSpeed }) else { return }
        windIcon.image = UIImage(named: wind.icon)
        windNameLabel.text = "Wind: \(wind.name)"
        windSpeedLabel.text = "Speed: \(weather.current.windSpeed) m/s"
        visibilityLabel.text = "Visibility: \(weather.current.visibility / 1000) km"
        pressureLabel.text = "Pressure: \(weather.current.pressure) hPa"
        windDirectionLabel.text = "Direction: \(getWindDirectionSymbol(forWindDirection: weather.current.windDeg))"
        
        UIView.animate(withDuration: 0.5) {
            let radians = deg2rad(Double(weather.current.windDeg))
            let angle = CGFloat(radians)
            self.needleIcon.transform = CGAffineTransform(rotationAngle: angle)
        }
    }
    
    private func populateAirQualityDataIntoControls() {
        guard let airQuality = self.airQuality else { return }
        
        guard let aqi = aqiTypes.first(where: { $0.aqi == airQuality.list[0].main.aqi }) else { return }
        airIcon.image = UIImage(named: aqi.icon)
        airLabel.text = aqi.name.lowercased()

        let aqiNormalTextAttribute = NSMutableAttributedString(
            string: String(format: "%d", aqi.aqi),
            attributes: [
                NSAttributedString.Key.font: UIFont.AvenirNext(.ultraLight, size: 80)
            ])
        aqiNormalTextAttribute.append(NSMutableAttributedString(
                        string: "aqi",
                        attributes: [
                            NSAttributedString.Key.font: UIFont.AvenirNext(.regular, size: 20),
                            NSAttributedString.Key.baselineOffset: 45
                        ]))
        aqiLabel.attributedText = aqiNormalTextAttribute
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let weather = self.weather else { return 0 }
        var val: Int
        
        switch collectionView {
        case hourlyView:
            val = weather.hourly.count
            
        case weeklyView:
            val = weather.daily.count
            
        default:
            val = 0
        }
        
        return val
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let weather = self.weather else { return UICollectionViewCell() }
        
        switch collectionView {
        case hourlyView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyViewCell.identifier, for: indexPath) as? HourlyViewCell else { return UICollectionViewCell() }
            let dayPart = weather.daily.map { day -> DayParts in
                if day.time > day.sunrise && day.time < day.sunset {
                    return DayParts.day
                }

                return DayParts.night
            }
            
            cell.configure(with: weather.hourly[indexPath.row], dayPart: dayPart.first!)
            return cell
            
        case weeklyView:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WeeklyViewCell.identifier, for: indexPath) as? WeeklyViewCell else { return UICollectionViewCell() }
            let row = weather.daily[indexPath.row]
            
            let weatherIconId = row.weather[0].id
            guard let weatherIcon = weatherTypes.first(where: { $0.type == weatherIconId }) else { return UICollectionViewCell() }
            guard let windIcon = windTypes.first(where: { $0.minImperial >= Int(row.windSpeed) }) else { return UICollectionViewCell() }
            
            let model = WeeklyViewModel(dayOfWeek: row.time.getWeekDayName(),
                                        rainProbability: String(format: "%.0f%%", row.pop * 100),
                                        wind: String(format: "%.0f m/s", row.windSpeed),
                                        dayTemperature: String(format: "%.0f", row.temperature.day),
                                        nightTemperature: String(format: "%.0f", row.temperature.night),
                                        weatherIcon: weatherIcon.icon,
                                        windIcon: windIcon.icon)
            cell.configure(with: model)
            return cell
            
        default:
            return UICollectionViewCell()
        }
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        switch collectionView {
        case hourlyView:
            return CGSize(width: 50, height: 80)
            
        case weeklyView:
            return CGSize(width: weeklyView.width, height: 30)
            
        default:
            return CGSize.zero
        }
    }
}
