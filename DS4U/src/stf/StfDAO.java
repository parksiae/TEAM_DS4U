package stf;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.sql.DataSource;
import javax.naming.Context;
import javax.naming.InitialContext;

public class StfDAO {

	DataSource dataSource;
	
	public StfDAO() {
		try {
			InitialContext initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/DS4U");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
    // �α��� ó�� �Լ�
    public int login(String STF_ID, String STF_PW) {
    	Connection conn = null;
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;
        String SQL = "SELECT * FROM STF WHERE STF_ID = ?";
        try {
        	conn = dataSource.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, STF_ID);
            rs = pstmt.executeQuery(); // ���� ����� ����
            if (rs.next()) {     // ����� �����ϸ�
                if(rs.getString("STF_PW").equals(STF_PW)) {// ����� ���� STF_PW�� �޾Ƽ� ������ �õ��� STF_PW�� �����ϴٸ�
                    return 1;    // �α��� ����
            	}
            	return 2; // ��й�ȣ ����
        	} else {
        		return 0; // ����� ����x
        	}            
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        	try {
        		if (rs != null) rs.close();
        		if (pstmt != null) pstmt.close();
        		if (conn != null) conn.close();
        	} catch (Exception e) {
        		e.printStackTrace();
        	}       	
        }
        return -1;      // DB ����       
	}
    
    public int registerCheck(String STF_ID) {
    	Connection conn = null;
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;
        String SQL = "SELECT * FROM STF WHERE STF_ID = ?";
        try {
        	conn = dataSource.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, STF_ID);
            rs = pstmt.executeQuery(); // ���� ����� ����
            if (rs.next() || STF_ID.equals("")) {     // ����� �����ϸ�
            	return 0; // �̹� �����ϴ� ȸ��
        	} else {
        		return 1; // ���� ������ ȸ��
        	}
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        	try {
        		if (rs != null) rs.close();
        		if (pstmt != null) pstmt.close();
        		if (conn != null) conn.close();
        	} catch (Exception e) {
        		e.printStackTrace();
        	}       	
        }
        return -1;      // DB ����       
	}
    
    public int register(String STF_ID, String STF_PW, String STF_NM, String STF_PH, String STF_EML, String STF_DEP) {
    	Connection conn = null;
    	PreparedStatement pstmt = null;
        String SQL = "INSERT INTO STF VALUES (?, ?, ?, ?, ?, ?)";
        try {
        	conn = dataSource.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, STF_ID);
            pstmt.setString(2, STF_PW);
            pstmt.setString(3, STF_NM);
            pstmt.setString(4, STF_PH);
            pstmt.setString(5, STF_EML);
            pstmt.setString(6, STF_DEP);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        	try {
        		if (pstmt != null) pstmt.close();
        		if (conn != null) conn.close();
        	} catch (Exception e) {
        		e.printStackTrace();
        	}       	
        }
        return -1;      // DB ����       
	}
    public StfDTO getUser(String STF_ID) {
    	StfDTO stf = new StfDTO();
    	Connection conn = null;
    	PreparedStatement pstmt = null;
    	ResultSet rs = null;
        String SQL = "SELECT * FROM STF WHERE STF_ID = ?";
        try {
        	conn = dataSource.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, STF_ID);
            rs = pstmt.executeQuery(); // ���� ����� ����
            if (rs.next()) {
            	stf.setSTF_ID(STF_ID);
            	stf.setSTF_PW(rs.getString("STF_PW"));
            	stf.setSTF_NM(rs.getString("STF_NM"));
            	stf.setSTF_PH(rs.getString("STF_PH"));
            	stf.setSTF_EML(rs.getString("STF_EML"));
            	stf.setSTF_DEP(rs.getString("STF_DEP"));
        	}
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        	try {
        		if (rs != null) rs.close();
        		if (pstmt != null) pstmt.close();
        		if (conn != null) conn.close();
        	} catch (Exception e) {
        		e.printStackTrace();
        	}       	
        }
        return stf;      // DB ����       
	}    
    public int update(String STF_ID, String STF_PW, String STF_NM, String STF_PH, String STF_EML, String STF_DEP) {
    	Connection conn = null;
    	PreparedStatement pstmt = null;
        String SQL = "UPDATE STF SET STF_PW = ?, STF_NM = ?, STF_PH = ?, STF_EML = ?, STF_DEP = ? WHERE STF_ID = ?";
        try {
        	conn = dataSource.getConnection();
            pstmt = conn.prepareStatement(SQL);
            pstmt.setString(1, STF_PW);
            pstmt.setString(2, STF_NM);
            pstmt.setString(3, STF_PH);
            pstmt.setString(4, STF_EML);
            pstmt.setString(5, STF_DEP);
            pstmt.setString(6, STF_ID);
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
        	try {
        		if (pstmt != null) pstmt.close();
        		if (conn != null) conn.close();
        	} catch (Exception e) {
        		e.printStackTrace();
        	}       	
        }
        return -1;      // DB ����       
	}
}
