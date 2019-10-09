
import java.util.ArrayList;
import java.util.HashMap;

public class APrioMap<K,V extends Comparable<? super V>> implements PrioMap<K,V>{
	private ArrayList<Pair<K,V>> heapRep;
	private HashMap<K,Integer> mapRep; 
	
	public APrioMap(){
		heapRep = new ArrayList<>();
		mapRep = new HashMap<K,Integer>();
	}
	
	public void put(K k, V v){
		if(mapRep.containsKey(k)){
			int indexOfInsert = mapRep.get(k);
			if( heapRep.get(indexOfInsert).b.compareTo(v)<0){
				heapRep.set(indexOfInsert, new Pair<>(k,v));
				bubbleDown(indexOfInsert);
			}else{
				heapRep.set(indexOfInsert, new Pair<>(k,v));
				bubbleUp(indexOfInsert);
			}
		} else {
			heapRep.add(new Pair<>(k,v));
			int indexOfInsert = heapRep.size()-1;
			mapRep.put(k,indexOfInsert);
			bubbleUp(indexOfInsert);
		}	
	}
	
	public V get(K k){
		if(!mapRep.containsKey(k))
			return null;
		//System.out.println("In get: " + heapRep.get(mapRep.get(k)));
		return heapRep.get(mapRep.get(k)).b;
	}
	
	public Pair<K, V> peek(){
		if(heapRep.isEmpty())
			return null;
		return heapRep.get(0);
	}
	
	public Pair<K, V> poll(){
		if(heapRep.isEmpty())
			return null;
		Pair<K,V> topElement = heapRep.get(0);
		/*ArrayList remove method has O(1) when removing last element
		 * so do a swap to get the desired time complexity */
		int indexOfLastElement = heapRep.size()-1;
		swap(0,indexOfLastElement);
		mapRep.remove(topElement.a);
		heapRep.remove(indexOfLastElement);
		if(!heapRep.isEmpty())
			bubbleDown(0);
		return topElement;
	}
	
	public void swap(int i,int j){
		Pair<K,V> temp=heapRep.get(i);
		heapRep.set(i,heapRep.get(j));
		mapRep.put(heapRep.get(j).a, i);
		heapRep.set(j,temp);
		mapRep.put(temp.a,j);
		
    }

	public void bubbleUp(int startingIndex){
		int parentIndex;
		int currentIndex=startingIndex;
		while(currentIndex>0){
			parentIndex=(currentIndex-1)/2;
			if( ((heapRep.get(currentIndex).b).compareTo(heapRep.get(parentIndex).b))<0){
				swap(currentIndex,parentIndex);
				currentIndex=parentIndex;
			}else{
				break;
			}
		}
    }
    public void bubbleDown(int startingIndex){
		int currentIndex=startingIndex;
		int childIndex;
		if(heapRep.size()>1){
			while(2*currentIndex+1<heapRep.size()){
				childIndex=2*currentIndex+1;
				
				/*Check to see if right child is smaller than left child.
				 * If so, take right child instead */
				if(  ((childIndex + 1)<heapRep.size()) &&
				   (heapRep.get(childIndex).b.compareTo(heapRep.get(childIndex+1).b)>0)){
					childIndex++;
				}
				
				if( ((heapRep.get(childIndex).b).compareTo(heapRep.get(currentIndex).b))<0){
					swap(currentIndex,childIndex);
					currentIndex=childIndex;
				}else{
                    break;
                }
			}
		}
    }
    @Override
    public String toString() {
        return "APrioMap{" +
                "heap=" + heapRep +
                ", map=" + mapRep +
                '}';
    }
    
}
