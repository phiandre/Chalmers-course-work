//import java.util.Arrays;

public class BinSearchIntSet implements IntSet{
    private int datArr[];
    private int usedSize;
    public BinSearchIntSet(){
		datArr = new int[2];
		usedSize=0;
    }
    
    /*Method for adding a new element to the set. This is done by creating
     *a new primitive array which can hold one additional element and 
x     *copying all the old elements from the last array and finally adding
     * the new element.
     */
    public void add(int element){
	//If the element is already in the set, do nothing.
	int findIndex = binarySearch(element);
	if(findIndex > 0)
	    return;
	    
	int indexOfInsert = (findIndex+1)*(-1);

	usedSize++;
	int[] temp;
	if (usedSize>datArr.length){
 	    temp = new int[2*datArr.length];
	    for(int i=0;i<datArr.length;i++){
			temp[i]=datArr[i];
	    }
	    datArr = temp;
	}
	
	//else{
	//   temp= new int[datArr.length];
	//	}
	//	int minSize=Math.min(temp.length,datArr.length);
	//	}
	/*
	int indexOfInsert;
	for(indexOfInsert=0;indexOfInsert<usedSize-1;indexOfInsert++){
	    if(datArr[indexOfInsert]>element){
			break;
	    }
	}*/
	for(int i=usedSize-2;i>=indexOfInsert;i=i-1){
	    datArr[i+1]=datArr[i];
	}
	datArr[indexOfInsert]=element;
	   
    }
    
    public boolean contains(int element){
	if(binarySearch(element)>=0)
	    return true;
	else 
	    return false;
    }
    

    


    /*
    public void remove(int element){
	int removeIndex = binarySearch(element);
	if(removeIndex >=0){
	    int temp[] = new int[datArr.length-1];
	    
	    for(int i=removeIndex; i<datArr.length-1; i++){
		temp[removeIndex]=datArr[removeIndex+1];
	    }
	    for(int i=0; i<removeIndex; i++){
		temp[i] = datArr[i];
	    }
	    datArr = temp;
	    return;
	    }
	
	return;
	
    }*/
    public void remove(int element){
	int removeIndex=binarySearch(element);
	if(removeIndex > 0){
	    int temp[]=new int[datArr.length];
	    usedSize=usedSize-1;
	    for( int i=removeIndex; i<datArr.length-1;i++){
			temp[i]=datArr[i+1];
	    }
	    for(int i=0; i<removeIndex;i++){
			temp[i]=datArr[i];
	    }
	    datArr=temp;
	}
    }


    
    /*Method for conducting binarySearch
     */ 
    public int binarySearch(int element){
	int lowIndex = 0;
	int maxIndex = usedSize-1;
	    
	while(lowIndex<=maxIndex){
	    int middleIndex = ((lowIndex+maxIndex)/2);
	        
	    if( datArr[middleIndex] < element)
		{
		    lowIndex = middleIndex + 1;
		} 
	    else if( datArr[middleIndex] > element) 
		{
		    maxIndex = middleIndex - 1;
		} 
	    else 
		{
		    return middleIndex;
		}
	}
	return -1-lowIndex;
    }
}
