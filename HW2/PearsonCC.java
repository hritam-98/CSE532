
import java.sql.*;


public class PearsonCC {
	private Connection con = null;
	private Statement stm =null;
	
	
	private double PearsonCC2(String dbname, String login, String passwd, String stock1, String stock2)
	{
		double tot_xom=0;
		double tot_aal=0;
		double stot_xom=0;
		double stot_aal=0;
		double tot=0;
		int N=0;
		double cc_comp=0;
		
		
		try {
			Class.forName("com.ibm.db2.jcc.DB2Driver");
			con=DriverManager.getConnection(dbname,login,passwd);
			
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		
		ResultSet rs = null;
		String qry="SELECT x.CLOSE AS XCLOSE, a.CLOSE AS YCLOSE FROM CSE532.Stock x, CSE532.Stock a WHERE x.DATE =a.DATE AND x.STOCKNAME <> a.STOCKNAME AND x.STOCKNAME ='XOM';";
		
		
		try {
			stm=con.createStatement();
			rs=stm.executeQuery(qry);
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		try {
			while(rs.next())
			{
				
					System.out.println("xclose:"+rs.getInt(1)+" yclose: "+rs.getString(2));
					
					tot_xom=tot_xom+rs.getFloat(1);
					tot_aal=tot_aal+rs.getFloat(2);
					stot_xom=stot_xom+(rs.getFloat(1)*rs.getFloat(1));
			        stot_aal=stot_aal+(rs.getFloat(2)*rs.getFloat(2));
			        tot=tot+(rs.getFloat(1)*rs.getFloat(2));
			        N=N+1;
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		cc_comp=((N*(tot))-(tot_xom*tot_aal))/Math.sqrt(((N*stot_xom)-(tot_xom*tot_xom))*((N*stot_aal)-(tot_aal*tot_aal)));	     
		return cc_comp;
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		String dburl ="jdbc:db2://0.0.0.0:25000/sample";
		String usr="db2admin";
		String pass="db2admin";
		String stk1="XOM";
		String stk2="AAL";
		double cc;
	
		
		PearsonCC p=new PearsonCC();
		cc=p.PearsonCC2(dburl,usr,pass,stk1,stk2);
		double scale=Math.pow(10, 3);
		System.out.println("CC:"+Math.round(cc*scale)/scale);
		
	}

}
