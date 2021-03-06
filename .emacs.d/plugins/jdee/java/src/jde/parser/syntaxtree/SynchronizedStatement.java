//
// Generated by JTB 1.1.2
//

package jde.parser.syntaxtree;

/**
 * Grammar production:
 * <PRE>
 * f0 -> "synchronized"
 * f1 -> "("
 * f2 -> Expression()
 * f3 -> ")"
 * f4 -> Block()
 * </PRE>
 */
public class SynchronizedStatement implements Node {
   public NodeToken f0;
   public NodeToken f1;
   public Expression f2;
   public NodeToken f3;
   public Block f4;

   public SynchronizedStatement(NodeToken n0, NodeToken n1, Expression n2, NodeToken n3, Block n4) {
      f0 = n0;
      f1 = n1;
      f2 = n2;
      f3 = n3;
      f4 = n4;
   }

   public SynchronizedStatement(Expression n0, Block n1) {
      f0 = new NodeToken("synchronized");
      f1 = new NodeToken("(");
      f2 = n0;
      f3 = new NodeToken(")");
      f4 = n1;
   }

   public void accept(jde.parser.visitor.Visitor v) {
      v.visit(this);
   }
}

