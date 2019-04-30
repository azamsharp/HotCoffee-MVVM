//
//  CoffeeOrdersTableViewController.swift
//  HotCoffee
//
//  Created by Mohammad Azam on 4/15/19.
//  Copyright © 2019 Mohammad Azam. All rights reserved.
//

import Foundation
import UIKit

class CoffeeOrdersTableViewController: UITableViewController, AddCoffeeOrderDelegate {
    
    var orderListViewModel = OrderListViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        populateCoffeeOrders()
    }
    
    private func setupUI() {
        self.navigationController?.navigationBar.prefersLargeTitles = true 
    }
    
    private func populateCoffeeOrders() {
        
        Webservice().load(resource: Order.all) {[weak self] result in
            switch result {
                case .success(let orders):
                    self?.orderListViewModel.ordersViewModel = orders.map(OrderViewModel.init)
                    self?.tableView.reloadData()
                case .failure(let error):
                    print(error)
            }
        }
        
    }
    
    func addCoffeeOrderViewControllerDidSave(order: Order, controller: UIViewController) {
        
        controller.dismiss(animated: true, completion: nil)
        
        let orderVM = OrderViewModel(order: order)
        self.orderListViewModel.ordersViewModel.append(orderVM)
        self.tableView.insertRows(at: [IndexPath.init(row: self.orderListViewModel.ordersViewModel.count - 1, section: 0)], with: .automatic)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let navC = segue.destination as? UINavigationController,
            let addCoffeeOrderVC = navC.viewControllers.first as? AddCoffeeOrderViewController else {
                fatalError("Error performing segue")
        }
        
        addCoffeeOrderVC.delegate = self
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orderListViewModel.ordersViewModel.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let vm = self.orderListViewModel.orderViewModel(at: indexPath.row)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderTableViewCell", for: indexPath)
        
        cell.textLabel?.text = vm.type
        cell.detailTextLabel?.text = vm.size
        
        return cell
    }
    
}
