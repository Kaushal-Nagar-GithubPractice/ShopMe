//
//  FilterScreenVC.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 04/07/24.
//

import UIKit
import SwiftRangeSlider

class FilterScreenVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var VwRangeSliderView: RangeSlider!
    
    @IBOutlet weak var TfFromDate: UITextField!
    @IBOutlet weak var TfToDate: UITextField!
    var activeTextField: UITextField!
    var MinPrice = 0
    var MaxPrice = 0
    @IBOutlet weak var lblMaxPrice: UILabel!
    @IBOutlet weak var lblMinPrice: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        TfToDate.delegate = self
        TfFromDate.delegate = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        CreateDatePicker(forField: TfToDate)
        CreateDatePicker(forField: TfFromDate)
        
        SetUI()
    }
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        SetUI()
    }
    
    //MARK: - All IBActions
    
    @IBAction func OnClickCloseFilterScreen(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
    
    @IBAction func OnClickApplyFilter(_ sender: Any) {
        
        var FilterBody = "?"
        
        if (TfFromDate.text?.count == 0 && TfToDate.text?.count ?? 0 > 0 || TfToDate.text?.count == 0 && TfFromDate.text?.count ?? 0 > 0 ){
            ShowAlertBox(Title: "'From Date' and 'To Date' Either both be Empty or Both be filled !", Message: "")
        }
        else if ConvertStringToDate(formate: "dd MMM yyyy", DateInString: TfFromDate.text ?? "") > ConvertStringToDate(formate: "dd MMM yyyy", DateInString: TfToDate.text ?? ""){
            ShowAlertBox(Title: "'From Date' must be Earliar than 'To Date' !", Message: "")
        }
        else{
            if(TfFromDate.text?.count != 0){
                FilterBody = MakeAppendString(Key: "startDate", Value: getFormattedDate(DateInString: TfFromDate.text ?? "", FromFormate: "dd MMM yyyy", ToFormate: "MM-dd-yyyy"), Filterbody: FilterBody)
            }
            if(TfToDate.text?.count != 0){
                FilterBody = MakeAppendString(Key: "endDate", Value: getFormattedDate(DateInString: TfToDate.text ?? "", FromFormate: "dd MMM yyyy", ToFormate: "MM-dd-yyyy"), Filterbody: FilterBody)
            }
            if(VwRangeSliderView.lowerValue != 0){
                FilterBody = MakeAppendString(Key: "minPrice", Value: "\(Int(VwRangeSliderView.lowerValue))", Filterbody: FilterBody)
            }
            if(VwRangeSliderView.upperValue != 0){
                FilterBody = MakeAppendString(Key: "maxPrice", Value: "\(Int(VwRangeSliderView.upperValue))", Filterbody: FilterBody)
            }
            
            print(FilterBody)
            
            MyOrderScreenVC.UrlExtraBody = FilterBody
            MyOrderScreenVC.delegate?.CallOrderAPI()
            
            self.dismiss(animated: true)
        }
    }
    
    //MARK: - Textfield Delegate Methods
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeTextField = textField
    }
    
    //MARK: - All Defined Functions
    
    func CreateDatePicker(forField field : UITextField){
        
        let datePicker = UIDatePicker()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat =  "MM-dd-yyyy"
        datePicker.datePickerMode = .date
        datePicker.addTarget(self, action: #selector(dateChange(datePicker:)), for: UIControl.Event.valueChanged)
        datePicker.frame.size = CGSize(width: 0, height: 300)
        datePicker.preferredDatePickerStyle = .inline
        datePicker.maximumDate = Date()
        datePicker.backgroundColor = UIColor.white
        datePicker.date = Date()
        field.inputView = datePicker
        field.inputAccessoryView = createToolbar()
        //        TfBirthday.text = formatDate(date: Date()) // todays Date
    }
    
    func formatDate(date: Date) -> String
    {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMM yyyy"
        return formatter.string(from: date)
    }
    
    func createToolbar() -> UIToolbar{
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        let Donebtn = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(DonePressed))
//        toolbar.setItems([Donebtn], animated: true)
        
        let ClearBtn = UIBarButtonItem(title: "Clear", style: .done, target: nil, action: #selector(ClearPressed))
        toolbar.setItems([Donebtn , ClearBtn], animated: true)
        
        return toolbar
    }
    
    func SetUI(){
        
        let TotalRange = MinPrice+MaxPrice
        
        VwRangeSliderView.minimumValue = Double(0)
        VwRangeSliderView.maximumValue = Double(MaxPrice)
//        VwRangeSliderView.stepValue = Double((TotalRange)/10)
        VwRangeSliderView.lowerValue = Double(0)
        VwRangeSliderView.upperValue = Double((TotalRange)/10)
        VwRangeSliderView.minimumDistance = Double((TotalRange)/10)
        
        lblMinPrice.text = "\(0)"
        lblMaxPrice.text = "\(MaxPrice)"
    }
    
    func MakeAppendString(Key: String , Value: String , Filterbody : String) -> String {
        
        var Body = Filterbody
        
        if Body.count == 1{
            Body.append(Key + "=" + Value)
        }else if (Body.count > 1){
            Body.append("&" + Key + "=" + Value)
        }
        
        return Body
    }
    
    //MARK: - All Objc Functions
    
    @objc func dateChange(datePicker: UIDatePicker){
        if activeTextField == TfFromDate {
            TfFromDate.text = formatDate(date: datePicker.date)
        } else if activeTextField == TfToDate {
            TfToDate.text = formatDate(date: datePicker.date)
        }
    }

    @objc func DonePressed(){
        self.view.endEditing(true)
    }
    
    @objc func ClearPressed(){
        if activeTextField == TfFromDate{
            TfFromDate.text = ""
        }
        else if activeTextField == TfToDate{
            TfToDate.text = ""
        }
    }
    
}
