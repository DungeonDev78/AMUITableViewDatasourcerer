//
//  CharacterModel.swift
//  AMTVDatasourcererExample
//
//  Created by Alessandro Manilii on 16/08/2019.
//  Copyright © 2019 Akhware. All rights reserved.
//

import UIKit

struct CharacterModel {
    var firstName: String
    var lastName: String?
    var universe: String
    var image: UIImage?
}

class CharacterFactory {

    static func createListOfCharacters() -> [CharacterModel] {
        var characters = createMarvelCharacters()
        characters.append(contentsOf: createPixarCharacters())
        characters.append(contentsOf: createWizardryWorldCharacters())
        return characters.shuffled()
    }

    static func createMultisectionCharacters() -> [DatasourcererMultisectionItem<CharacterModel>] {

        var groupedChars = [String:[CharacterModel]]()
        var sections = [DatasourcererMultisectionItem<CharacterModel>]()

        createListOfCharacters().forEach {
            if let initial = (($0.lastName) ?? $0.firstName).first {
                groupedChars[initial.uppercased()] != nil ? (groupedChars[initial.uppercased()]?.append($0)) : (groupedChars[initial.uppercased()] = [$0])
            }
        }

        groupedChars.keys.forEach {
            if let characters = groupedChars[$0]?.sorted(by: {($0.lastName) ?? $0.firstName < ($1.lastName) ?? $1.firstName}) {
                sections.append(DatasourcererMultisectionItem(headerTitle: "Section \($0)", footerTitle: nil, sectionIndexTitle: $0, items: characters))
            }
        }

        return sections.sorted(by: {($0.sectionIndexTitle ?? "") < ($1.sectionIndexTitle ?? "")})
    }
}

private extension CharacterFactory {

    static func createMarvelCharacters() ->  [CharacterModel] {
        let char01 = CharacterModel(firstName: "Tony", lastName: "Stark", universe: "Iron Man", image: #imageLiteral(resourceName: "ironman"))
        let char02 = CharacterModel(firstName: "Steven", lastName: "Rogers", universe: "Marvel", image: #imageLiteral(resourceName: "captainAmerica"))
        let char03 = CharacterModel(firstName: "Thor", lastName: "Odinson", universe: "Marvel", image: #imageLiteral(resourceName: "thor"))
        let char04 = CharacterModel(firstName: "Natasha", lastName: "Romanoff", universe: "Marvel", image: #imageLiteral(resourceName: "blackWidow"))
        let char05 = CharacterModel(firstName: "Peter", lastName: "Parker", universe: "Marvel", image: #imageLiteral(resourceName: "spiderman"))
        let char06 = CharacterModel(firstName: "Scott", lastName: "Lang", universe: "Marvel", image: #imageLiteral(resourceName: "antMan"))
        let char07 = CharacterModel(firstName: "Bruce", lastName: "Banner", universe: "Marvel", image: #imageLiteral(resourceName: "hulk"))
        let char08 = CharacterModel(firstName: "Pietro", lastName: "Maximoff", universe: "Marvel", image: #imageLiteral(resourceName: "quicksilver"))
        let char09 = CharacterModel(firstName: "Thanos", lastName: nil, universe: "Marvel", image: #imageLiteral(resourceName: "thanos"))
        let char10 = CharacterModel(firstName: "James", lastName: "Logan", universe: "Marvel", image: #imageLiteral(resourceName: "wolverine"))
        let char11 = CharacterModel(firstName: "Erik", lastName: "Lehnsherr", universe: "Marvel", image: #imageLiteral(resourceName: "magneto"))
        let char12 = CharacterModel(firstName: "Charles Francis", lastName: "Xavier", universe: "Marvel", image: #imageLiteral(resourceName: "xavier"))

        return [char01, char02, char03, char04, char05, char06, char07, char08, char09, char10, char11, char12]
    }

    static func createPixarCharacters() ->  [CharacterModel] {
        let char13 = CharacterModel(firstName: "Woody", lastName: nil, universe: "Pixar", image: #imageLiteral(resourceName: "woody"))
        let char14 = CharacterModel(firstName: "Wall-E", lastName: nil, universe: "Pixar", image: #imageLiteral(resourceName: "wallE"))
        let char15 = CharacterModel(firstName: "Buzz", lastName: "Lightyear", universe: "Pixar", image: #imageLiteral(resourceName: "buzzLightyear"))
        let char16 = CharacterModel(firstName: "Lightning", lastName: "McQueen", universe: "Pixar", image: #imageLiteral(resourceName: "mcQueen"))
        let char17 = CharacterModel(firstName: "Tow", lastName: "Mater", universe: "Pixar", image: #imageLiteral(resourceName: "towMater"))
        let char18 = CharacterModel(firstName: "Luigi", lastName: nil, universe: "Pixar", image: #imageLiteral(resourceName: "luigi"))
        let char19 = CharacterModel(firstName: "James", lastName: "Sullivan", universe: "Pixar", image: #imageLiteral(resourceName: "jamesSullivan"))
        let char20 = CharacterModel(firstName: "Mike", lastName: "Wazowski", universe: "Pixar", image: #imageLiteral(resourceName: "mikeWazowski"))
        let char21 = CharacterModel(firstName: "Alfredo", lastName: "Linguini", universe: "Pixar", image: #imageLiteral(resourceName: "linguini"))
        let char22 = CharacterModel(firstName: "Jack Jack", lastName: "Parr", universe: "Pixar", image: #imageLiteral(resourceName: "jackJack"))

        return [char13, char14, char15, char16, char17, char18, char19, char20, char21, char22]
    }

    static func createWizardryWorldCharacters() ->  [CharacterModel] {
        let char23 = CharacterModel(firstName: "Harry", lastName: "Potter", universe: "Wizardry World", image: #imageLiteral(resourceName: "harryPotter"))
        let char24 = CharacterModel(firstName: "Lord", lastName: "Voldemort", universe: "Wizardry World", image: #imageLiteral(resourceName: "voldemort"))
        let char25 = CharacterModel(firstName: "Severius", lastName: "Snape", universe: "Wizardry World", image: #imageLiteral(resourceName: "snape"))
        let char26 = CharacterModel(firstName: "Sirius", lastName: "Black", universe: "Wizardry World", image: #imageLiteral(resourceName: "siriusBlack"))
        let char27 = CharacterModel(firstName: "Albus", lastName: "Dumbledore", universe: "Wizardry World", image: #imageLiteral(resourceName: "dumbledore"))
        let char28 = CharacterModel(firstName: "Nymphadora", lastName: "Tonks", universe: "Wizardry World", image: #imageLiteral(resourceName: "nymphadora"))
        let char29 = CharacterModel(firstName: "Remus", lastName: "Lupin", universe: "Wizardry World", image: #imageLiteral(resourceName: "lupin"))
        let char30 = CharacterModel(firstName: "Bellatrix", lastName: "Lestrange", universe: "Wizardry World", image: #imageLiteral(resourceName: "bellatrix"))
        let char31 = CharacterModel(firstName: "Alastor", lastName: "Moody", universe: "Wizardry World", image: #imageLiteral(resourceName: "madeyeMoody"))
        let char32 = CharacterModel(firstName: "Newt", lastName: "Scamander", universe: "Wizardry World", image: #imageLiteral(resourceName: "scamander"))
        let char33 = CharacterModel(firstName: "Dobby the House Elf", lastName: nil, universe: "Wizardry World", image: #imageLiteral(resourceName: "dobby"))

        return [char23, char24, char25, char26, char27, char28, char29, char30, char31, char32, char33]
    }


}

