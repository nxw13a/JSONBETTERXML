//
//  DetailViewController.swift
//  JSONBETTERXML
//
//  Created by Nattapat White on 3/9/18.
//  Copyright © 2018 Nattapat White. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    @IBOutlet weak var witle: UILabel!
    @IBOutlet weak var yStart: UILabel!
    @IBOutlet weak var format: UILabel!
    @IBOutlet weak var ep: UILabel!
    @IBOutlet weak var studio: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var castcss: UIButton!
    
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detail = detailItem {
            if let label = self.witle {
                label.text = detail.name
            }
            if let label = self.yStart {
                label.text = detail.yearStart
                if let test = detail.yearEnd{
                    label.text = detail.yearStart + "-"+test
                }
            }
            if let label = self.format {
                label.text = detail.format
            }
            if let label = self.studio {
                var temp = ""
                //label.text =  detail.network!
                if let test = detail.network{
                    temp += test
                }
                if let test2 = detail.studio{
                    temp += test2
                }
                label.text = temp
            }
            if let label = self.ep {
                label.text = "Episodes: " + String(detail.episodesCount
                )
            }
            if let label = self.castcss {
                label.tintColor = UIColor.red
            }
            if let label = self.summary {
                label.text = detail.showSummary
            }
            if let label = self.desc {
                label.text = detail.showDescription
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: DataObject? {
        didSet {
            // Update the view.
            configureView()
        }
    }


}

