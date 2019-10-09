import java.util.Iterator;
import java.util.Comparator;
import java.util.HashMap;


public class StockTrade {
    private PrioQueue<Bid> sellersQueue;
    private PrioQueue<Bid> buyersQueue;
    private HashMap<String, Integer> buyersMap;
    private HashMap<String, Integer> sellersMap;
    
    private class SellersComparator implements Comparator<Bid>{
        public int compare(Bid bid1,Bid bid2){
            int first=bid1.price;
            int second= bid2.price;
            if(first<second){
                return -1;
<<<<<<< HEAD
            }
            else if(second<first){
                return 1;
=======
>>>>>>> b4d1bfe15135daa05824140bab6c193c89f67cb7
            }
            else if(first>second){
                return 1;
            }
            else{
                return 0;
            }
        }
        
    }
    private class BuyersComparator implements Comparator<Bid>{
        public int compare(Bid bid1, Bid bid2){
            int first=bid1.price;
            int second= bid2.price;
<<<<<<< HEAD
            if(first<second){
                return 1;
            }
            else if(second<first){
                return -1;
=======
            if(first>second){
                return -1;
            }
            else if(first<second){
                return 1;
>>>>>>> b4d1bfe15135daa05824140bab6c193c89f67cb7
            }
            else{
                return 0;
            }
        }
    }
    
    public StockTrade() {
        sellersQueue =new BinHeap<Bid>(new SellersComparator());
        buyersQueue = new BinHeap<Bid>(new BuyersComparator());
        buyersMap = new HashMap<String, Integer>();    
        sellersMap = new HashMap<String, Integer>();
    }

    public Transaction placeSellBid(Bid bid) {
		/* check in hashmap if the bidder already has put in a bid. 
		 * Remove from both hashMap and Priority queue if so. */
		if(sellersMap.containsKey(bid.name)){
			int value = sellersMap.remove(bid.name);
			sellersQueue.remove(new Bid(bid.name,value));
		}
	
        sellersQueue.add(bid);
        sellersMap.put(bid.name, bid.price);
        
        if( (buyersQueue.peek() != null) &&  ( buyersQueue.peek().price >= sellersQueue.peek().price ) ){
			Bid buyersBid = buyersQueue.poll();
			Bid sellersBid = sellersQueue.poll();
			buyersMap.remove(buyersBid.name, buyersBid.price);
			sellersMap.remove(sellersBid.name, sellersBid.price);
			return new Transaction(sellersBid.name,buyersBid.name,buyersBid.price);
		}
        return null;
    }
    
    public Transaction placeBuyBid(Bid bid){
		if(buyersMap.containsKey(bid.name)){
		    int value = buyersMap.remove(bid.name);
		    buyersQueue.remove(new Bid(bid.name,value));	
		}
		
        buyersQueue.add(bid);
        buyersMap.put(bid.name, bid.price);
        
        if( (sellersQueue.peek() != null) &&  ( buyersQueue.peek().price >= sellersQueue.peek().price ) ){
			Bid buyersBid = buyersQueue.poll();
			Bid sellersBid = sellersQueue.poll();
			buyersMap.remove(buyersBid.name, buyersBid.price);
			sellersMap.remove(sellersBid.name, sellersBid.price);
			return new Transaction(sellersBid.name,buyersBid.name,buyersBid.price);
		}
        return null;
    }

    public Iterator<Bid> sellBidsIterator() {
        return sellersQueue.iterator();
    }

    public Iterator<Bid> buyBidsIterator() {
        return buyersQueue.iterator();
    }
}
