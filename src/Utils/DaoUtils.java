package Utils;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;


public class DaoUtils
{
	/**
	 * 查询用户
	 * @param user
	 * @return
	 */
	public User selectUser(User user)
	{
		User resUser = null;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet res = null;
		try 
		{
			conn = JdbcUtils.getConnection();
			ps = conn.prepareStatement("select * from user where uid = ? and upassword = md5(?)");
			ps.setString(1, user.getUid());
			ps.setString(2, user.getUpassword());
			res = ps.executeQuery();
			if(res.next())
			{
				String id =res.getString("uid");
				String name =res.getString("uname");
				String auth =res.getString("uauth");
				resUser = new User(id, null, name, auth);
			}
		} catch (Exception e) 
		{
			e.printStackTrace();
		}finally 
		{
			JdbcUtils.free(res, ps, conn);
		}
			
		return resUser;
	}
	
	public int insertUser(User user)
	{
		int resCode = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		try 
		{
			conn = JdbcUtils.getConnection();
			/**如果存在先删除*/
			ps = conn.prepareStatement("delete from user where uid=?");
			ps.setString(1, user.getUid());
			ps.executeUpdate();
			ps.close();
			
			ps = conn.prepareStatement("insert into user values(?, md5(?), ?, ?)");
			ps.setString(1, user.getUid());
			ps.setString(2, user.getUpassword());
			ps.setString(3, user.getName());
			ps.setString(4, user.getUauth());
			resCode = ps.executeUpdate();
		
		} catch (Exception e) 
		{
			e.printStackTrace();
		}finally 
		{
			JdbcUtils.free(null, ps, conn);
		}
			
		return resCode;
	}
	
	/**
	 * 插入比赛信息
	 * @param match
	 * @return
	 */
	public int insertMatchType(MatchType match)
	{
		int resCode = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet res = null;
		try 
		{
			conn = JdbcUtils.getConnection();
			ps = conn.prepareStatement("insert into matchtype values(?,?,?,?,?)");
			ps.setString(1, match.getMatchname());
			ps.setTimestamp(2, new Timestamp(match.getEnrolltime().getTime()));
			ps.setTimestamp(3, new Timestamp(match.getUploadtime().getTime()));
			ps.setTimestamp(4, new Timestamp(match.getIssuetime().getTime()));
			ps.setString(5, match.getInfo());
			resCode = ps.executeUpdate();
			
		} catch (Exception e) 
		{
			e.printStackTrace();
		}finally 
		{
			JdbcUtils.free(res, ps, conn);
		}
		return resCode;
	}
	
	/**
	 * 查询全部报名表
	 * @param match
	 * @return
	 */
	public ArrayList<EnrollTable> selectAllEnrollTable(MatchType match)
	{
		ArrayList<EnrollTable> resEnroll = new ArrayList<EnrollTable>();
		Connection conn = null;
		PreparedStatement sp = null;
		ResultSet res = null;
		try 
		{
			conn = JdbcUtils.getConnection();
			sp = conn.prepareStatement("select * from (select * from enroll where matchname=?) as A left join (select * from uploadwork where matchname=?) as B  on A.uid = B.uid");
			sp.setString(1, match.getMatchname());
			sp.setString(2, match.getMatchname());
			res = sp.executeQuery();
			while(res.next())
			{
				String uid = res.getString(1);
				String matchname = res.getString(2);
				Date uploadtime = new Date(res.getTimestamp(3).getTime());
				String projectname = res.getString(4);
				String teamname = res.getString(5);
				String teachername = res.getString(6);
				String name1 = res.getString(7);
				String number1 = res.getString(8);
				String grade1 = res.getString(9);
				String qq1 = res.getString(10);
				String wechat1 =res.getString(11);
				String phone1 = res.getString(12);
				String name2 = res.getString(13);
				String number2 = res.getString(14);
				String grade2 = res.getString(15);
				String qq2 = res.getString(16);
				String wechat2 = res.getString(17);
				String phone2 = res.getString(18);
				String name3 = res.getString(19);
				String number3 = res.getString(20);
				String grade3 = res.getString(21);
				String qq3 = res.getString(22);
				String wechat3 = res.getString(23);
				String phone3 = res.getString(24);
				String dropboxurl = res.getString(28);
				String boxpassword = res.getString(29);
				resEnroll.add(new EnrollTable(uid, matchname, uploadtime, projectname, teamname, teachername, name1, number1, grade1, qq1, wechat1, phone1, name2, number2, grade2, qq2, wechat2, phone2, name3, number3, grade3, qq3, wechat3, phone3, dropboxurl, boxpassword));
			}
				
		} catch (Exception e) 
		{
			e.printStackTrace();
		}finally 
		{
			JdbcUtils.free(res, sp, conn);
		}
		return resEnroll;
	}
	
	/**
	 * 查询比赛信息
	 * @return
	 */
	public ArrayList<MatchType> selectMatchType()
	{
		ArrayList<MatchType> resMatchTypes = new ArrayList<MatchType>();
		Connection conn = null;
		Statement st = null;
		ResultSet res = null;
		try 
		{
			conn = JdbcUtils.getConnection();
			st = conn.createStatement();
			res = st.executeQuery("select * from matchtype order by issuetime desc");
			while(res.next())
			{
				Date enrolltime = new Date(res.getTimestamp("enrolltime").getTime());
				Date uploadtime = new Date(res.getTimestamp("uploadtime").getTime());
				Date issuetime = new Date(res.getTimestamp("issuetime").getTime());
				String matchname = res.getString("matchname");
				String info = (res.getString("info") == null ? "" : res.getString("info"));
				resMatchTypes.add(new MatchType(enrolltime, uploadtime, issuetime, matchname, info));
			}
		} catch (Exception e) 
		{
			e.printStackTrace();
		}finally 
		{
			JdbcUtils.free(res, st, conn);
		}
		return resMatchTypes;
	}
	
	/**
	 * 修改比赛信息
	 * @param match
	 * @return
	 */
	public int alterMatchType(MatchType match)
	{
		int resCode = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet res = null;
		try 
		{
			conn = JdbcUtils.getConnection();
			ps = conn.prepareStatement("update matchtype set enrolltime=?, uploadtime=?, info=? where matchname=?");
			ps.setTimestamp(1, new Timestamp(match.getEnrolltime().getTime()));
			ps.setTimestamp(2, new Timestamp(match.getUploadtime().getTime()));
			ps.setString(3, match.getInfo());
			ps.setString(4, match.getMatchname());
			resCode = ps.executeUpdate();
			
		} catch (Exception e) 
		{
			e.printStackTrace();
		}finally 
		{
			JdbcUtils.free(res, ps, conn);
		}
		return resCode;
	}
	
	/**
	 * 插入表明表
	 * @param enroll
	 * @return
	 */
	public int insertEnrollTable(EnrollTable enroll)
	{
		Connection conn = null;
		PreparedStatement sp = null;
		ResultSet res = null;
		int resCode = 0;
		try 
		{
			conn = JdbcUtils.getConnection();
			sp = conn.prepareStatement("insert into enroll values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)");
			sp.setString(1, enroll.getUid());
			sp.setString(2, enroll.getMatchname());
			sp.setTimestamp(3, new Timestamp(enroll.getUploadtime().getTime()));
			sp.setString(4, enroll.getProjectname());
			sp.setString(5, enroll.getTeamname());
			sp.setString(6, enroll.getTeachername());
			sp.setString(7, enroll.getName1());
			sp.setString(8, enroll.getNumber1());
			sp.setString(9, enroll.getGrade1());
			sp.setString(10, enroll.getQq1());
			sp.setString(11, enroll.getWechat1());
			sp.setString(12, enroll.getPhone1());
			sp.setString(13, enroll.getName2());
			sp.setString(14, enroll.getNumber2());
			sp.setString(15, enroll.getGrade2());
			sp.setString(16, enroll.getQq2());
			sp.setString(17, enroll.getWechat2());
			sp.setString(18, enroll.getPhone2());
			sp.setString(19, enroll.getName3());
			sp.setString(20, enroll.getNumber3());
			sp.setString(21, enroll.getGrade3());
			sp.setString(22, enroll.getQq3());
			sp.setString(23, enroll.getWechat3());
			sp.setString(24, enroll.getPhone3());
			resCode = sp.executeUpdate();		
		} catch (Exception e) 
		{
			e.printStackTrace();
		}finally 
		{
			JdbcUtils.free(res, sp, conn);
		}
		return resCode;
	}
	
	/**
	 *查询报名表
	 * @param user
	 * @param match
	 * @return
	 */
	public EnrollTable selectEnrollTable(User user, MatchType match)
	{
		EnrollTable resEnroll = null;
		Connection conn = null;
		PreparedStatement sp = null;
		ResultSet res = null;
		try 
		{
			conn = JdbcUtils.getConnection();
			sp = conn.prepareStatement("select * from enroll where uid=? and matchname=?");
			sp.setString(1, user.getUid());
			sp.setString(2, match.getMatchname());
			res = sp.executeQuery();
			if(res.next())
			{
				String uid = res.getString(1);
				String matchname = res.getString(2);
				Date uploadtime = new Date(res.getTimestamp(3).getTime());
				String projectname = res.getString(4);
				String teamname = res.getString(5);
				String teachername = res.getString(6);
				String name1 = res.getString(7);
				String number1 = res.getString(8);
				String grade1 = res.getString(9);
				String qq1 = res.getString(10);
				String wechat1 =res.getString(11);
				String phone1 = res.getString(12);
				String name2 = res.getString(13);
				String number2 = res.getString(14);
				String grade2 = res.getString(15);
				String qq2 = res.getString(16);
				String wechat2 = res.getString(17);
				String phone2 = res.getString(18);
				String name3 = res.getString(19);
				String number3 = res.getString(20);
				String grade3 = res.getString(21);
				String qq3 = res.getString(22);
				String wechat3 = res.getString(23);
				String phone3 = res.getString(24);
				resEnroll = new EnrollTable(uid, matchname, uploadtime, projectname, teamname, teachername, name1, number1, grade1, qq1, wechat1, phone1, name2, number2, grade2, qq2, wechat2, phone2, name3, number3, grade3, qq3, wechat3, phone3,null,null);
			}
				
		} catch (Exception e) 
		{
			e.printStackTrace();
		}finally 
		{
			JdbcUtils.free(res, sp, conn);
		}
		return resEnroll;
	}
	
	/**
	 * 查询全字段报名表
	 * @param match
	 * @return
	 */
	public ArrayList<Personallist> selectPersonal(MatchType match)
	{
		ArrayList<Personallist> reslist = new ArrayList<Personallist>();
		Connection conn = null;
		PreparedStatement sp = null;
		ResultSet res = null;
		try 
		{
			conn = JdbcUtils.getConnection();
			sp = conn.prepareStatement("select A.uid, name1, A.uploadtime as enrolltime,B.uploadtime as worktime from (select uid, name1,uploadtime from enroll where matchname=?) as A left join (select uid, uploadtime from uploadwork where matchname=?) as B  on A.uid = B.uid");
			sp.setString(1, match.getMatchname());
			sp.setString(2, match.getMatchname());
			res = sp.executeQuery();
			while(res.next())
			{
				String uid = res.getString(1);
				String name = res.getString(2);
				Date enrolltime = res.getTimestamp(3) != null ? (new Date(res.getTimestamp(3).getTime())) : null;
				Date uploadtime = res.getTimestamp(4) != null ? (new Date(res.getTimestamp(4).getTime())) : null;
				reslist.add(new Personallist(uid, name, enrolltime, uploadtime));
			}
				
		} catch (Exception e) 
		{
			e.printStackTrace();
		}finally 
		{
			JdbcUtils.free(res, sp, conn);
		}
		return reslist;
	}
	
	/**
	 * 删除报名表
	 * @param user
	 * @param match
	 * @return
	 */
	public int deleteEnrollTable(User user, MatchType match)
	{
		int resCode = 0;  
		Connection conn = null;
		PreparedStatement sp = null;
		ResultSet res = null;
		try 
		{
			conn = JdbcUtils.getConnection();
			sp = conn.prepareStatement("delete from enroll where uid=? and matchname=?");
			sp.setString(1, user.getUid());
			sp.setString(2, match.getMatchname());
			resCode = sp.executeUpdate();
				
		} catch (Exception e) 
		{
			e.printStackTrace();
		}finally 
		{
			JdbcUtils.free(res, sp, conn);
		}
		return resCode;
	}
	
	public int insertUploadWork(UploadWork work)
	{
		int resCode = 0;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet res = null;
		try 
		{
			conn = JdbcUtils.getConnection();
			ps = conn.prepareStatement("insert into uploadwork values(?,?,?,?,?)");
			ps.setString(1, work.getUid());
			ps.setString(2, work.getMatchname());
			ps.setTimestamp(3, new Timestamp(work.getUploadtime().getTime()));
			ps.setString(4, work.getDropboxurl());
			ps.setString(5, work.getBoxpassword());
			resCode = ps.executeUpdate();
		} catch (Exception e) 
		{
			e.printStackTrace();
		}finally 
		{
			JdbcUtils.free(res, ps, conn);
		}
		return resCode;
	}
	
	public UploadWork selectUploadWork(User user, MatchType match)
	{
		UploadWork reswork = null;
		Connection conn = null;
		PreparedStatement ps = null;
		ResultSet res = null;
		try 
		{
			conn = JdbcUtils.getConnection();
			ps = conn.prepareStatement("select * from uploadwork where uid=? and matchname=?");
			ps.setString(1, user.getUid());
			ps.setString(2, match.getMatchname());
			res = ps.executeQuery();
			if(res.next())
			{
				String uid = res.getString("uid");
				String matchname = res.getString("matchname");   
				Date uploadtime = new Date(res.getTimestamp("uploadtime").getTime());
				String dropboxurl = res.getString("dropboxurl");
				String boxpassword = res.getString("boxpassword");
				reswork = new UploadWork(uid, matchname, uploadtime, dropboxurl, boxpassword); 
			}
		} catch (Exception e) 
		{
			e.printStackTrace();
		}finally 
		{
			JdbcUtils.free(res, ps, conn);
		}
		return reswork;
	}
	
	public int deleteUploadWork(User user, MatchType match)
	{
		int resCode = 0;  
		Connection conn = null;
		PreparedStatement sp = null;
		ResultSet res = null;
		try 
		{
			conn = JdbcUtils.getConnection();
			sp = conn.prepareStatement("delete from uploadwork where uid=? and matchname=?");
			sp.setString(1, user.getUid());
			sp.setString(2, match.getMatchname());
			resCode = sp.executeUpdate();
				
		} catch (Exception e) 
		{
			e.printStackTrace();
		}finally 
		{
			JdbcUtils.free(res, sp, conn);
		}
		return resCode;
	}
	
}


