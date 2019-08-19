# AMUITableViewDatasourcerer

Create UITableViews in the blink of an eye!
Just add your array and everything is done... it's a kind of magic!

![Image description](https://github.com/DungeonDev78/AMUITableViewDatasourcerer/blob/master/AMTVDatasourcererExample.jpg?raw=true)

## Installation

Add your UITableView in the storyboard and create your custom prototype cell.


## Usage

Create your subclass of UITableViewCell for your custom cell. This cell MUST conforms to the protocol **AMConfigurableCell**, so you have to implement the method:

```
func configure(_ item: T, at indexPath: IndexPath)
```

Please note that you can use any kind of item for the model of the cell.

Now back to your storyboard and add the reuseIdentifier of the custom cell that MUST be the name of the cell class itself.

In your ViewController class add the datasource variable with the two generic constraints:

```
var dataSource: AMUITableViewDatasourcerer<YOUR_ITEM_MODEL, YOUR_CELL_CLASS>?
```

Once you have your array of items, use it to create the datasource:

```
dataSource = AMUITableViewDatasourcerer.init(items: YOUR_ARRAY_OF_ITEMS, cellClass: YOUR_CELL_CLASS)
tableView.dataSource = dataSource
```

If you need to create a multi sections TableView, use an array of **DatasourcererMultisectionItem**. It comes with a special init:

```
init(headerTitle: String, footerTitle: String? = nil, sectionIndexTitle: String? = nil, items: [T]) 
```

and of course in your ViewController:

```
dataSource = AMUITableViewDatasourcerer.init(multiSectionItems: YOUR_ARRAY_OF_MULTI_SECTION_ITEMS, cellClass: YOUR_CELL_CLASS)
```

Please note the **items** array of generics. You can avoid to add **footerTitle** and **sectionIndexTitle** if toy do not need them.

If you need additional logic for the tableview **canEditRowAt** and **canMoveRowAt**, just use the vars:

```
var onCanEditRow: ((IndexPath) -> Bool)?
var onCanMoveRow: ((IndexPath) -> Bool)?
```

Just take a look at the example project. That's a common ViewController implementation... just few lines of code:

```
class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var dataSource: AMUITableViewDatasourcerer<CharacterModel, CharacterCell>?

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSource = AMUITableViewDatasourcerer.init(multiSectionItems: CharacterFactory.createMultisectionCharacters(), cellClass: CharacterCell.self)
        tableView.dataSource = dataSource
    }
}
```


## Author

* **Alessandro "DungeonDev78" Manilii**

## License

This project is licensed under the MIT License
