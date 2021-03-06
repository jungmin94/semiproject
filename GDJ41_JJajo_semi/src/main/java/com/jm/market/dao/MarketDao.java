package com.jm.market.dao;

import static com.jj.common.JDBCTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.jj.member.model.vo.Member;
import com.jm.market.model.vo.AttachedFiles;
import com.jm.market.model.vo.Comment;
import com.jm.market.model.vo.ProductBoard;

public class MarketDao {

	private Properties prop = new Properties();
	
	public MarketDao(){
		
		try {
			String path=MarketDao.class.getResource("/sql/market/market.properties").getPath();
			prop.load(new FileReader(path));
		}catch(IOException e) {
			e.printStackTrace();
		}
	
	
	}
	
	public List<ProductBoard> allProduct(Connection conn){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ProductBoard pb=null;
		//AttachedFiles file=null;
		List<ProductBoard> list = new ArrayList();
		//List<AttachedFiles> files = new ArrayList();
		String sql=prop.getProperty("allProduct");
		String sql2=prop.getProperty("allAttachedfiles");
		
		try { 
			pstmt=conn.prepareStatement(sql);
			rs=pstmt.executeQuery();
			
			pstmt.clearParameters();
			
			while(rs.next()) {
				pstmt=conn.prepareStatement(sql2);
				int productNo=rs.getInt("pd_no");
				
				pstmt.setInt(1,productNo);
				ResultSet rs2=pstmt.executeQuery();
				List<AttachedFiles> files = new ArrayList();
				while(rs2.next()) {
					AttachedFiles file=AttachedFiles.builder().fileName(rs2.getString("filename")).build();
					files.add(file);
					
				}
				
				pb=ProductBoard.builder().productNo(rs.getInt("pd_no"))
										 .title(rs.getString("pd_title"))
										 .category(rs.getString("pd_category"))
										 .content(rs.getString("pd_content"))
										 .price(rs.getInt("pd_price"))
										 .address(rs.getString("pd_address"))
										 .enrollDate(rs.getDate("pd_enrolldate"))
										 .isSale(rs.getString("pd_sale"))
										 .isDelete(rs.getString("pd_delete"))
										 .memberNo(rs.getInt("member_no")) 
										 .member_name(rs.getString("member_name"))
										 .fileName(files)
										 .build();
				close(rs2);
				list.add(pb);
				pstmt.clearParameters();
			}
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return list;
		
		
	}
	
	
	
	public List<ProductBoard> categoryMain(Connection conn, String category){
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		ProductBoard pb=null;
		//AttachedFiles file=null;
		List<ProductBoard> list = new ArrayList();
		//List<AttachedFiles> files = new ArrayList();
		String sql=prop.getProperty("categoryCheck");
		String sql2=prop.getProperty("allAttachedfiles");
		
		try { 
			pstmt=conn.prepareStatement(sql);
			pstmt.setString(1, category);
			rs=pstmt.executeQuery();
			
			pstmt.clearParameters();
			
			while(rs.next()) {
				pstmt=conn.prepareStatement(sql2);
				int productNo=rs.getInt("pd_no");
				
				pstmt.setInt(1,productNo);
				ResultSet rs2=pstmt.executeQuery();
				List<AttachedFiles> files = new ArrayList();
				while(rs2.next()) {
					AttachedFiles file=AttachedFiles.builder().fileName(rs2.getString("filename")).build();
					files.add(file);
					
				}
				
				pb=ProductBoard.builder().productNo(rs.getInt("pd_no"))
										 .title(rs.getString("pd_title"))
										 .category(rs.getString("pd_category"))
										 .content(rs.getString("pd_content"))
										 .price(rs.getInt("pd_price"))
										 .address(rs.getString("pd_address"))
										 .enrollDate(rs.getDate("pd_enrolldate"))
										 .isSale(rs.getString("pd_sale"))
										 .isDelete(rs.getString("pd_delete"))
										 .memberNo(rs.getInt("member_no")) 
										 .member_name(rs.getString("member_name"))
										 .fileName(files)
										 .build();
				close(rs2);
				list.add(pb);
				pstmt.clearParameters();
			}
			
			
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(rs);
			close(pstmt);
		}
		return list;
	}
 
	
	public ProductBoard searchProduct(Connection conn,int productNo) {
		PreparedStatement pstmt=null;
		ResultSet rs=null;
		List<AttachedFiles> list=new ArrayList();
		ProductBoard pb=null; 
		AttachedFiles file=null;
		String sql=prop.getProperty("searchProduct");
		
		try {
			pstmt=conn.prepareStatement(sql);
			pstmt.setInt(1, productNo);
			rs=pstmt.executeQuery();
			while(rs.next()) {
				file=AttachedFiles.builder().fileName(rs.getString("filename")).build();
				list.add(file);
				pb=ProductBoard.builder().productNo(rs.getInt("pd_no"))
						 .title(rs.getString("pd_title"))
						 .category(rs.getString("pd_category"))
						 .content(rs.getString("pd_content"))
						 .price(rs.getInt("pd_price"))
						 .address(rs.getString("pd_address"))
						 .enrollDate(rs.getDate("pd_enrolldate"))
						 .isSale(rs.getString("pd_sale"))
						 .isDelete(rs.getString("pd_delete"))
						 .memberNo(rs.getInt("member_no"))  
						 .member_name(rs.getString("member_name")) 
						 .fileName(list)
						 .build();  
			}
			 
			//System.out.println(pb);
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
			close(rs);
		}
		
		return pb;
		
	}
	
 
	
	
	 
	


		public int insertBoard(Connection conn,ProductBoard pb) {
			PreparedStatement pstmt=null; 
			int result=0;  
			String sql=prop.getProperty("insertBoard");
			
			try {
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, pb.getTitle());
				pstmt.setString(2, pb.getCategory());
				pstmt.setString(3, pb.getContent());
				pstmt.setInt(4, pb.getPrice());
				pstmt.setString(5, pb.getAddress());  
				pstmt.setInt(6, pb.getMemberNo());  
				result = pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				close(pstmt);
			}
			return result;
		}
	
	
	 
	
		
		public int insertFile(Connection conn,ProductBoard pb,int pdno,String filename) {
			PreparedStatement pstmt=null; 
			int result=0;  
			String sql=prop.getProperty("insertFile");
			try {
				pstmt=conn.prepareStatement(sql); 
				pstmt.setInt(1, pdno);
				pstmt.setInt(2, pb.getMemberNo());
				pstmt.setString(3, filename);
				result=pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				close(pstmt);
			}
			return result;
			
			
		}
	
		
	 
		
		public int maxCount(Connection conn) {
			PreparedStatement pstmt=null; 
			ResultSet rs=null;
			int result=0;  
			String sql=prop.getProperty("sequence");
			try {
				pstmt=conn.prepareStatement(sql);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					result=rs.getInt(1);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				close(rs);
				close(pstmt);
			}
			return result;
		}
		
		public List<ProductBoard> storeMain(Connection conn,String memberNo){
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			ProductBoard pb=null;
			//AttachedFiles file=null;
			List<ProductBoard> list = new ArrayList();
			//List<AttachedFiles> files = new ArrayList();
			String sql=prop.getProperty("storeMember");
			String sql2=prop.getProperty("allAttachedfiles");
			
			try { 
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, memberNo);
				rs=pstmt.executeQuery();
				
				pstmt.clearParameters();
				
				while(rs.next()) {
					pstmt=conn.prepareStatement(sql2);
					int productNo=rs.getInt("pd_no");
					
					pstmt.setInt(1,productNo);
					ResultSet rs2=pstmt.executeQuery();
					List<AttachedFiles> files = new ArrayList();
					while(rs2.next()) {
						AttachedFiles file=AttachedFiles.builder().fileName(rs2.getString("filename")).build();
						files.add(file);
						
					} 
					pb=ProductBoard.builder().productNo(rs.getInt("pd_no"))
											 .title(rs.getString("pd_title"))
											 .category(rs.getString("pd_category"))
											 .content(rs.getString("pd_content"))
											 .price(rs.getInt("pd_price"))
											 .address(rs.getString("pd_address"))
											 .enrollDate(rs.getDate("pd_enrolldate"))
											 .isSale(rs.getString("pd_sale"))
											 .isDelete(rs.getString("pd_delete"))
											 .memberNo(rs.getInt("member_no")) 
											 .member_name(rs.getString("member_name"))
											 .fileName(files)
											 .build();
					close(rs2);
					list.add(pb);
					pstmt.clearParameters();
				}
				//System.out.println(list);
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				close(rs);
				close(pstmt);
			}
			return list;
			
			
		}
		
		
		public int updateBoard(Connection conn,ProductBoard pb) {
			PreparedStatement pstmt=null; 
			int result=0;  
			String sql=prop.getProperty("updateBoard");
			
			try {
				pstmt=conn.prepareStatement(sql);  
				pstmt.setString(1, pb.getTitle() );
				pstmt.setString(2, pb.getCategory());
				pstmt.setString(3, pb.getContent());
				pstmt.setInt(4, pb.getPrice());
				pstmt.setString(5, pb.getAddress());  
				pstmt.setInt(6, pb.getProductNo());  
				result = pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				close(pstmt);
			}
			return result;
			
			
		}
		
		public int deleteFile(Connection conn,int productNo) {
			PreparedStatement pstmt=null; 
			int result=0;  
			String sql=prop.getProperty("deleteFile");
			
			try {
				pstmt=conn.prepareStatement(sql);  
				pstmt.setInt(1,productNo);  
				result=pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				close(pstmt);
			}
			return result;
			
			
		}
		
		
		public int deleteBuyList(Connection conn,int productNo) {
			PreparedStatement pstmt=null; 
			int result=0;  
			String sql=prop.getProperty("deleteBuyList");
			
			try {
				pstmt=conn.prepareStatement(sql);  
				pstmt.setInt(1,productNo);  
				result=pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				close(pstmt);
			}
			return result;
			
			
		}
		
		public int updateFile(Connection conn,ProductBoard pb) {
			PreparedStatement pstmt=null; 
			int result=0;  
			String sql=prop.getProperty("updateFile");
			
			try {
				pstmt=conn.prepareStatement(sql);  
				pstmt.setString(1, pb.getTitle() );
				pstmt.setString(2, pb.getCategory());
				pstmt.setString(3, pb.getContent());
				pstmt.setInt(4, pb.getPrice());
				pstmt.setString(5, pb.getAddress());  
				pstmt.setInt(6, pb.getProductNo());  
				result = pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				close(pstmt);
			}
			return result;
			
			
		}
		
		
		public int deleteProduct(Connection conn,int productNo) {
			PreparedStatement pstmt=null; 
			int result=0;  
			String sql=prop.getProperty("deleteProduct");
			
			try {
				pstmt=conn.prepareStatement(sql);  
				pstmt.setInt(1, productNo);  
				result = pstmt.executeUpdate(); 
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				close(pstmt);
			}
			return result;
		}
		
		public int dealProduct(Connection conn,int productNo) {
			PreparedStatement pstmt=null;  
			int result=0;  
			String sql=prop.getProperty("dealProduct");
			
			try {
				pstmt=conn.prepareStatement(sql);  
				pstmt.setInt(1,productNo);   
				result = pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}finally { 
				close(pstmt);
			}
			return result;
		}
		
		public int buyProduct(Connection conn,String productNo,String memberNo) {
			PreparedStatement pstmt=null;  
			int result=0;  
			String sql=prop.getProperty("buyProduct");
			
			try {
				pstmt=conn.prepareStatement(sql);  
				pstmt.setString(1,productNo);   
				pstmt.setString(2,memberNo);   
				result = pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}finally { 
				close(pstmt);
			}
			return result;
		}
		
		public int updateBuyBoard(Connection conn,String productNo) {
			PreparedStatement pstmt=null;  
			int result=0;  
			String sql=prop.getProperty("updateBuyProduct");
			
			try {
				pstmt=conn.prepareStatement(sql);  
				pstmt.setString(1,productNo);    
				result = pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}finally { 
				close(pstmt);
			}
			return result;
			 
		}
		
		public List<ProductBoard> buyList(Connection conn,String memberNo) {
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			ProductBoard pb=null; 
			List<ProductBoard> list = new ArrayList(); 
			String sql=prop.getProperty("buyList");
			String sql2=prop.getProperty("allAttachedfiles");
			
			try { 
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, memberNo);
				rs=pstmt.executeQuery();
				
				pstmt.clearParameters();
				
				while(rs.next()) {
					pstmt=conn.prepareStatement(sql2);
					int productNo=rs.getInt("pd_no");
					
					pstmt.setInt(1,productNo);
					ResultSet rs2=pstmt.executeQuery();
					List<AttachedFiles> files = new ArrayList();
					while(rs2.next()) {
						AttachedFiles file=AttachedFiles.builder().fileName(rs2.getString("filename")).build();
						files.add(file);
						
					} 
					pb=ProductBoard.builder().productNo(rs.getInt("pd_no"))
											 .title(rs.getString("pd_title"))
											 .category(rs.getString("pd_category"))
											 .content(rs.getString("pd_content"))
											 .price(rs.getInt("pd_price"))
											 .address(rs.getString("pd_address"))
											 .enrollDate(rs.getDate("pd_enrolldate"))
											 .isSale(rs.getString("pd_sale"))
											 .isDelete(rs.getString("pd_delete"))
											 .memberNo(rs.getInt("member_no")) 
											 //.member_name(rs.getString("member_name"))
											 .fileName(files)
											 .build();
					close(rs2);
					list.add(pb);
					pstmt.clearParameters();
				}
				//System.out.println(list);
				
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				close(rs);
				close(pstmt);
			}
			return list;
		}
		
		
		public int insertComment(Connection conn,Comment c) {
			PreparedStatement pstmt=null;  
			int result=0;  
			String sql=prop.getProperty("insertComments");
			
			try {
				pstmt=conn.prepareStatement(sql);  
				pstmt.setString(1,c.getProductTitle());   
				pstmt.setString(2,c.getCommentContent());    
				pstmt.setInt(3,c.getProductNo());   
				pstmt.setInt(4,c.getMemberNo());   
				pstmt.setString(5,c.getCommentWriter());   
				result = pstmt.executeUpdate();
			}catch(Exception e) {
				e.printStackTrace();
			}finally { 
				close(pstmt);
			}
			return result;
		}
		
		public List<Comment> commentAll(Connection conn,String memberNo){
			PreparedStatement pstmt=null;
			ResultSet rs=null;
			List<Comment> list=new ArrayList();
			String sql=prop.getProperty("commentAll");
			Comment c=null;
			try {
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, memberNo);
				rs=pstmt.executeQuery();
				
				while(rs.next()) {
					c=Comment.builder().productTitle(rs.getString("BOARD_TILTE"))
									    .commentContent(rs.getString("comment_content"))
									   .enrollData(rs.getDate("comment_enrolldate"))
									   .productNo(rs.getInt("pd_no"))
									   .memberNo(rs.getInt("member_no"))
									   .CommentWriter(rs.getString("writer"))
									   .build();
					list.add(c);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally { 
				close(rs);
				close(pstmt);
			}
			return list;
			 
		}
		
		
		
		
		public Member searchMember(Connection conn,String memberNo) {
			PreparedStatement pstmt=null;
			ResultSet rs=null; 
			Member m=null;
			String sql=prop.getProperty("searchMember");
			try {
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, memberNo);
				rs=pstmt.executeQuery();
				
				while(rs.next()) {
					m=Member.builder().memberNo(rs.getInt("member_no"))
									  .memberName(rs.getString("member_name"))
									  .enrollDate(rs.getDate("enrolldate"))
									  .build();
					 
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally { 
				close(rs);
				close(pstmt);
			}
			return m;
		}
	 
		
		public int totalProduct(Connection conn,String memberNo){
			PreparedStatement pstmt=null; 
			ResultSet rs=null;
			int result=0;  
			String sql=prop.getProperty("totalProduct");
			try {
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, memberNo);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					result=rs.getInt(1);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				close(rs);
				close(pstmt);
			}
			return result;
		}
		
		 

		public int dealProduct(Connection conn,String memberNo){
			PreparedStatement pstmt=null; 
			ResultSet rs=null;
			int result=0;  
			String sql=prop.getProperty("dealProduct");
			try {
				pstmt=conn.prepareStatement(sql);
				pstmt.setString(1, memberNo);
				rs=pstmt.executeQuery();
				if(rs.next()) {
					result=rs.getInt(1);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}finally {
				close(rs);
				close(pstmt);
			}
			return result;
		}
}