# AMUISegmentedControl

A custom UISegmentedControl in two different flavours made for iOS in Swift 5.0

![Image description](https://github.com/DungeonDev78/AMUISegmentedControl/blob/master/img001.jpg)

## Installation

Copy the two Swift classes included in the repo in your project.


## Usage

Add in your Storyboard a UIView and set its class as UISegmentedControl.


Connect your component in your UIViewController using a @IBAction:
```
@IBAction func segmentedControlValueChanged(_ sender: AMUISegmentedControl) {
        print("*** SELECTED INDEX: \(sender.selectedIndex) ***")
}
```

Configure your selectors appearance directly on the storyboard using the IBInspectable variables.


Choose the main style of the component with the bool **isUnderlined**. If you set the value to false you can also edit the **borderWidth** and **borderColor** values.

Add a list of options in the **commaSeparatedButtonTitles** field and remember to separate them with commas:

```
commaSeparatedButtonTitles = "First, Second, Third"
```

To change the font style and the size used:
```
fontName = "Futura-Bold"
fontSize = 14
```

## Author

* **Alessandro "DungeonDev78" Manilii**

## License

This project is licensed under the MIT License
