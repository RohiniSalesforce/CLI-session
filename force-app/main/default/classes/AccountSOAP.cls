global with sharing class AccountSOAP {
    
    webservice static string getname(String name){
        return 'Hellow '+name;
    }
    
    webservice static string createaccount(String name){
        Account acc=new Account();
        acc.name=name;
        insert acc;
        return acc.Id;
    }
    webservice static InputWrapper createcontactviainputwrap(InputWrapper input){
       
        return input;
    }
    webservice static Lead createLead(Lead lead){
       
        return lead;
    }
    
    global class InputWrapper{
        webservice String firstname;
        webservice String Lastname;
        webservice String email;
        webservice String phone;
    }
    

}