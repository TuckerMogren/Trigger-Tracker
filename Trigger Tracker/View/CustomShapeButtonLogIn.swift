/*
 * Name: CustomShape Button Class
 * Description: Allows for the login button to be colored and have a corner.
 * Author/Date: Tucker J. Mogren/ 1/13/2019
 */
import UIKit

@IBDesignable
class CustomShapeButtonLogIn: UIButton
{

    // const background color class global var. 
    let chosenBackgroundColor = #colorLiteral(red: 0.5810584426, green: 0.1285524964, blue: 0.5745313764, alpha: 1)
    /*
     * Function Name: customizeView()
     * Changes button color and corner radius
     * Tucker Mogren; 1/23/19
     */
    func customizeView()
    {
        backgroundColor = .clear
        layer.cornerRadius = 10.0
        layer.borderWidth = 0.01
        layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        backgroundColor = chosenBackgroundColor
    }

    /*
     * Function Name: awakeFromNib()
     * Loads the customizeView after the objects have been updated - Guaranteed that all the outlets and actions are connected
     * Tucker Mogren; 1/23/19
     */
    override func prepareForInterfaceBuilder() {
        customizeView()
    }
    /*
     * Function Name: awakeFromNib()
     * Loads the customizeView after the objects have been updated - Guaranteed that all the outlets and actions are connected
     * Tucker Mogren; 1/23/19
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        customizeView()
    }
 
}
