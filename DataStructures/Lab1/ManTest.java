public class ManTest{
	public static void main(String[] args){
		
	    IntSet set = new BinSearchIntSet();
		set.add(3);
		set.add(1);
		set.add(2);
		set.remove(1);
		System.out.println(set.contains(0));  // result: false
		System.out.println(set.contains(1));  // result: false
		set.add(7);
		System.out.println(set.contains(0));  // result: true
	    
		
	}
}
