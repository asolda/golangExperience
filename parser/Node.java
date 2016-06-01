import java.util.ArrayList;
import java.util.List;

public class Node<T> {
    private List<Node<T>> children = new ArrayList<Node<T>>();
    private Node<T> parent = null;
    private T data = null;

    public Node(T data) {
        this.data = data;
    }

    public Node(T data, Node<T> parent) {
        this.data = data;
        this.parent = parent;
    }

    public List<Node<T>> getChildren() {
        return children;
    }

    public void visita(Node<String> n){
	if(n.getChildren().size()==0){
		System.out.println(n.getData()+"<----"+n.getParent().getData());
		return;
	}
	for(int i=0;i<n.getChildren().size();i++){
		visita(n.getChildren().get(i));
	}
        if(n.getParent()!=null)
	   System.out.println(n.getData()+"<----"+n.getParent().getData());
        else
         System.out.println(n.getData());
    }

    private void setParent(Node<T> parent) {
        //parent.addChild(this,parent);
        this.parent = parent;
    }

    public Node<T> getParent() {
        return parent;
    }

    public void addChild(T data, Node<T> parent) {
        Node<T> child = new Node<T>(data);
        child.setParent(parent);
        this.children.add(child);
    }

    public void addChild(Node<T> child, Node<T> parent) {
        child.setParent(parent);
        this.children.add(child);
    }

    public T getData() {
        return this.data;
    }

    public void setData(T data) {
        this.data = data;
    }

    public boolean isRoot() {
        return (this.parent == null);
    }

    public boolean isLeaf() {
        if(this.children.size() == 0) 
            return true;
        else 
            return false;
    }

    public void removeParent() {
        this.parent = null;
    }
}



