//
//  ResultViewController.swift
//  CoppelTest
//
//  Created by Javier Morales on 26/10/21.
//

import Foundation
import UIKit

class ResultViewController: UIViewController {
    
    private let segmentedControl: UISegmentedControl = {
        let segmented = UISegmentedControl()
        segmented.insertSegment(withTitle: "Popular", at: 0, animated: true)
        segmented.insertSegment(withTitle: "Top Rated", at: 1, animated: true)
        segmented.insertSegment(withTitle: "On TV", at: 2, animated: true)
        segmented.insertSegment(withTitle: "Arriving Today", at: 3, animated: true)
        segmented.addTarget(self, action: #selector(indexChanged(_:)), for: .valueChanged)
        segmented.selectedSegmentIndex = 0
        segmented.apportionsSegmentWidthsByContent = true
        return segmented
    }()
    
    private let collectionMovies: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
        layout.itemSize = CGSize(width: 300, height: 400)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UINib(nibName: "CellMovie", bundle: nil), forCellWithReuseIdentifier: "movieCell")
        return collectionView
    }()
    
    var viewModel = MoviesViewModel()
    
    private var isMovie: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        viewModel.retrieveDataList(params: nil)
        bind()
        
    }
    
    @objc func indexChanged(_ sender: UISegmentedControl) {
        if segmentedControl.selectedSegmentIndex == 0 {
            viewModel.retrieveDataList(params: nil)
            isMovie = true
        } else if segmentedControl.selectedSegmentIndex == 1 {
            viewModel.retrieveDataList(category: "top_rated", params: nil)
            isMovie = true
        } else if segmentedControl.selectedSegmentIndex == 2 {
            viewModel.retrieveDataList(category: "on_the_air", tvOrMovie: "tv", params: nil)
            isMovie = false
        } else if segmentedControl.selectedSegmentIndex == 3 {
            isMovie = false
            viewModel.retrieveDataList(category: "airing_today", tvOrMovie: "tv", params: nil)
        }
    }
    
    private func setupView() {
        self.title = "Result"
        view.backgroundColor = .white
        
        self.navigationItem.hidesBackButton = true
        collectionMovies.delegate = self
        collectionMovies.dataSource = self
        
        view.addSubview(segmentedControl)
        
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            segmentedControl.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            segmentedControl.heightAnchor.constraint(equalToConstant: 40)
        ])
        
        view.addSubview(collectionMovies)
        collectionMovies.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionMovies.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 20),
            collectionMovies.leadingAnchor.constraint(equalTo: segmentedControl.leadingAnchor),
            collectionMovies.trailingAnchor.constraint(equalTo: segmentedControl.trailingAnchor),
            collectionMovies.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20)
        ])
        
        let add = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
        navigationItem.rightBarButtonItems = [add]
    }
    
    @objc private func addTapped() {
        let alert = UIAlertController(title: "", message: "What do you want to do?", preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "View Profile", style: .default , handler:{ (UIAlertAction)in
            
            let profileViewController = ProfileViewController()
            self.navigationController?.pushViewController(profileViewController, animated: true)
        }))
        
        alert.addAction(UIAlertAction(title: "Log out", style: .destructive , handler:{ (UIAlertAction)in
            self.navigationController?.popToRootViewController(animated: true)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    private func bind() {
        viewModel.refreshData = { [weak self] () in
            DispatchQueue.main.async {
                self?.collectionMovies.reloadData()
            }
        }
    }
}


extension ResultViewController: UICollectionViewDelegate {

}

extension ResultViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            let padding: CGFloat =  50
            let collectionViewSize = collectionView.frame.size.width - padding
            return CGSize(width: collectionViewSize/2, height: 295)
        }
    
}

extension ResultViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isMovie { return viewModel.dataArray.count }
        else { return viewModel.dataArrayTvs.count }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! SubclassedCollectionViewCell
        if isMovie {
            cell.movie = viewModel.dataArray[indexPath.item]
        } else {
            cell.tv = viewModel.dataArrayTvs[indexPath.item]
        }
        return cell
    }
    
}


