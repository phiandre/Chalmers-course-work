import java.util.*;
public class BinSearchGenSet<E extends Comparable<? super E>> implements GenSet<E>{
    
    private ArrayList<E> datArr;
    public BinSearchGenSet(){
	datArr=new ArrayList<E>();

    }
    public void add(E element){
	if(datArr.contains(element)){
	    return;
	}

	int indexOfInsert;
        for(indexOfInsert=0;indexOfInsert<datArr.size();indexOfInsert++){
            if(datArr.get(indexOfInsert).compareTo(element)>0){
                break;
            }
        }
	datArr.add(indexOfInsert,element);
   
	
    }
    public void remove(E element){
	if(datArr.contains(element)){
	    datArr.remove(element);
	    return;
	}
	return;
    }

	
	
    
    
    public boolean contains(E element){
	if(binarySearch(element)>=0)
	    return true;
	else
	    return false;
	
    }
    public int binarySearch(E element){
	int lowIndex = 0;
	int maxIndex = datArr.size()-1;
	//	System.out.println(Arrays.toString(datArr.toArray()));
	while(lowIndex<=maxIndex){
	    int middleIndex = ((lowIndex+maxIndex)/2);

	    if( datArr.get(middleIndex).compareTo( element)<0)
		{
		    //		    System.out.println(datArr.get(middleIndex).compareTo( element));
		    lowIndex = middleIndex + 1;
		}
	    else if( datArr.get(middleIndex).compareTo(element) > 0)
		{
		    // System.out.println(datArr.get(middleIndex).compareTo( element));
                   
		    maxIndex = middleIndex - 1;
		}
	    else
		{
		    return middleIndex;
		}
	}
	
	return -1;
    }
}
   
