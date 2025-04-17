import { LightningElement } from 'lwc';

export default class Parenttochildcomponentsprimitve extends LightningElement {
    carouseldata=[
        {
        "src": "https://www.lightningdesignsystem.com/assets/images/carousel/carousel-01.jpg",
        "header": "First slide",
         "description": "W3Schools.com"
    },
    {
        "src": "https://www.lightningdesignsystem.com/assets/images/carousel/carousel-02.jpg",
        "header": "second slide",
         "description": "W3Schools.com"
    },
    {
        "src": "https://www.lightningdesignsystem.com/assets/images/carousel/carousel-03.jpg",
        "header": "third slode",
         "description": "W3Schools.com"
    }
]
somevalue=10
changehandler(event){
    this.somevalue=event.target.value;

}
handleclick(event){
    const childcomponent=this.template.querySelector('c-sliderchildcomponent');
    childcomponent.resetslider();

}
}