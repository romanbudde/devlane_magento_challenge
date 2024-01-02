<?php
class Roman_Customerpermissions_Block_Adminhtml_Form extends Mage_Adminhtml_Block_Widget_Form
{
    protected function _prepareForm()
    {
        $form = new Varien_Data_Form(array(
            'id' => 'edit_form',
            'action' => $this->getUrl('*/*/save', array('_current' => true)),
            'method' => 'post'
        ));

        $fieldset = $form->addFieldset('base_fieldset', array('legend' => 'Change customer group permissions'));

        $fieldset->addField('save_button', 'submit', array(
            'label' => '',
            'value' => 'Save configuration',
            'onclick' => 'this.form.submit();',
            'class' => 'form-button'
        ));
        
        $customerGroups = Mage::getModel('customer/group')->getCollection();
        $categories = Mage::getModel('catalog/category')->getCollection()->addAttributeToSelect('name');

        foreach ($customerGroups as $customerGroup) {
            $fieldset->addField('customer_group_' . $customerGroup->getId(), 'note', array(
                'label' => 'Customer Group: ' . $customerGroup->getCustomerGroupCode(),
            ));
            
            // Add separation after each customer group
            $fieldset->addField('text_for_' . $customerGroup->getId(), 'note', array(
                'label' => 'Select the product categories you wish to DISABLE for this customer group',
            ));
            
            // $fieldset->addField('categories_note', 'note', array(
            //     'label' => 'Select the product categories you wish to disable for this customer group',
            // ));
            
            // $fieldset->addField('note_field', 'note', array(
            //     'label' => 'This is a note field. You can add your explanatory text here.',
            // ));
            
            foreach ($categories as $category) {
                $fieldset->addField('category_' . $category->getId() . '_for_' . $customerGroup->getId(), 'checkbox', array(
                    'label' => $category->getName(),
                    'name' => 'category[' . $customerGroup->getId() . '][]',
                    'value' => '1'
                ));
            }

            $fieldset->addField('disable_checkout_' . $customerGroup->getId(), 'checkbox', array(
                'label' => 'Disable checkout',
                'name' => 'disable_checkout[' . $customerGroup->getId() . ']',
                'value' => 1
            ));
            
            // Add separation after each customer group
            $fieldset->addField('separator_' . $customerGroup->getId(), 'note', array(
                'text' => '<br><br>', // Use '<br>' for a line break
            ));
        }

        $form->setUseContainer(true);
        $this->setForm($form);
        return parent::_prepareForm();
    }
}