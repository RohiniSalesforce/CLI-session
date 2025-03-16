/**
 * @description       : 
 * @author            : Amit Singh - PantherSchools
 * @group             : 
 * @last modified on  : 06-08-2024
 * @last modified by  : Amit Singh - PantherSchools
**/
@IsTest
public with sharing class MetadataUtilsTest {
    @IsTest
    public static void listMetadataTest(){
        Test.setMock(WebServiceMock.class, new MetadataUtilsMock());
        Test.startTest();
        MetadataUtil.listMetadata('Admin');
        Test.stopTest();
    }

    @IsTest
    public static void readMetadataTest(){
        Test.setMock(WebServiceMock.class, new MetadataUtilsMock());
        Test.startTest();
        MetadataUtil.readMetadata();
        Test.stopTest();
    }

    @IsTest
    public static void createObjectTest(){
        Test.setMock(WebServiceMock.class, new MetadataUtilsMock());
        Test.startTest();
        MetadataUtil.createObject('Invoice', 'Invoices','hjjhh');
        Test.stopTest();
    }

    @IsTest
    public static void createFieldsTest(){
        Test.setMock(WebServiceMock.class, new MetadataUtilsMock());
        Test.startTest();
        MetadataUtil.createFields('Account', 'Active',true,true,true,true);
        Test.stopTest();
    }
}