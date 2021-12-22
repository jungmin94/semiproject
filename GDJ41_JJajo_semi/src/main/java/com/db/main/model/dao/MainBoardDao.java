package com.db.main.model.dao;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.db.main.model.vo.MainBoard;
import static com.jj.common.JDBCTemplate.close;

public class MainBoardDao {
	private Properties prop = new Properties();
	
	public MainBoardDao() {
		String path = MainBoardDao.class.getResource("/sql/mainBoard/mainboardsql.properties").getPath();
		try {
			prop.load(new FileReader(path));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	public List<MainBoard> searchMainBoard(Connection conn, int curPosition, int numPerOnce) {
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		List<MainBoard> mbList = new ArrayList();
		String sql = prop.getProperty("searchMainBoard");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (curPosition-1)*numPerOnce+1);
			pstmt.setInt(2, curPosition*numPerOnce);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MainBoard mb = MainBoard.builder().boardNo(rs.getString("board_no"))		
									.boardTitle(rs.getString("board_title"))
									.boardContent(rs.getString("board_content"))
									.boardDate(rs.getDate("board_date"))
									.deleteYn(rs.getString("delete_yn"))
									.updateDate(rs.getDate("update_date"))
									.memberNo(rs.getString("member_no"))
									.build();
				mbList.add(mb);
						
			}
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		
		return mbList;
	}
	
	
	
	
	//jy
	//태그랑 사진파일 추가해야하는데 아직 어떻게 해야하는지 모름.. 일단 제목,내용,멤버넘버만 추가함
	public int insertMainBoard(Connection conn, MainBoard mb, String memberNo) {
		PreparedStatement pstmt=null;
		int result=0;
		String sql=prop.getProperty("insertMainBoard");
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, mb.getBoardTitle());
			pstmt.setString(2, mb.getBoardContent());
			pstmt.setString(3,memberNo);
			result=pstmt.executeUpdate();
		}catch(SQLException e){
			e.printStackTrace();
		}finally {
			close(pstmt);
		}return result;	
	}
	

	
	public int insertImage(Connection conn, MainBoard mb, int postNo) {
		PreparedStatement pstmt=null;
		int result=0;
		String sql=prop.getProperty("insertImage");
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, postNo);
			result=pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}return result;
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	

}
