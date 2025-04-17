import { LightningElement ,api} from 'lwc';

export default class Setterchildcomponent extends LightningElement {
    
    userdetails
    @api 
    get detail(){
        return this.userdetails;
    }
    set detail(value){
        // value.age=value.age+1; -> if we do this wil throw an error, so better to create a shallow copy
        // as we are pass ing the reference of the object
       const newage=value.age+1;
        this.userdetails = {...value, age:newage,location:"India"};
    }
}