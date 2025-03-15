global with sharing class WSDLAPEX {
   
    
        webservice static string getname(String name){
            return 'Hellow '+name;
        }
        

        webservice static InputWrapper createcontactviainputwrap(InputWrapper input){
           
            return input;
        }
        
        
        global class InputWrapper{
            webservice String firstname;
            webservice String Lastname;
            webservice String email;
            webservice String phone;
        }
        
    
    }
