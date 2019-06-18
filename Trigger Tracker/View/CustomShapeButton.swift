/*
 * Name: CustomShape Button Class
 * Description: Allows for the welcome screen buttons to be custom.
 * Author/Date: Tucker J. Mogren/ 1/18/2019
 */
import UIKit

@IBDesignable
class CustomShapeButton: UIButton
{
    /*
     * Function Name: customView()
     * Changes button color and corner radius, adds border
     * Tucker Mogren; 1/23/19
     */
    func CustomView ()
    {
        layer.cornerRadius = 15.0
        layer.borderWidth = 2.0
        layer.borderColor = #colorLiteral(red: 0.6431372549, green: 0.04705882353, blue: 0.9098039216, alpha: 1)
        backgroundColor = #colorLiteral(red: 0.1960784314, green: 0.3215686275, blue: 1, alpha: 1)
        setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
                
    }
    /*
     * Function Name: prepareForInterfaceBuilder()
     * Loads the customView after the objects have been updated - Guaranteed that all the outlets and actions are connected
     * Tucker Mogren; 1/23/19
     */
    override func prepareForInterfaceBuilder()
    {
        CustomView()
    }
    /*
     * Function Name: awakeFromNib()
     * Loads the customizeView after the objects have been updated - Guaranteed that all the outlets and actions are connected
     * Tucker Mogren; 1/23/19
     */
    override func awakeFromNib() {
        super.awakeFromNib()
        CustomView()
    }

}
