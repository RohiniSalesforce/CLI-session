public with sharing class Quickbookresponsewrapper {
   
        public Customer Customer;
	 
     public class PrimaryEmailAddr {
		public String Address;	    //jdrew@myemail.com
	}

	public class CurrencyRef {
		public String name;	    //United States Dollar
		public String value;	    //USD
	}

	public class DefaultTaxCodeRef {
		public String value;	    //2
	}

	public class PrimaryPhone {
		public String FreeFormNumber;	    //(555) 555-5555
	}

	public class MetaData {
		public String CreateTime;	    //2015-07-23T10:58:12-07:00
		public String LastUpdatedTime;	    //2015-07-23T10:58:12-07:00
	}

	public class BillAddr {
		public String City;	    //Mountain View
		public String Country;	    //USA
		public String Line1;	    //123 Main Street
		public String PostalCode;	    //94042
		public String CountrySubDivisionCode;	    //CA
		public String Id;	    //112
	}	    //2015-07-23T10:58:12.099-07:00
	 public class Customer {
		public String domain;	    //QBO
		public PrimaryEmailAddr PrimaryEmailAddr;
		public String DisplayName;	    //King's Groceries
		public CurrencyRef CurrencyRef;
		public DefaultTaxCodeRef DefaultTaxCodeRef;
		public String PreferredDeliveryMethod;	    //Print
		public String GivenName;	    //James
		public String FullyQualifiedName;	    //King's Groceries
		public boolean BillWithParent;
		public String Title;	    //Mr
		public boolean Job;
		public Integer BalanceWithJobs;	    //0
		public PrimaryPhone PrimaryPhone;
		public boolean Taxable;
		public MetaData MetaData;
		public BillAddr BillAddr;
		public String MiddleName;	    //B
		public String Notes;	    //Here are other details.
		public boolean Active;
		public Integer Balance;	    //0
		public String SyncToken;	    //0
		public String Suffix;	    //Jr
		public String CompanyName;	    //King Groceries
		public String FamilyName;	    //King
		public String PrintOnCheckName;	    //King Groceries
		public boolean sparse;
		public String Id;	    //67
	}

	

    }
