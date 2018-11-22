//
//  ViewController.swift
//  choices
//
//  Created by Shravan Sukumar on 17/11/18.
//  Copyright © 2018 shravan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Constants
    let viewModel = ViewModel()
    var excludedItems: [ExcludeList]?
    
    // MARK: - IBOutlets
    @IBOutlet var tableView: UITableView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Variations"
        setupTableView()
        getVariants()
    }
    
    // MARK: - Private Methods
    private func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "VariationTableViewCell", bundle: nil), forCellReuseIdentifier: "variationTableViewCell")
        tableView.tableFooterView = UIView()
    }
    
    private func getVariants() {
        viewModel.fetchVariants { [unowned self] in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.numberOfSections()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(for: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "variationTableViewCell") as! VariationTableViewCell
        if let variation = viewModel.getVariation(for: indexPath.section, row: indexPath.row) {
            cell.shouldBeDisabled = false
            if let excludedItems = excludedItems {
                if excludedItems.contains(ExcludeList(groupId: viewModel.getGroup(with: indexPath.section).id, variationId: variation.id)) {
                    cell.shouldBeDisabled = true
                }
            }            
            cell.configure(with: variation)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        excludedItems = viewModel.getExcludedList(for: indexPath.section, variation: indexPath.row)
        tableView.reloadData()
    }
}
