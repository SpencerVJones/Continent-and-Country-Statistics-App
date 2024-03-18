//
//  ViewController.swift
//  JonesSpencer_Week2Synthesis
//
//  Created by Spencer Jones on 3/15/24.
//

import UIKit
class ViewController: UIViewController {
    
    // Outlets
    @IBOutlet var worldInfoTextView: UITextView!
    @IBOutlet var africaButton: UIButton!
    @IBOutlet var asiaButton: UIButton!
    @IBOutlet var australiaButton: UIButton!
    @IBOutlet var europeButton: UIButton!
    @IBOutlet var northAmericaButton: UIButton!
    @IBOutlet var southAmericaButton: UIButton!

    // Data Model: Empty nested dictionary
    var continents: [String: [String: Int]] =  [
        "Africa": [:],
        "Asia": [:],
        "Australia": [:],
        "Europe": [:],
        "North America": [:],
        "South America": [:]
    ]
    
    // Variables
    var continentName: String?
    var countryNames: [String]?
    var countryPopulations: [Int]?
    var continentPopulation: Int?
    var totalCountries: Int = 0
    var totalPopulation: Int = 0
    
    // Arrays to store country names and populations for each continent
    var africaCountryNames: [String] = []
    var africaPopulations: [Int] = []
    var asiaCountryNames: [String] = []
    var asiaPopulations: [Int] = []
    var australiaCountryNames: [String] = []
    var australiaPopulations: [Int] = []
    var europeCountryNames: [String] = []
    var europePopulations: [Int] = []
    var northAmericaCountryNames: [String] = []
    var northAmericaPopulations: [Int] = []
    var southAmericaCountryNames: [String] = []
    var southAmericaPopulations: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateArrays()
    }
    
    
    // Populate arrays with country names and populations continents
    func populateArrays() {
        for (continent, countries) in continents {
            for (country, population) in countries {
                // Switch statement to categorize countries and populations based on continents
                switch continent {
                case "Africa":
                    africaCountryNames.append(country)
                    africaPopulations.append(population)
                case "Asia":
                    asiaCountryNames.append(country)
                    asiaPopulations.append(population)
                case "Australia":
                    australiaCountryNames.append(country)
                    australiaPopulations.append(population)
                case "Europe":
                    europeCountryNames.append(country)
                    europePopulations.append(population)
                case "North America":
                    northAmericaCountryNames.append(country)
                    northAmericaPopulations.append(population)
                case "South America":
                    southAmericaCountryNames.append(country)
                    southAmericaPopulations.append(population)
                default:
                    break
                }
            }
        }
        updateTotalCounts()
    }
    
    // Function to update label
    func updateWorldInfo() {
        worldInfoTextView.text = "There are \(totalCountries) countries in the entire world, with a total population of \(totalPopulation) people."
    }
    
    // Function to update totalCountries and totalPopulation
    func updateTotalCounts() {
        totalCountries = 0
        totalPopulation = 0
        
        for (_, countries) in continents {
            totalCountries += countries.count
            for population in countries.values {
                totalPopulation += population
            }
        }
        updateWorldInfo()
    }
    
    @IBAction func continentsButtonTapped(_ sender: UIButton) {
        if let secondVC = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController {
            // Set the selected continent details
            secondVC.continents = continents
            secondVC.totalPopulation = totalPopulation
            
            switch sender {
                case africaButton:
                    secondVC.continentName = "Africa"
                    secondVC.countryNames = africaCountryNames
                    secondVC.countryPopulations = africaPopulations
                    secondVC.continentPopulation = africaPopulations.reduce(0, +)
                    secondVC.totalCountries = continents["Africa"]?.count ?? 0
                case asiaButton:
                    secondVC.continentName = "Asia"
                    secondVC.countryNames = asiaCountryNames
                    secondVC.countryPopulations = asiaPopulations
                    secondVC.continentPopulation = asiaPopulations.reduce(0, +)
                    secondVC.totalCountries = continents["Asia"]?.count ?? 0
                case australiaButton:
                    secondVC.continentName = "Australia"
                    secondVC.countryNames = australiaCountryNames
                    secondVC.countryPopulations = australiaPopulations
                    secondVC.continentPopulation = australiaPopulations.reduce(0, +)
                    secondVC.totalCountries = continents["Australia"]?.count ?? 0
                case europeButton:
                    secondVC.continentName = "Europe"
                    secondVC.countryNames = europeCountryNames
                    secondVC.countryPopulations = europePopulations
                    secondVC.continentPopulation = europePopulations.reduce(0, +)
                    secondVC.totalCountries = continents["Europe"]?.count ?? 0
                case northAmericaButton:
                    secondVC.continentName = "North America"
                    secondVC.countryNames = northAmericaCountryNames
                    secondVC.countryPopulations = northAmericaPopulations
                    secondVC.continentPopulation = northAmericaPopulations.reduce(0, +)
                    secondVC.totalCountries = continents["North America"]?.count ?? 0
                case southAmericaButton:
                    secondVC.continentName = "South America"
                    secondVC.countryNames = southAmericaCountryNames
                    secondVC.countryPopulations = southAmericaPopulations
                    secondVC.continentPopulation = southAmericaPopulations.reduce(0, +)
                    secondVC.totalCountries = continents["South America"]?.count ?? 0
                default:
                    break
            }
            // Present the SecondViewController
            present(secondVC, animated: true, completion: nil)
        }
    }
    
    @IBAction func unwindFromSecondViewController(segue: UIStoryboardSegue) {
        if let sourceViewController = segue.source as? SecondViewController {
            // Receive data from the second view controller and update properties
            continents = sourceViewController.continents ?? ["nil":["nil":0]]
            populateArrays()
        }
    }
}
