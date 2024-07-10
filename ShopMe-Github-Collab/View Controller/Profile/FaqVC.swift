//
//  FaqVC.swift
//  ShopMe-Github-Collab
//
//  Created by webcodegenie on 10/07/24.
//

import UIKit
import SVProgressHUD

class FaqVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var getFaqCategoryViewModel = GetFaqCategoryViewModel()
    var GetCategpryResponse: Get_Faq_Category_Main?
    
    var getFaqQueViewModel = GetFaqQueViewModel()
    var GetFaqQuestionResponse: Get_Faq_Question_Main?
    
    @IBOutlet weak var TvQuestionTable: UITableView!
    @IBOutlet weak var btnSelectCategory: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        TvQuestionTable.delegate = self
        TvQuestionTable.dataSource = self
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        CallAPIToGetCategory()
    }
    
    //MARK: - All IBActions
    
    @IBAction func OnClickCloseFAQ(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Tableview Delegate Methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return GetFaqQuestionResponse?.data?.faq?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let QuestionArr = GetFaqQuestionResponse?.data?.faq
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FaqQuestionTableCell") as! FaqQuestionTableCell
        
        cell.lblQuestionLable.text =  (QuestionArr?[indexPath.row].question ?? "")
        cell.lblAnswerLable.text = " Ans : " + (QuestionArr?[indexPath.row].answer ?? "")
        cell.selectionStyle = .none
        
        return cell
    }
    
    
    //MARK: - All Defined Functions
    
    func SetCategoryButton(){
        
        let CategoryArr = GetCategpryResponse?.data?.category
        
        let actionClosure = { [self] (action: UIAction) in
//            print(action.title)
            let SelectedIndex = CategoryArr?.firstIndex(where: {$0.name == action.title}) ?? 0
            
            let SelectedCategoryID = CategoryArr?[SelectedIndex]._id
            
            CallApiToGetQuestion(CategoryID : SelectedCategoryID ?? "")
        }
        
        var menuChildren: [UIMenuElement] = []
        for Index in 0...(GetCategpryResponse?.data?.category?.count ?? 0)-1 {
            menuChildren.append(UIAction(title: GetCategpryResponse?.data?.category?[Index].name ?? "", handler: actionClosure))
        }
        
        btnSelectCategory.menu = UIMenu(options: .displayInline, children: menuChildren)
        
        btnSelectCategory.showsMenuAsPrimaryAction = true
        btnSelectCategory.changesSelectionAsPrimaryAction = true
    }
    
    func CallAPIToGetCategory(){
        
            SVProgressHUD.show(withStatus: "Please Wait! \n While we are getting all the categories...")
            
            var request =  APIRequest(isLoader: true, method: .get, path: Constant.Get_Faq_Category, headers: HeaderValue.headerWithoutAuthToken.value, body: nil)
            
            getFaqCategoryViewModel.CallToGetCategory(request: request) { response in
                
                self.GetCategpryResponse = response
                DispatchQueue.main.async { [self] in
                    //Execute UI Code on Completion of API Call and getting data
                    CallApiToGetQuestion(CategoryID: GetCategpryResponse?.data?.category?[0]._id ?? "")
                    if GetCategpryResponse?.success == true{
                        
                        if GetCategpryResponse?.data?.category?.count == 0{
                            ShowAlertBox(Title: "No Category Found!", Message: "")
                        }
                        else{
                            SetCategoryButton()
                        }
                        
                    }else{
                        ShowAlertBox(Title: GetCategpryResponse?.message ?? "" , Message: "")
                    }
                    SVProgressHUD.dismiss()
                }
            } error: { error in
                print("========== API Error :",error)
                SVProgressHUD.dismiss()
            }
    }
    
    func CallApiToGetQuestion(CategoryID : String){
     
            SVProgressHUD.show(withStatus: "Please Wait! \nWhile We Are getting your Questions.")
            
            var request =  APIRequest(isLoader: true, method: .get, path: Constant.Get_Faq_Questions + CategoryID, headers: HeaderValue.headerWithoutAuthToken.value, body: nil)
            
            getFaqQueViewModel.CallToGetQuestion(request: request) { response in
                
                self.GetFaqQuestionResponse = response
                DispatchQueue.main.async { [self] in
                    //Execute UI Code on Completion of API Call and getting data
                    if GetFaqQuestionResponse?.success == true{
                        TvQuestionTable.reloadData()
                    }else{
                        ShowAlertBox(Title: GetFaqQuestionResponse?.message ?? "", Message: "")
                    }
                    
                    SVProgressHUD.dismiss()
                }
            } error: { error in
                print("========== API Error :",error)
                SVProgressHUD.dismiss()
            }
    }
}
