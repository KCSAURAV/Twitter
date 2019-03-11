//
//  TweetsCell.swift
//  Twitter
//
//  Created by SAURAV on 3/10/19.
//  Copyright © 2019 Dan. All rights reserved.
//

import UIKit

class TweetsCell: UITableViewCell {

  @IBOutlet weak var profileImg: UIImageView!
  @IBOutlet weak var userName: UILabel!
  @IBOutlet weak var tweet: UILabel!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
