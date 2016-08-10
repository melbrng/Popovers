import UIKit

class MainViewController: UIViewController, UIPopoverPresentationControllerDelegate
{
  let picker = UIImageView(image: UIImage(named: "picker"))
  
  struct properties {
    static let moods = [
      ["title" : "the best", "color" : "#8647b7"],
      ["title" : "really good", "color": "#4870b7"],
      ["title" : "okay", "color" : "#45a85a"],
      ["title" : "meh", "color" : "#a8a23f"],
      ["title" : "not so great", "color" : "#c6802e"],
      ["title" : "the worst", "color" : "#b05050"]
    ]
  }
  
  @IBAction func pickerSelect(sender: UIButton)
  {
    picker.hidden ? openPicker() : closePicker()
  }
  
  func createPicker()
  {
    picker.frame = CGRect(x: ((self.view.frame.width / 2) - 143), y: 200, width: 286, height: 291)
    picker.alpha = 0
    picker.hidden = true
    picker.userInteractionEnabled = true
    
    var offset = 21
    
    for (index, feeling) in properties.moods.enumerate()
    {
      let button = UIButton()
      button.frame = CGRect(x: 13, y: offset, width: 260, height: 43)
     // button.setTitleColor(UIColor(rgba: feeling["color"]!), forState: .Normal)
        
    button.setTitleColor(UIColor.blackColor(), forState: .Normal)
      button.setTitle(feeling["title"], forState: .Normal)
      button.tag = index
      button.addTarget(self, action: #selector(buttonTouchDown), forControlEvents: .TouchDown)
      
      picker.addSubview(button)
      
      offset += 44
    }
    
    view.addSubview(picker)
  }
    

    //This function will allow one selection and falsify previously selected buttons
    func buttonTouchDown(sender: UIButton!){

        for view in picker.subviews {
            
            if let button = view as? UIButton{
                if button.selected == true {
                    button.selected = false
                    button.setTitleColor(UIColor.blackColor(), forState: .Normal)
                }
            }
            
            
        }
        
        sender.selected = true
        sender.setTitleColor(UIColor.blueColor(), forState: .Normal)
        
    }
    
    //this will select and deselect a single entry and allow for multiple selections
//    func buttonTouchDown(sender: UIButton!){
//        print("selected : " + String(sender.selected))
//        sender.selected = !sender.selected
//        
//        if(sender.selected == true){
//            
//            
//            sender.setTitleColor(UIColor.blueColor(), forState: .Normal)
//            
//        }else {
//            
//            sender.setTitleColor(UIColor.blackColor(), forState: .Normal)
//            
//        }
//    }
  
  func openPicker()
  {
    self.picker.hidden = false
    
    UIView.animateWithDuration(0.3,
      animations: {
        self.picker.frame = CGRect(x: ((self.view.frame.width / 2) - 143), y: 230, width: 286, height: 291)
        self.picker.alpha = 1
      })
  }
  
  func closePicker()
  {
    UIView.animateWithDuration(0.3,
      animations: {
        self.picker.frame = CGRect(x: ((self.view.frame.width / 2) - 143), y: 200, width: 286, height: 291)
        self.picker.alpha = 0
      },
      completion: { finished in
        self.picker.hidden = true
      }
    )
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    createPicker()
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
  {
    let popupView = segue.destinationViewController
    if let popup = popupView.popoverPresentationController
    {
        popup.delegate = self
    }
  }
  
  func adaptivePresentationStyleForPresentationController(controller: UIPresentationController) -> UIModalPresentationStyle
  {
    return UIModalPresentationStyle.None
  }

}
