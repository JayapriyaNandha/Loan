//
//  AppliedLoanTableViewCell.swift
//  Loan
//
//  Created by JayaKoushik on 28/05/26.
//

import UIKit

protocol deleteLoanProtocol : NSObjectProtocol {
    func delete(id:UUID?)
}

class AppliedLoanTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var detailsLabel: UILabel!
    weak var delegate : deleteLoanProtocol?
    private var form : FormData?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUp(form: FormData) {
        self.form = form
        titleLabel.text = (form.name) + "   $" + (form.loanAmount)
        detailsLabel.text = "\(form.submittedAt.formatted(date: .abbreviated, time: .omitted))"
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    @IBAction func deleteEvent(_ sender: Any) {
        delegate?.delete(id: form?.id)
    }
}
