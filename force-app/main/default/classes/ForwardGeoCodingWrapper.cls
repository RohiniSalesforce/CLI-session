public with sharing class ForwardGeoCodingWrapper {
 
	public String documentation;	//https://opencagedata.com/api
	public licenses[] licenses;
	public rate rate;
	public results[] results;
	public status status;
	public stay_informed stay_informed;
	public String thanks;	//For using an OpenCage API
	public timestamp timestamp;
	public Integer total_results;	//2
	public class licenses {
	}
	public class rate {
	}
	public class results {
		public annotations annotations;
		public bounds bounds;
		public components components;
		public Integer confidence;	//9
		public String formatted;	//Goethe-Nationalmuseum, Frauenplan 1, 99423 Weimar, Germany
		public geometry geometry;
	}
	public class annotations {
		public DMS DMS;
		public String MGRS;	//32UPB6346249905
		public String Maidenhead;	//JO50px94ko
		public Mercator Mercator;
		public NUTS NUTS;
		public OSM OSM;
		public Integer callingcode;	//49
		public String flag;	//🇩🇪
		public String geohash;	//u3041b1jw0trrfc4svjg
		public Double qibla;	//132.4
		public roadinfo roadinfo;
		public timezone timezone;
		public what3words what3words;
		public String wikidata;	//Q882721
	}
	public class DMS {
		public String lat;	//50° 58' 39.03816'' N
		public String lng;	//11° 19' 42.75264'' E
	}
	public class Mercator {
		public Double x;	//1261087.577
		public Double y;	//6584100.003
	}
	public class NUTS {
		public NUTS0 NUTS0;
		public NUTS1 NUTS1;
		public NUTS2 NUTS2;
		public NUTS3 NUTS3;
	}
	public class NUTS0 {
		public String code;	//DE
	}
	public class NUTS1 {
		public String code;	//DEG
	}
	public class NUTS2 {
		public String code;	//DEG0
	}
	public class NUTS3 {
		public String code;	//DEG05
	}
	public class OSM {
		public String edit_url;	//https://www.openstreetmap.org/edit?relation=3145143#map=17/50.97751/11.32854
		public String note_url;	//https://www.openstreetmap.org/note/new#map=17/50.97751/11.32854&layers=N
		public String url;	//https://www.openstreetmap.org/?mlat=50.97751&mlon=11.32854#map=17/50.97751/11.32854
	}
	public class regions {
		public String DE;	//276
		public String EUROPE;	//150
		public String WESTERN_EUROPE;	//155
		public String WORLD;	//001
	}
	public class alternate_symbols {
	}
	public class roadinfo {
		public String drive_on;	//right
		public String road;	//Frauenplan
		public String speed_in;	//km/h
	}
	public class rise {
		public Integer apparent;	//1740549960
		public Integer astronomical;	//1740543420
		public Integer civil;	//1740547980
		public Integer nautical;	//1740545700
	}
	public class timezone {
		public String name;	//Europe/Berlin
		public Integer now_in_dst;	//0
		public Integer offset_sec;	//3600
		public String offset_string;	//+0100
		public String short_name;	//CET
	}
	public class what3words {
		public String words;	//rock.broker.partied
	}
	public class bounds {
	}
	public class components {
	}
	public class geometry {
	}
	public class status {
	}
	public class stay_informed {
	}
	public class timestamp {
	}
	
}
	
