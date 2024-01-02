# devlane_magento_challenge

This is my project for the take home challenge for Devlane.  

The platform chosen for the task was Magento 1.9, specifically Magento 1.9.4.5, which was chosen mainly because I feel somewhat comfortable with it and understand many of its quirks (however, I'm more adept at Magento 2+ versions).  

The main idea behind the system was to build upon Magento's core functionality of Customer Groups, and make a custom module that adds an option (called "Customer Groups Permissions") to magento's /admin panel.  
Once the option is clicked, a menu is displayed that shows an item called "Permissions settings", and then, in that same adminhtml view, displays a block which is a form that shows all of the customer groups, giving the admin the ability to disable certain categories for certain customer groups, and even disable the checkout for that customer group.  

Moreover, adding customers to a customer group is simple and is managed by magento's native functionality.  
I've added, in my custom module, a sql installer script which creates the database table that will be necessary, `roman_customergroups`, in which each row will represent a customer group and its permissions data.  

Lastly, the last thing was to modify the list.phtml and topmenu.phtml, which are responsible for displaying categories and products to the user.  
Ideally, this should be done by creating a child theme of magento's default theme, but due to time limitations I have just modified magento's core .phtml files.
