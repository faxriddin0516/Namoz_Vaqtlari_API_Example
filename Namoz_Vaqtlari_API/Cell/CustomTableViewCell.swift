//
//  CustomTableViewCell.swift
//  Namoz_Vaqtlari_API
//
//  Created by MacAir on 04/01/23.
//

import UIKit
import SnapKit

class CustomTableViewCell: UITableViewCell {
    
    let dateLabel     = UILabel()
    let weekdateLabel = UILabel()
    let bomdodLabel   = UILabel()
    let quyoshLabel   = UILabel()
    let peshinLabel   = UILabel()
    let asrLabel      = UILabel()
    let shomLabel     = UILabel()
    let xuftonLabel   = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        //MARK: - dateLabel -
        
        self.addSubview(dateLabel)
        dateLabel.font = .boldSystemFont(ofSize: 20)
        dateLabel.textColor = .black
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(15)
            make.left.equalTo(self.snp.left).offset(25)
        }
        
        //MARK: - weekdateLabel -
        
        self.addSubview(weekdateLabel)
        weekdateLabel.font = .boldSystemFont(ofSize: 20)
        weekdateLabel.textColor = .black
        weekdateLabel.numberOfLines = 2
        weekdateLabel.snp.makeConstraints { make in
            make.top.equalTo(self.snp.top).offset(15)
            make.left.equalTo(dateLabel.snp.right).offset(10)
        }
        
        //MARK: - bomdodLabel -
        
        self.addSubview(bomdodLabel)
        bomdodLabel.font = .boldSystemFont(ofSize: 20)
        bomdodLabel.textColor = .black
        bomdodLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(5)
            make.left.equalTo(self.snp.left).offset(25)
        }
        
        //MARK: - quyoshLabel -
        
        self.addSubview(quyoshLabel)
        quyoshLabel.font = .boldSystemFont(ofSize: 20)
        quyoshLabel.textColor = .black
        quyoshLabel.snp.makeConstraints { make in
            make.top.equalTo(bomdodLabel.snp.bottom).offset(5)
            make.left.equalTo(self.snp.left).offset(25)
        }
        
        //MARK: - peshinLabel -
        
        self.addSubview(peshinLabel)
        peshinLabel.font = .boldSystemFont(ofSize: 20)
        peshinLabel.textColor = .black
        peshinLabel.snp.makeConstraints { make in
            make.top.equalTo(quyoshLabel.snp.bottom).offset(5)
            make.left.equalTo(self.snp.left).offset(25)
        }
        
        //MARK: - asrLabel -
        
        self.addSubview(asrLabel)
        asrLabel.font = .boldSystemFont(ofSize: 20)
        asrLabel.textColor = .black
        asrLabel.snp.makeConstraints { make in
            make.top.equalTo(peshinLabel.snp.bottom).offset(5)
            make.left.equalTo(self.snp.left).offset(25)
        }
        
        //MARK: - shomLabel -
        
        self.addSubview(shomLabel)
        shomLabel.font = .boldSystemFont(ofSize: 20)
        shomLabel.textColor = .black
        shomLabel.snp.makeConstraints { make in
            make.top.equalTo(asrLabel.snp.bottom).offset(5)
            make.left.equalTo(self.snp.left).offset(25)
        }
        
        //MARK: - xuftonLabel -
        
        self.addSubview(xuftonLabel)
        xuftonLabel.font = .boldSystemFont(ofSize: 20)
        xuftonLabel.textColor = .black
        xuftonLabel.snp.makeConstraints { make in
            make.top.equalTo(shomLabel.snp.bottom).offset(5)
            make.left.equalTo(self.snp.left).offset(25)
        }
        
        

    }

}
