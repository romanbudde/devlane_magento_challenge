<?php
// die('my sql installer');
$installer = $this;
$installer->startSetup();

/**
 * Create table 'roman_customergroups'
 */
$table = $installer->getConnection()
    ->newTable($installer->getTable('roman_customergroups'))
    ->addColumn('rule_id', Varien_Db_Ddl_Table::TYPE_INTEGER, null, array(
        'identity'  => true,
        'unsigned'  => true,
        'nullable'  => false,
        'primary'   => true,
        ), 'Rule id')
    ->addColumn('customer_group_id', Varien_Db_Ddl_Table::TYPE_SMALLINT, null, array(
        'unsigned'  => true,
        'nullable'  => false,
        'default'   => '0',
        ), 'Customer Group ID')
    ->addColumn('permissions_data', Varien_Db_Ddl_Table::TYPE_TEXT, '64k', array(
        'nullable' => true,
    ), 'Permissions Data')
    ->setComment('My comment');
    
$installer->getConnection()->createTable($table);

$installer->endSetup();
