package Utils;

import java.io.FileReader;
import java.io.IOException;
import java.io.Reader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Properties;

/**
 * 2018��2��20��14:01:17
 * @author 14746
 * @version 1.0
 */

public class JdbcUtils 
{
	/**���ݿ��ַ*/
	private final static String address;
	/**���ݿ��û���*/
	private final static String userName;
	/**���ݿ�����*/
	private final static String password;
	/**jdbc���ӳ�ʼ��*/
	static 
	{
		Reader fr = null;
		
		try 
		{
			//ע������
			Class.forName("com.mysql.jdbc.Driver");	
			String path = JdbcUtils.class.getResource("/").getPath();
			path = path.substring(1, path.indexOf("classes"));
			//��ȡ�����ļ�
			fr = new FileReader(path + "jdbc.properties");
			Properties pro = new Properties();
			pro.load(fr);
			address = pro.getProperty("address");
			userName = pro.getProperty("userName");
			password = pro.getProperty("password");
		} catch (ClassNotFoundException | IOException e) 
		{
			throw new ExceptionInInitializerError(e);
		}finally 
		{
			if(fr != null)
				try 
				{
					fr.close();
				} catch (IOException e) 
				{
					throw new ExceptionInInitializerError(e);
				}
		}
			
	}
	
	private JdbcUtils() {}
	
	
	
	/**
	 * ��������
	 * @return ���ݿ�����
	 * @throws SQLException
	 */
	public static Connection getConnection() throws SQLException
	{
		return DriverManager.getConnection(address, userName, password);
	}
	
	/**
	 * �ر���Դ
	 * @param res
	 * @param st
	 * @param conn
	 */
	public static void free(ResultSet res, Statement st, Connection conn)
	{
		
		try 
		{
			if(res != null)
				res.close();
		} catch (SQLException e) 
		{
				e.printStackTrace();
		}
		finally 
		{
			
			try 
			{
				if(st != null)
					st.close();
			} catch (SQLException e)
			{
				e.printStackTrace();
			}
			finally 
			{		
				try 
				{
					if(conn != null)
						conn.close();
				} catch (SQLException e) 
				{
						e.printStackTrace();
				}
			}
		}
	}	
}

