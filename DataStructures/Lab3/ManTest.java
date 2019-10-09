
public class ManTest{
	public static void main(String[] args){
		Graph g = new Graph();
		g.addVertice("V0");
		g.addVertice("V1");
		g.addEdge("V0", "V1", 0);
		System.out.println(g.shortestPath("V0", "V1"));
	}
}
