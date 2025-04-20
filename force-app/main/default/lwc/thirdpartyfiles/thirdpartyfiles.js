import { LightningElement } from 'lwc';
import jsfile from '@salesforce/resourceUrl/jsfile';
import animate from '@salesforce/resourceUrl/animate';
import { loadStyle } from 'lightning/platformResourceLoader';
import { loadScript } from 'lightning/platformResourceLoader';
export default class Thirdpartyfiles extends LightningElement {
       currentdate ;
    renderedCallback() {
        // 
        Promise.all([
            loadScript(this, jsfile + '/moment/moment.min.js'),
            loadStyle(this, animate + '/animate/animate.min.css')

        ])
            .then(() => {
                this.setDateonScreen();
                console.log('JS file loaded successfully');
                // You can now use the functions or variables defined in the JS file
            })
            .catch(error => {
                console.error('Error loading JS file:', error);
            });
    }
    // Call the function from the loaded JS file
    setDateonScreen(){
              this.currentdate = moment().format('MMMM Do YYYY, h:mm:ss a');
    }

}