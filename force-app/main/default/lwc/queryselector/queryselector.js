import { LightningElement } from 'lwc';

export default class Queryselector extends LightningElement {
    userlist=['John Doe', 'Jane Smith', 'Alice Johnson'];
    fetchdetails() {    
        const element = this.template.querySelector('h1');
        console.log('Element:', element.innerText);
        const userlistquery = this.template.querySelectorAll('.name');
        Array.from(userlistquery).forEach((element) => {
            // to set the title element once we click on fetch button dynamically
            element.setAttribute('title', element.innerText);
            console.log('User:', element.innerText);
        }
        );
        const userlistquery2 = this.template.querySelector('.child');
        userlistquery2.innerHTML='<p> I am an child element</p>';
    }
}