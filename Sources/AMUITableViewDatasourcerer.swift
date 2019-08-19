//
//  AMUITableViewDatasourcerer.swift
//
//  Created with 💪 by Alessandro Manilii
//  Copyright © 2019 Alessandro Manilii. All rights reserved.
//

import UIKit

//MARK: - Class UITableViewDatasourcerer
public class AMUITableViewDatasourcerer<T, U: AMConfigurableCell>: NSObject, UITableViewDataSource  {

    //MARK: - Properties
    /// An enum that describes the possible datasource kind of the Datasoucerer
    ///
    /// - singleSection: the datasource is an array of elements
    /// - multiSection: the datasource is an array of DatasourcererMultisectionItem
    /// - unknown: the datasource is not set (default case to avoid optionals)
    enum DatasourceType {
        case singleSection
        case multiSection
        case unknown
    }

    typealias DatasourcererItem = U.T

    fileprivate var items = [DatasourcererItem]()
    fileprivate var cellClass: U.Type
    fileprivate var multiSectionsItems = [DatasourcererMultisectionItem<DatasourcererItem>]()
    fileprivate var datasourceType = DatasourceType.unknown
    var onCanEditRow: ((IndexPath) -> Bool)?    // If extra behaviours are needed
    var onCanMoveRow: ((IndexPath) -> Bool)?    // If extra behaviours are needed

    //MARK: - Initializers

    /// Datasourcer initializer - Single Section
    /// - Note: the cell class must conform the AMConfigurableCell protocol in order to use automatically the item object.
    /// - Parameters:
    ///   - items: array of items. Are inferred since it' a double step generic
    ///   - cellClass: Class for the custom cell
    init(items: [U.T], cellClass: U.Type) {
        self.datasourceType = .singleSection
        self.items = items
        self.cellClass = cellClass
    }

    /// Datasourcer initializer - Multi Sections
    /// - Note: the cell class must conform the AMConfigurableCell protocol in order to use automatically the item object.
    /// - Parameters:
    ///   - multiSectionItems: the array of DatasourcererMultisectionItems
    ///   - cellClass: Class for the custom cell
    init(multiSectionItems: [DatasourcererMultisectionItem<DatasourcererItem>], cellClass: U.Type) {
        self.datasourceType = .multiSection
        self.multiSectionsItems = multiSectionItems
        self.cellClass = cellClass
    }

    //MARK: - UITableViewDataSource

    //MARK: - Sections, cells and rendering
    public func numberOfSections(in tableView: UITableView) -> Int {
        switch self.datasourceType {
        case .singleSection : return 1
        case .multiSection  : return multiSectionsItems.count
        case .unknown       : return 0
        }
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.datasourceType {
        case .singleSection : return items.count
        case .multiSection  : return multiSectionsItems[section].items.count
        case .unknown       : return 0
        }
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: U.reuseIdentifier, for: indexPath) as? U else { return UITableViewCell() }

        switch self.datasourceType {
        case .singleSection : cell.configure(items[indexPath.row], at: indexPath)
        case .multiSection  : cell.configure(multiSectionsItems[indexPath.section].items[indexPath.row], at: indexPath)
        case .unknown       : break
        }

        guard let returnableCell = cell as? UITableViewCell else { return UITableViewCell() }
        return returnableCell
    }

    //MARK: - Header and Footer titles
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch datasourceType {
        case .multiSection  : return multiSectionsItems[section].headerTitle
        default             : return nil
        }
    }

    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        switch datasourceType {
        case .multiSection  : return multiSectionsItems[section].footerTitle
        default             : return nil
        }
    }

    //MARK: - Sections Indexes
    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        switch datasourceType {
        case .multiSection  : return multiSectionsItems.compactMap { $0.sectionIndexTitle }
        default             : return nil
        }
    }

    public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        switch datasourceType {
        case .multiSection  : return multiSectionsItems.firstIndex{$0.sectionIndexTitle ?? "" == title} ?? 0
        default             : return 0
        }
    }

    // TODO:- Handle reorder only
    //MARK: - Editing and Reordering
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if let onCanEditRow = onCanEditRow { return onCanEditRow(indexPath) }
        return true
    }

    public func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        if let onCanMoveRow = onCanMoveRow { return onCanMoveRow(indexPath) }
        return true
    }


    //MARK: - Data manupulation
    public func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            switch datasourceType {
            case .singleSection:
                items.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            case .multiSection:
                multiSectionsItems[indexPath.section].items.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            case .unknown: break
            }
        }
    }

    public func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        switch datasourceType {
        case .singleSection:
            let movedItem = items[sourceIndexPath.row]
            items.remove(at: sourceIndexPath.row)
            items.insert(movedItem, at: destinationIndexPath.row)
            reloadWithAnimation(tableView: tableView)
        case .multiSection  :
            let movedItem = multiSectionsItems[sourceIndexPath.section].items[sourceIndexPath.row]
            multiSectionsItems[sourceIndexPath.section].items.remove(at: sourceIndexPath.row)
            multiSectionsItems[destinationIndexPath.section].items.insert(movedItem, at: destinationIndexPath.row)
            reloadWithAnimation(tableView: tableView)
        case .unknown       : break
        }
    }
}

//MARK: - Private
private extension AMUITableViewDatasourcerer {

    /// Create an animation for the reload of the tableview
    ///
    /// - Parameter tableView: the table to update
    func reloadWithAnimation(tableView: UITableView) {
        UIView.transition(with: tableView,
                          duration: 0.25,
                          options: .transitionCrossDissolve,
                          animations: {tableView.reloadData() })

    }
}



//MARK: - Class DatasourcererMultisectionItem
class DatasourcererMultisectionItem<T> {
    //MARK: - Properties
    let headerTitle: String
    let footerTitle: String?
    let sectionIndexTitle: String?
    var items: [T]

    //MARK: - Initializer
    init(headerTitle: String, footerTitle: String? = nil, sectionIndexTitle: String? = nil, items: [T]) {
        self.headerTitle = headerTitle
        self.footerTitle = footerTitle
        self.sectionIndexTitle = sectionIndexTitle
        self.items = items
    }
}


