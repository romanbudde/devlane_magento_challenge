# devlane_magento_challenge

This is my project for the take home challenge for Devlane.  

The platform chosen for the task was Magento 1.9, specifically Magento 1.9.4.5, which was chosen mainly because I feel somewhat comfortable with it and understand many of its quirks (however, I'm more adept at Magento 2+ versions).  

The main idea behind the system was to build upon Magento's core functionality of Customer Groups, and make a custom module that adds an option (called "Customer Groups Permissions") to magento's /admin panel.  
Once the option is clicked, a menu is displayed that shows an item called "Permissions settings", and then, in that same adminhtml view, displays a block which is a form that shows all of the customer groups, giving the admin the ability to disable certain categories for certain customer groups, and even disable the checkout for that customer group.  
The module is located at src/app/code/local/Roman/Customerpermissions and has 2 main config files, etc/config.xml and etc/adminhtml.xml. The first one helps register the module so that magento recognizes it, and registers the helper, model (for DB interaction, which was sadly left incomplete), resources and block (which displays the form I mentioned earlier, when clicking on the new nav option at /admin). The adminhtml.xml file takes care of adding the menu option to the nav, dictating among other things, the action that will happen when the option is clicked, which simply references the module's controller and executes its code, and the controller creates the Block which renders the form. Also, this controller is executed again when the form is saved, and uploads the changes to the database.

Moreover, adding customers to a customer group is simple and is managed by magento's native functionality.  
I've added, in my custom module, a sql installer script which creates the database table that will be necessary, `roman_customergroups`, in which each row will represent a customer group and its permissions data.  

Lastly, the last thing was to modify the list.phtml and topmenu.phtml, which are responsible for displaying categories and products to the user. The premise was that, once all of the customer groups permissions data was saved in the database, the second thing to do is either show or not show to the logged in user, certain products and categories, which is done by modifying list.phtml and topmenu.phtml files by adding the necessary validation there. And the last step was to modify this file frontend/base/default/template/checkout/onepage/link.phtml to disable checkout for those customers that belong to any of the customer groups that have the checkout disabled.  
Ideally, this should be done by creating a child theme of magento's default theme, but due to time limitations I have just modified magento's core .phtml files. To clarify, these 3 lines in app/design/frontend/rwd/default/template/catalog/product/list.phtml were left commented out because, as I mentioned earlier, the module's Model implementation still needed some work done to be fully functional.
```
$permissionsModel = Mage::getModel('roman_customergroups/permission');
$permissionsCollection = $permissionsModel->getCollection();
$permissionsData = $permissionsCollection->getData();
```

Thank you for your time.
