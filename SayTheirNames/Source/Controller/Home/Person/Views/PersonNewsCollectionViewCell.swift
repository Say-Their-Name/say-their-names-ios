//
//  PersonNewsCollectionViewCell.swift
//  Say Their Names
//
//  Created by Manase on 05/06/2020.
//  Copyright © 2020 Franck-Stephane Ndame Mpouli. All rights reserved.
//

import UIKit
import SDWebImage

class PersonNewsCollectionViewCell: UICollectionViewCell {
 
    @DependencyInject private var metadata: MetadataService
    private var news: News?
    
    static var reuseIdentifier: String {
        return "\(Self.self)"
    }
    
    lazy var newsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(asset: STNAsset.Image.placeholder)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    lazy var newsTitleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 3
        label.font = UIFont.STN.sectionHeader
        label.minimumScaleFactor = 0.5
        label.textColor = UIColor(asset: STNAsset.Color.detailLabel)
        return label
    }()
    
    lazy var loadingIndicator: UIActivityIndicatorView = {
        let view = SDWebImageActivityIndicator.gray.indicatorView
        view.hidesWhenStopped = true
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor(asset: STNAsset.Color.background)
        setupLayout()
        
        // Start loading indicator
        loadingIndicator.startAnimating()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with news: News) {
        self.news = news
        
        if let url = URL(string: news.url) {
            self.metadata.fetchLinkInformation(from: url) { [weak self] result in
                // This is a weird check, but it prevents a reusedCell from loading incorrect information.
                // TODO: Long term, move this loading into Combine/Futures and move it back into a controller.
                if let oldNews = self?.news, news == oldNews {
                    
                    switch result {
                    case .success(let link):
                        DispatchQueue.main.async {
                            self?.newsImageView.image = link.image
                            self?.newsTitleLabel.text = link.title
                            self?.loadingIndicator.stopAnimating()
                        }
                    case .failure(let error):
                        print(url)
                        DispatchQueue.main.async {
                            self?.loadingIndicator.stopAnimating()
                        }
                        Log.print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.news = nil
        self.newsImageView.image = UIImage(asset: STNAsset.Image.placeholder)
        self.newsTitleLabel.text = ""
        self.loadingIndicator.startAnimating()
    }
    
    private func setupLayout() {
        newsImageView.translatesAutoresizingMaskIntoConstraints = false
        newsTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(newsImageView)
        contentView.addSubview(newsTitleLabel)
        contentView.addSubview(loadingIndicator)
        
        NSLayoutConstraint.activate([
            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            newsImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            newsImageView.heightAnchor.constraint(equalToConstant: 165),
            
            newsTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
            newsTitleLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 5),
            newsTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 0),
            newsTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            
            loadingIndicator.centerYAnchor.constraint(equalTo: newsImageView.centerYAnchor),
            loadingIndicator.centerXAnchor.constraint(equalTo: newsImageView.centerXAnchor),
        ])
    }
}
