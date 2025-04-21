import { LightningElement, wire } from 'lwc';
import { getNavItems } from 'lightning/uiAppsApi';

export default class getnavitem extends LightningElement {
    navitems ; // To store the navigation items

    @wire(getNavItems, { pageSize: 30, navItemNames: ['standard-Account'] }) // Fetch navigation items with a page size of 30
    navItemHandler({ error, data }) {
        if (data) {
            this.navitems = data.navItems[0]; // Store the navigation items
            console.log('Navigation Items:', this.navitems);
        } else if (error) {
            console.error('Error fetching navigation items:', error);
        }
    }
}