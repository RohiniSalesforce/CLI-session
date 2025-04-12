import { LightningElement ,track} from 'lwc';

export default class Hello extends LightningElement {
    name = 'World';
    greeting = 'Hello';
    obj = { name: 'Object Name' };

    handleInputChange(event) {
        // Your logic here
        this.greeting = 'You typed: ' + event.target.value;
    }
    
    @track address={
            street: '123 Main St',
            city: 'Anytown',
            state: 'CA',
            zip: '12345'  
        }
    handleChange(event) { 
       
        this.address.street = event.target.value; 
    }
    users=["john","doe"]
    number=10;  
    number2=20;
    // since array the math expression is not allowed in lwc use getter
    get sum(){
        return this.number+this.number2
    }
    get firstusername(){
        return this.users[0]
    }
   
}