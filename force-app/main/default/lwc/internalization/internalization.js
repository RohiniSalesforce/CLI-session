import { LightningElement } from 'lwc';
import locale from '@salesforce/i18n/locale';
import currency from '@salesforce/i18n/currency';
import dateTime from '@salesforce/i18n/dateTime';
import dir from '@salesforce/i18n/dir';
import timeZone from '@salesforce/i18n/timeZone';
export default class Internalization extends LightningElement {
    dt = new Intl.DateTimeFormat(locale, {
        timeZone: timeZone,
        dateStyle: 'full', // Full date format (e.g., "Monday, April 20, 2025")
        timeStyle: 'long' // Long time format (e.g., "3:45:12 PM GMT+5:30")
    }).format(new Date());
    direction='rtl'; //dir;
    tZone=timeZone;
    number=99.87;
    formatnumber=new Intl.NumberFormat(locale,{
        style:'currency',
        currency:currency,
        currencyDisplay:'symbol'
    }).format(this.number);
}