//
//  ExamsView.swift
//  Student
//
//  Created by Artur Gaisin on 21.09.2020.
//  Copyright © 2020 Artur Gaisin. All rights reserved.
//

import Foundation
import UIKit

final class ExamsView: UIView {
    private let appearance = Appearance()
    private var exams: [Exam] = []
    private var notes: [String] = []
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    private lazy var containterView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.spacing = appearance.stackSpacing
        view.alignment = .fill
        view.distribution = .fillProportionally
        return view
    }()
    
    lazy var subjectsView: UIView = {
        let view = UIView()
        return view
    }()

    lazy var subjectsLabel: UILabel = {
        let label = UILabel()
        label.text = appearance.subjects
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .darkGray
        return label
    }()
    
    lazy var addSubjectsButton: UIButton = {
        let button = UIButton(type: .contactAdd)
        button.tintColor = .darkGray
        return button
    }()
    
    lazy var subjectsTableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorColor = .clear
        tableView.isScrollEnabled = false
        tableView.delegate = self
        tableView.dataSource = self
        return tableView
    }()
    
    lazy var notesView: UIView = {
        let view = UIView()
        return view
    }()
    
    lazy var notesLabel: UILabel = {
        let label = UILabel()
        label.text = appearance.notes
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = .darkGray
        return label
    }()
    
    lazy var arrowDownButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "ic_arrowDown")?.withRenderingMode(.alwaysTemplate), for: .normal)
        button.setImage(UIImage(named: "ic_arrowUp")?.withRenderingMode(.alwaysTemplate), for: .selected)
        button.tintColor = .darkGray
        button.addTarget(self, action: #selector(notesButtonTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var notesCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.isScrollEnabled = false
        collectionView.backgroundView?.backgroundColor = .white
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.alwaysBounceHorizontal = true
        collectionView.clipsToBounds = false
        collectionView.backgroundColor = .white
        collectionView.delegate = self
        collectionView.dataSource = self
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).sectionInsetReference = .fromLayoutMargins
        return collectionView
    }()
    
    @objc
    private func notesButtonTapped() {
        if arrowDownButton.isSelected {
            notes = []
            UIView.transition(with: notesCollectionView, duration: 0.5, options: .transitionCurlUp, animations: {

                self.notesCollectionView.snp.updateConstraints { make in
                    make.height.equalTo(0)
                }
                self.layoutIfNeeded()
            })
        } else {
            notes = NotesDataStore.shared.notes
            UIView.transition(with: notesCollectionView, duration: 0.5, options: .transitionCurlDown, animations: {
                self.notesCollectionView.snp.updateConstraints { make in
                    make.height.equalTo(self.notes.count*150)
                }
                self.layoutIfNeeded()
            })
        }
        notesCollectionView.reloadData()
        arrowDownButton.isSelected = !arrowDownButton.isSelected
    }
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }

    private func commonInit() {
        arrowDownButton.isSelected = true
        subjectsTableView.register(ExamsTableViewCell.self, forCellReuseIdentifier: appearance.examsTableViewCellIdentifier)
        notesCollectionView.register(ExamsCollectionViewCell.self, forCellWithReuseIdentifier: appearance.notesCollectionViewCellIdentifier)
        setupStyles()
        addSubviews()
        makeConstraints()
    }

    private func setupStyles() {
        backgroundColor = .white
    }
    
    private func addSubviews() {
        addSubview(scrollView)
        subjectsView.addSubview(subjectsLabel)
        subjectsView.addSubview(addSubjectsButton)
        scrollView.addSubview(subjectsView)
        scrollView.addSubview(subjectsTableView)
        notesView.addSubview(notesLabel)
        notesView.addSubview(arrowDownButton)
        scrollView.addSubview(notesView)
        scrollView.addSubview(notesCollectionView)
    }
    
    private func makeConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.centerX.equalToSuperview()
        }
        subjectsView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.centerX.equalToSuperview()
            make.leading.trailing.equalToSuperview().inset(24)
        }
        subjectsTableView.snp.makeConstraints { make in
            make.top.equalTo(subjectsView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(50*exams.count)
        }
        notesView.snp.makeConstraints { make in
            make.top.equalTo(subjectsTableView.snp.bottom).offset(24)
            make.leading.trailing.equalToSuperview().inset(24)
        }
        notesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(notesView.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(24)
            make.height.equalTo(50*exams.count)
            make.bottom.equalToSuperview()
        }
        addSubjectsButton.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.top.trailing.bottom.equalToSuperview()
        }
        subjectsLabel.snp.makeConstraints { make in
            make.leading.centerY.equalToSuperview()
            make.trailing.equalTo(addSubjectsButton.snp.leading)
        }
        arrowDownButton.snp.makeConstraints { make in
            make.height.width.equalTo(24)
            make.top.trailing.bottom.equalToSuperview()
        }
        notesLabel.snp.makeConstraints { make in
            make.top.leading.bottom.equalToSuperview()
            make.trailing.equalTo(addSubjectsButton.snp.leading)
        }
        
    }
}

extension ExamsView {
    public struct Appearance {
        let stackSpacing: CGFloat = 16
        let buttonHeigh: CGFloat = 36
        let submit = "Сохранить"
        let subjects = "Предметы"
        let notes = "Примечания"
        let examsTableViewCellIdentifier = "ExamsTableViewCell"
        let notesCollectionViewCellIdentifier = "ExamsCollectionViewCell"
        let backgroundColors = [UIColor(red: 0.565, green: 0.792, blue: 0.976, alpha: 1),
                                UIColor(red: 1, green: 0.733, blue: 0.576, alpha: 1),
                                UIColor(red: 0.565, green: 0.792, blue: 0.976, alpha: 1),
                                UIColor(red: 1, green: 0.733, blue: 0.576, alpha: 1),
                                UIColor(red: 0.565, green: 0.792, blue: 0.976, alpha: 1),
                                UIColor(red: 1, green: 0.733, blue: 0.576, alpha: 1),
                                UIColor(red: 0.565, green: 0.792, blue: 0.976, alpha: 1),
                                UIColor(red: 1, green: 0.733, blue: 0.576, alpha: 1),
                                UIColor(red: 0.565, green: 0.792, blue: 0.976, alpha: 1),
                                UIColor(red: 1, green: 0.733, blue: 0.576, alpha: 1),
                                UIColor(red: 0.565, green: 0.792, blue: 0.976, alpha: 1),
                                UIColor(red: 1, green: 0.733, blue: 0.576, alpha: 1)]
    }
}

extension ExamsView: UITableViewDelegate, UITableViewDataSource {
    func insertExams(_ exams: [Exam]) {
        self.exams = exams
        subjectsTableView.snp.updateConstraints { make in
            make.height.equalTo(48*exams.count)
        }
        DispatchQueue.main.async {
            self.subjectsTableView.reloadData()
            self.subjectsTableView.layoutIfNeeded()
        }
    }
    
    func insertNotes(_ notes: [String]) {
        self.notes = notes
        notesCollectionView.snp.updateConstraints { make in
            make.height.equalTo(CGFloat(notes.count)*170)
        }
        DispatchQueue.main.async {
            self.notesCollectionView.reloadData()
            self.notesCollectionView.layoutIfNeeded()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return exams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = subjectsTableView.dequeueReusableCell(withIdentifier: appearance.examsTableViewCellIdentifier) as? ExamsTableViewCell else { return UITableViewCell()}
        cell.examNameLabel.text = exams[indexPath.row].subject.name
        cell.examScoreLabel.text = "\(exams[indexPath.row].score)/100"
        cell.containerView.backgroundColor = appearance.backgroundColors[indexPath.row % 10]
        return cell
    }
}

extension ExamsView: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return notes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = notesCollectionView.dequeueReusableCell(withReuseIdentifier: appearance.notesCollectionViewCellIdentifier, for: indexPath) as? ExamsCollectionViewCell else { return UICollectionViewCell() }
        cell.notesLabel.text = notes[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionInset = (collectionViewLayout as! UICollectionViewFlowLayout).sectionInset
        let referenceHeight: CGFloat = 100 // Approximate height of your cell
        let referenceWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width
            - sectionInset.left
            - sectionInset.right
            - collectionView.contentInset.left
            - collectionView.contentInset.right
        return CGSize(width: referenceWidth, height: referenceHeight)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt index: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: -8, bottom: 0, right: 0)
    }
}
