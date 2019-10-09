import java.util.*;

public class Graph {
	private Map<String, ArrayList<Pair<String,Integer>>> mapRep;
    public Graph() { 
		mapRep = new HashMap<String, ArrayList<Pair<String,Integer>>>();
	}
    public void addVertice(String label){

		mapRep.put(label, new ArrayList<Pair<String,Integer>>());
	}
    public void addEdge(String node1, String node2, int dist){ 

		/*The graph is undirected, so should add a neighbor to both
		 * node1 and node2.
		 */
		ArrayList<Pair<String,Integer>> neighbors1 = mapRep.get(node1);
		ArrayList<Pair<String,Integer>> neighbors2 = mapRep.get(node2);
		neighbors1.add(new Pair<String,Integer>(node2,dist));
		neighbors2.add(new Pair<String,Integer>(node1,dist));
	}
    
    public static class Path {
        public int totalDist;
        public List<String> vertices;
        public Path(int totalDist, List<String> vertices) {
            this.totalDist = totalDist;
            this.vertices = vertices;
        }

        @Override
        public String toString() {
            return "totalDist: " + totalDist + ", vertices: " + vertices.toString();
        }
    }
    
    public Path shortestPath(String start, String dest){ 
		Set<String> known = new HashSet<String>();
	
		Map<String,Integer> dv = new HashMap<String,Integer>();
		
		APrioMap<String,Integer> q = new APrioMap<String,Integer>();
		q.put(start,0);
	
		
        List<String> vertices = new ArrayList<String>();
        Map<String,String> previousNode=new HashMap<>();
        
		for(String key : mapRep.keySet()){
			dv.put(key,Integer.MAX_VALUE);
			previousNode.put(key,null);
		}
		dv.put(start,0);
        while(q.peek()!=null && q.peek().b < Integer.MAX_VALUE){
			Pair<String,Integer> v = q.poll();
			if( !known.contains(v.a) ){
				known.add(v.a);
				ArrayList<Pair<String,Integer>> neighbors = mapRep.get(v.a);
				for(int i=0; i<neighbors.size(); i++){
					
					Pair<String,Integer> v_prim = neighbors.get(i);
					
					
					if( (!known.contains(v_prim.a)) && (dv.get(v_prim.a) > dv.get(v.a)+ v_prim.b ) ){
						dv.put(v_prim.a, dv.get(v.a)+ v_prim.b );
						previousNode.put(v_prim.a, v.a);
						q.put(v_prim.a, dv.get(v_prim.a)); 
					}
				}
			}
        }
        
        
        String yee=dest;
        while(previousNode.get(yee)!=null){
				vertices.add(yee);
				yee=previousNode.get(yee);
		}
		vertices.add(start);
        Collections.reverse(vertices);
		
        if( dv.get(dest) == Integer.MAX_VALUE ){
			return null;
		}
		int totDist = dv.get(dest);
		return new Path(totDist, vertices );
		
	}
}
