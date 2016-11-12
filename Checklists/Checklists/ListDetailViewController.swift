import UIKit

protocol ListDetailViewControllerDelegate: class
{
	func listDetailViewControllerDidCancel(
		_ controller: ListDetailViewController)
	func listDetailViewController(_ controller: ListDetailViewController,
	                              didFinishAdding checklist: Checklist)
	func listDetailViewController(_ controller: ListDetailViewController,
	                              didFinishEditing checklist: Checklist)
}

class ListDetailViewController: UITableViewController, UITextFieldDelegate, IconPickerViewControllerDelegate
{
	@IBOutlet weak var doneBarButton: UIBarButtonItem!
	@IBOutlet weak var textField: UITextField!
	weak var delegate: ListDetailViewControllerDelegate?
	var checklistToEdit: Checklist?
	@IBOutlet weak var iconImageView: UIImageView!
	var iconName = "Folder"
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		if let checklist = checklistToEdit
		{
			title = "Edit Checklist"
			textField.text = checklist.name
			doneBarButton.isEnabled = true
			iconName = checklist.iconName
			iconImageView.image = UIImage(named: iconName)
		}
	}
	
	override func viewWillAppear(_ animated: Bool)
	{
		super.viewWillAppear(animated)
		textField.becomeFirstResponder()
	}
	
	@IBAction func cancel()
	{
		delegate?.listDetailViewControllerDidCancel(self)
	}
	
	@IBAction func done()
	{
		if let checklist = checklistToEdit
		{
			checklist.name = textField.text!
			checklist.iconName = iconName
			delegate?.listDetailViewController(self, didFinishEditing: checklist)
		}
		else
		{
			let checklist = Checklist(name: textField.text!, iconName: iconName)
			checklist.iconName = iconName
			delegate?.listDetailViewController(self, didFinishAdding: checklist)
		}
	}
	
	override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath?
	{
		if indexPath.section == 1
		{
			return indexPath
		}
		else
		{
			return nil
		}
	}
	
	func textField(_ textField: UITextField,
	               shouldChangeCharactersIn range: NSRange,
	               replacementString string: String) -> Bool
	{
		let oldText = textField.text! as NSString
		let newText = oldText.replacingCharacters(in: range, with: string) as NSString
		doneBarButton.isEnabled = (newText.length > 0)
		
		return true
	}
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?)
	{
		if segue.identifier == "PickIcon"
		{
			let controller = segue.destination as! IconPickerViewController
			controller.delegate = self
		}
	}
	
	func iconPicker(_ picker: IconPickerViewController, didPick iconName: String)
	{
		self.iconName = iconName
		iconImageView.image = UIImage(named: iconName)
		
		// You don’t call dismiss() here but popViewController(animated) because the Icon Picker is on the navigation stack.
		// When creating the segue you used the segue style “show” instead of “present modally”, which pushes the new view controller
		// on the navigation stack. To return you need to “pop” it off again. (dismiss() is for modal screens only,
		// not for push screens.
		let _ = navigationController?.popViewController(animated: true)
	}
	
}
