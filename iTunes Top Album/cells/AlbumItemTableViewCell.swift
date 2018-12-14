//
//  AlbumItemTableViewCell.swift
//  iTunes Top Album
//
//  Created by Jesus Sanchez on 12/12/18.
//  Copyright © 2018 Jesus Sanchez. All rights reserved.
//

import UIKit

class AlbumItemTableViewCell: UITableViewCell {

    var request : NetworkingRequest = NetworkingRequest()
    
    @IBOutlet weak var albumImage: UIImageView!
    @IBOutlet weak var albumNameLabel: UILabel!
    @IBOutlet weak var artistNameLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setup(album: Album) {
        
        albumNameLabel.text = album.albumName
        artistNameLabel.text = album.artistName
        
        request.iTunesAlbumImage(album.albumeImage) { (imageData) in
//            print("Data retriving: ",imageData)
            self.albumImage.image = UIImage(data: imageData)
            
        }
    }

}
