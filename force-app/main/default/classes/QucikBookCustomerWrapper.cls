public class QucikBookCustomerWrapper {
   

    public String FullyQualifiedName;	    //King Groceries
	public PrimaryEmailAddr PrimaryEmailAddr;
	public String DisplayName;	    //King's Groceries
	public String Suffix;	    //Jr
	public String Title;	    //Mr
	public String MiddleName;	    //B
	public String Notes;	    //Here are other details.
	public String FamilyName;	    //King
	public PrimaryPhone PrimaryPhone;
	public String CompanyName;	    //King Groceries
	public BillAddr BillAddr;
	public String GivenName;	    //James
	public class PrimaryEmailAddr {
		public String Address;	    //jdrew@myemail.com
	}

	public class PrimaryPhone {
		public String FreeFormNumber;	    //(555) 555-5555
	}

	class BillAddr {
		public String CountrySubDivisionCode;	    //CA
		public String City;	    //Mountain View
		public String PostalCode;	    //94042
		public String Line1;	    //123 Main Street
		public String Country;	    //USA
	}
    
    
}