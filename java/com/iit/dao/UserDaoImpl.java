package com.iit.dao;

import java.io.ByteArrayInputStream;
import java.sql.Blob;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.sql.DataSource;
import org.springframework.stereotype.Repository;
import com.iit.dao.UserDao;
import com.iit.domain.Blogs;
import com.iit.domain.Login;
import com.iit.domain.TopQuestions;
import com.iit.domain.UserDTO;
import com.iit.utilities.SendEmail;
import org.apache.log4j.Logger;

@Repository
public class UserDaoImpl implements UserDao
{
    final static Logger logger = Logger.getLogger(UserDaoImpl.class);
    
    List<Object[]> loginList = null;
    List<Object[]> topQuestionsList = null;
    List<TopQuestions> topQuestions = null;
    List<Blogs> blogsList = null;
    Blogs blogs = null;
    TopQuestions topQuestionsObject = null;
    String loginStatus = "";
    String firstAndLastName = "";
    SendEmail sendEmail = new SendEmail();
    boolean addUserStatus = true;
    boolean addFBUserStatus = true;
    boolean addQuestionStatus = true;
    boolean addBlogStatus = true;
    boolean addAnswerStatus = true;
    boolean addCommentStatus = true;
    boolean updateUserStatus = true;
    private DataSource dataSource;
    Connection connection = null;
    PreparedStatement preparedStatement = null;
    String sqlUserProfile = "";
    String sqlFBClause = "";
    String sqlUserLogin = "";
    String sqlUserDetails = "";
    String questionQuery = "";
    String answerQuery = "";
    String answerQuestionsQuery = "";
    String answerUsersQuery = "";
    String questionsUsersQuery = "";
    String username = "";
    String password = "";
    String question_name = "";
    String answer_name = "";
    ResultSet resultSet = null;
    int userDetailsId = 0;
    int questionsId = 0;
    int answersId = 0;
    int userProfileId = 0;
    UserDTO userDTO = null;
    boolean imageFlag = false;
    
    public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}
    
    public boolean updateUser(UserDTO userDTO, Long imageSize) {
    	
   	 ByteArrayInputStream inputStream = new ByteArrayInputStream(userDTO.getProfilePic());
   	
   	if(imageSize==0)
   	{
   		sqlUserProfile = "update tw_userprofile " +
			  "set fname = ?, lname = ?, email_id = ?, "+
			  "contact = ? "+
			  "where user_id = ?";
   	}
   	else
   	{
   		sqlUserProfile = "update tw_userprofile " +
  			  "set fname = ?, lname = ?, email_id = ?, "+
  			  "contact = ?, tw_profilepic = ?, tw_image_flag = ? "+
  			  "where user_id = ?";
   	}
   	 
   		try {
   			connection = dataSource.getConnection();
   			
   			connection.setAutoCommit(false);
   			
   			preparedStatement = connection.prepareStatement(sqlUserProfile);
   			preparedStatement.setString(1, userDTO.getFname());
   			preparedStatement.setString(2, userDTO.getLname());
   			preparedStatement.setString(3, userDTO.getEmailId());
   			preparedStatement.setLong(4, userDTO.getContact());
   			if(imageSize==0)
   			{
   				preparedStatement.setInt(5, userDTO.getUserId());
   			}
   			else
   			{
   				preparedStatement.setBlob(5,  inputStream);
   				preparedStatement.setString(6,  "Y");
   				preparedStatement.setInt(7, userDTO.getUserId());
   			}
   			preparedStatement.executeUpdate();
   			preparedStatement.close();
   			
   			preparedStatement = connection.prepareStatement("select tw_userdetails_id from tw_userprofile where user_id = ?");
   			preparedStatement.setInt(1, userDTO.getUserId());
   			resultSet = preparedStatement.executeQuery();
   			 while (resultSet.next())
   			 {
   			    System.out.println("results: " + resultSet.getInt(1));
   			    userDetailsId = resultSet.getInt(1);
   			 }
   			 resultSet.close();
   			 preparedStatement.close();
   			 
   			sqlUserDetails = "update tw_userdetails "+
					"set profession_name = ?, company_name = ?, education_name = ? "+
					"where userdetails_id = ?";
   			
   			preparedStatement = connection.prepareStatement(sqlUserDetails);
			preparedStatement.setString(1, userDTO.getProfessionName());
			preparedStatement.setString(2, userDTO.getCompanyName());
			preparedStatement.setString(3, userDTO.getEducationName());
			preparedStatement.setInt(4, userDetailsId);
			preparedStatement.executeUpdate();
			preparedStatement.close();
   			
   			connection.commit();
   			
   			updateUserStatus = true;
   			
   			if(updateUserStatus)
   				sendEmail.sendConfirmationMail(userDTO, "update");
       		
   		}
   	catch(Exception e)
   	{
   		addUserStatus = false;
   		System.out.println("An exception occured while trying to update profile details and sending an email"+e);
   	}
   		finally {
    		
			if (preparedStatement != null) {
				try {
					preparedStatement.close();
					
				} catch (SQLException e) {}
			}
			
				if (resultSet != null) {
					try {
						resultSet.close();
						
					} catch (SQLException e) {}
				}
				
				if (connection != null) {
					try {
						connection.close();
						
					} catch (SQLException e) {}
				}
				
			}
   	return addUserStatus;
   }
    
    public String updatePassword(UserDTO userDTO) {
    	
      		sqlUserProfile = "update tw_login " +
     			  "set fname = ?, lname = ?, email_id = ?, "+
     			  "contact = ?, tw_profilepic = ?, tw_image_flag = ? "+
     			  "where user_id = ?";
      		
      		String password = "";
      		boolean passwordFlag = false;
      		boolean updatePasswordStatus = false;
      		String status = "";
      	 
      		try {
      			
      			connection = dataSource.getConnection();
      			connection.setAutoCommit(false);
      			
      			preparedStatement = connection.prepareStatement("select login.password as password "+
																"from tw_login login, tw_userprofile up "+
																"where login.user_id = up.user_id "+
																"and login.user_id = ?");
      			preparedStatement.setInt(1, userDTO.getUserIdResetPasswordValue());
      			resultSet = preparedStatement.executeQuery();
      			 while (resultSet.next())
      			 {
      				 password = resultSet.getString(1);
      				 if(userDTO.getPassword().equals(password))
      					 passwordFlag = true;
      			 }
      			 resultSet.close();
      			 preparedStatement.close();
      			
      			 if(passwordFlag)
      			 {
		      			preparedStatement = connection.prepareStatement("update tw_login set password = ? where user_id = ?");
		      			preparedStatement.setString(1, userDTO.getNewPassword());
		      			preparedStatement.setInt(2, userDTO.getUserIdResetPasswordValue());
		      			preparedStatement.executeUpdate();
		      			preparedStatement.close();
		      			status = "Your password has been updated successfully. An email has been sent to your registered email id for confirmation.";
		      			updatePasswordStatus = true;
      			 }
      			 else if(!passwordFlag)
      			 {
      				 status = "Please enter the correct old password.";
      			 }
      			
      			if(updatePasswordStatus)
      				sendEmail.sendConfirmationMail(userDTO, "updatePassword");
      			
      			connection.commit();
          		
      		}
      	catch(Exception e)
      	{
      		status = "An error occured while trying to update your password. Please try again.";
      		System.out.println("An exception occured while trying to update the password and sending an email"+e);
      	}
      		finally {
       		
   			if (preparedStatement != null) {
   				try {
   					preparedStatement.close();
   					
   				} catch (SQLException e) {}
   			}
   			
   				if (resultSet != null) {
   					try {
   						resultSet.close();
   						
   					} catch (SQLException e) {}
   				}
   				
   				if (connection != null) {
   					try {
   						connection.close();
   						
   					} catch (SQLException e) {}
   				}
   				
   			}
      	return status;
      }
    
    public boolean saveQuestion(TopQuestions topQuestions) {
    	
    	java.sql.Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
    	
   	    questionQuery = "INSERT INTO TW_QUESTIONS " +
				"(question_name, tw_question_time, number_of_views) VALUES (?, ?, ?)";
   	
   	 questionsUsersQuery = "INSERT INTO TW_USERS_QUESTIONS " +
				"(tw_question_id, tw_user_id) VALUES (?, ?)";
   		
   		try {
   			connection = dataSource.getConnection();
   			connection.setAutoCommit(false);
   			
   			preparedStatement = connection.prepareStatement(questionQuery);
   			preparedStatement.setString(1, topQuestions.getQuestionName().trim());
   			preparedStatement.setTimestamp(2, date);
   			preparedStatement.setInt(3, 1);
   			preparedStatement.executeUpdate();
   			preparedStatement.close();
   			
   			resultSet = connection.prepareStatement("select max(tw_questions_answers_id) from tw_questions").executeQuery();
   			 while (resultSet.next())
   			 {
   			    System.out.println("results: " + resultSet.getInt(1));
   			    questionsId = resultSet.getInt(1);
   			 }
   			 resultSet.close();
   			 preparedStatement.close();
   			
   			preparedStatement = connection.prepareStatement(questionsUsersQuery);
   			preparedStatement.setInt(1, questionsId);
   			preparedStatement.setInt(2, topQuestions.getUserIdQuestionValue());
   			preparedStatement.executeUpdate();
   			preparedStatement.close();
   			
   			connection.commit();
   			
   			addQuestionStatus = true;
   		}
   	catch(Exception e)
   	{
   		addQuestionStatus = false;
   		System.out.println("An exception occured while trying to save new question."+e);
   	}
   		finally {
    		
			if (preparedStatement != null) {
				try {
					preparedStatement.close();
					
				} catch (SQLException e) {}
			}
			
				if (resultSet != null) {
					try {
						resultSet.close();
						
					} catch (SQLException e) {}
				}
				
				if (connection != null) {
					try {
						connection.close();
						
					} catch (SQLException e) {}
				}
				
			}
   	return addQuestionStatus;
   }
    
 public boolean saveBlog(Blogs blogs) {
    	
    	java.sql.Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
    	
   		try {
   			connection = dataSource.getConnection();
   			connection.setAutoCommit(false);
   			
   			preparedStatement = connection.prepareStatement("INSERT INTO TW_BLOGS (tw_blog_topic, tw_blog_content, tw_blog_time, number_of_views) VALUES (?, ?, ?, ?)");
   			preparedStatement.setString(1, blogs.getBlogTopic().trim());
   			preparedStatement.setString(2, blogs.getBlogContent().trim());
   			preparedStatement.setTimestamp(3, date);
   			preparedStatement.setInt(4, 1);
   			preparedStatement.executeUpdate();
   			preparedStatement.close();
   			
   			resultSet = connection.prepareStatement("select max(tw_blog_id) from tw_blogs").executeQuery();
   			int blogId = 0;
   			 while (resultSet.next())
   			 {
   			    System.out.println("results: " + resultSet.getInt(1));
   			    blogId = resultSet.getInt(1);
   			 }
   			 resultSet.close();
   			 preparedStatement.close();
   			
   			preparedStatement = connection.prepareStatement("INSERT INTO TW_USERS_BLOGS (tw_blog_id, tw_user_id) VALUES (?, ?)");
   			preparedStatement.setInt(1, blogId);
   			preparedStatement.setInt(2, blogs.getUserIdBlogValue());
   			preparedStatement.executeUpdate();
   			preparedStatement.close();
   			
   			connection.commit();
   			
   			addBlogStatus = true;
   		}
   	catch(Exception e)
   	{
   		addBlogStatus = false;
   		System.out.println("An exception occured while trying to save a new blog."+e);
   	}
   		finally {
    		
			if (preparedStatement != null) {
				try {
					preparedStatement.close();
					
				} catch (SQLException e) {}
			}
			
				if (resultSet != null) {
					try {
						resultSet.close();
						
					} catch (SQLException e) {}
				}
				
				if (connection != null) {
					try {
						connection.close();
						
					} catch (SQLException e) {}
				}
				
			}
   	return addBlogStatus;
   }
    
public boolean saveAnswer(TopQuestions topQuestions) {
    	
    	java.sql.Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
    	
    	answerQuery = "INSERT INTO TW_ANSWERS " +
				"(tw_answer_name, tw_answer_time) VALUES (?, ?)";
   	
   	    answerQuestionsQuery = "INSERT INTO TW_QUESTIONS_ANSWERS " +
				"(tw_question_id, tw_answer_id) VALUES (?, ?)";
   	 
   	    answerUsersQuery = "INSERT INTO TW_USERS_ANSWERS " +
			"(tw_answer_id, tw_user_id) VALUES (?, ?)";
   		
   		try {
   			connection = dataSource.getConnection();
   			connection.setAutoCommit(false);
   			
   			//first query insert
   			preparedStatement = connection.prepareStatement(answerQuery);
   			preparedStatement.setString(1, topQuestions.getAnswer_name());
   			preparedStatement.setTimestamp(2, date);
   			preparedStatement.executeUpdate();
   			preparedStatement.close();
   			
   			preparedStatement = connection.prepareStatement("select tw_questions_answers_id from tw_questions where question_name = ?");
   			preparedStatement.setString(1, topQuestions.getQuestion_name());
   			
   			resultSet = preparedStatement.executeQuery();
   			int question = 0;
   			 while (resultSet.next())
   			 {
   			    System.out.println("results: " + resultSet.getInt(1));
   			 question = resultSet.getInt(1);
   			 }
   			 resultSet.close();
   			 preparedStatement.close();
   			 
   			 
   			resultSet = connection.prepareStatement("select max(tw_answer_id) from tw_answers").executeQuery();
  			 while (resultSet.next())
  			 {
  			    System.out.println("results: " + resultSet.getInt(1));
  			 answersId = resultSet.getInt(1);
  			 }
  			 resultSet.close();
  			 preparedStatement.close();
  			 
  			 //second query
   			preparedStatement = connection.prepareStatement(answerQuestionsQuery);
   			preparedStatement.setInt(1, question);
   			preparedStatement.setInt(2, answersId);
   			preparedStatement.executeUpdate();
   			preparedStatement.close();
   			
   			//third query
   			preparedStatement = connection.prepareStatement(answerUsersQuery);
   			preparedStatement.setInt(1, answersId);
   			preparedStatement.setInt(2, topQuestions.getUserId());
   			preparedStatement.executeUpdate();
   			preparedStatement.close();
   			
   			connection.commit();
   			
   			addAnswerStatus = true;
   		}
   	catch(Exception e)
   	{
   		addAnswerStatus = false;
   		System.out.println("An exception occured while trying to save a new answer."+e);
   	}
   		finally {
    		
			if (preparedStatement != null) {
				try {
					preparedStatement.close();
					
				} catch (SQLException e) {}
			}
			
				if (resultSet != null) {
					try {
						resultSet.close();
						
					} catch (SQLException e) {}
				}
				
				if (connection != null) {
					try {
						connection.close();
						
					} catch (SQLException e) {}
				}
				
			}
   	return addAnswerStatus;
   }

public boolean saveComment(Blogs blogs) {
	
	java.sql.Timestamp date = new java.sql.Timestamp(new java.util.Date().getTime());
	
		try {
			connection = dataSource.getConnection();
			connection.setAutoCommit(false);
			
			//first query insert
			preparedStatement = connection.prepareStatement("INSERT INTO TW_COMMENTS (tw_comment_desc, tw_comment_time) VALUES (?, ?)");
			preparedStatement.setString(1, blogs.getComment());
			preparedStatement.setTimestamp(2, date);
			preparedStatement.executeUpdate();
			preparedStatement.close();
			
			preparedStatement = connection.prepareStatement("select tw_blog_id from tw_blogs where tw_blog_topic = ?");
			preparedStatement.setString(1, blogs.getBlogTopic1());
			
			resultSet = preparedStatement.executeQuery();
			int blogId = 0;
			 while (resultSet.next())
			 {
			    System.out.println("results: " + resultSet.getInt(1));
			    blogId = resultSet.getInt(1);
			 }
			 resultSet.close();
			 preparedStatement.close();
			 
			 int commentId = 0;
			 resultSet = connection.prepareStatement("select max(tw_comment_id) from tw_comments").executeQuery();
			 while (resultSet.next())
			 {
			    System.out.println("results: " + resultSet.getInt(1));
			    commentId = resultSet.getInt(1);
			 }
			 resultSet.close();
			 preparedStatement.close();
			 
			 //second query
			preparedStatement = connection.prepareStatement("INSERT INTO TW_BLOGS_COMMENTS (tw_blog_id, tw_comment_id) VALUES (?, ?)");
			preparedStatement.setInt(1, blogId);
			preparedStatement.setInt(2, commentId);
			preparedStatement.executeUpdate();
			preparedStatement.close();
			
			//third query
			preparedStatement = connection.prepareStatement("INSERT INTO TW_USERS_COMMENTS (tw_comment_id, tw_user_id) VALUES (?, ?)");
			preparedStatement.setInt(1, commentId);
			preparedStatement.setInt(2, blogs.getUserId());
			preparedStatement.executeUpdate();
			preparedStatement.close();
			
			connection.commit();
			
			addCommentStatus = true;
		}
	catch(Exception e)
	{
		addCommentStatus = false;
		System.out.println("An exception occured while trying to save a new comment."+e);
	}
		finally {
    		
			if (preparedStatement != null) {
				try {
					preparedStatement.close();
					
				} catch (SQLException e) {}
			}
			
				if (resultSet != null) {
					try {
						resultSet.close();
						
					} catch (SQLException e) {}
				}
				
				if (connection != null) {
					try {
						connection.close();
						
					} catch (SQLException e) {}
				}
				
			}
	return addCommentStatus;
}
    
    public boolean addUser(UserDTO userDTO) {
    	
    	 ByteArrayInputStream inputStream = new ByteArrayInputStream(userDTO.getProfilePic());
    	
    	sqlUserDetails = "INSERT INTO TW_USERDETAILS " +
				"(profession_name, company_name, education_nam) VALUES (?, ?, ?)";
    	
    		sqlUserProfile = "INSERT INTO TW_USERPROFILE " +
				"(fname, lname, email_id, contact, tw_userdetails_id, tw_profilepic) VALUES (?, ?, ?, ?, ?, ?)";
    		
    		sqlUserLogin = "INSERT INTO TW_LOGIN " +
    				"(username, password, active_flg, user_id) VALUES (?, ?, ?, ?)";
    		
    		try {
    			connection = dataSource.getConnection();
    			connection.setAutoCommit(false);
    			
    			preparedStatement = connection.prepareStatement(sqlUserDetails);
    			preparedStatement.setString(1, userDTO.getProfessionName());
    			preparedStatement.setString(2, userDTO.getCompanyName());
    			preparedStatement.setString(3, userDTO.getEducationName());
    			preparedStatement.executeUpdate();
    			preparedStatement.close();
    			
    			resultSet = connection.prepareStatement("select max(userdetails_id) from tw_userdetails").executeQuery();
    			 while (resultSet.next())
    			 {
    			    System.out.println("results: " + resultSet.getInt(1));
    			    userDetailsId = resultSet.getInt(1);
    			 }
    			 resultSet.close();
    			 preparedStatement.close();
    			
    			preparedStatement = connection.prepareStatement(sqlUserProfile);
    			preparedStatement.setString(1, userDTO.getFname());
    			preparedStatement.setString(2, userDTO.getLname());
    			preparedStatement.setString(3, userDTO.getEmailId());
    			preparedStatement.setLong(4, userDTO.getContact());
    			preparedStatement.setLong(5, userDetailsId);
    			preparedStatement.setBlob(6,  inputStream);
    			preparedStatement.executeUpdate();
    			preparedStatement.close();
    			
    			resultSet = connection.prepareStatement("select max(user_id) from tw_userprofile").executeQuery();
    			 while (resultSet.next())
    			 {
    			    System.out.println("results: " + resultSet.getInt(1));
    			    userProfileId = resultSet.getInt(1);
    			 }
    			 resultSet.close();
    			 preparedStatement.close();
    			
    			preparedStatement = connection.prepareStatement(sqlUserLogin);
    			preparedStatement.setString(1, userDTO.getUsername());
    			preparedStatement.setString(2, userDTO.getPassword());
    			preparedStatement.setString(3, "Y");
    			preparedStatement.setLong(4, userProfileId);
    			preparedStatement.executeUpdate();
    			preparedStatement.close();
    			
    			connection.commit();
    			
    			addUserStatus = true;
    			
    			if(addUserStatus)
    				sendEmail.sendConfirmationMail(userDTO, "register");
        		
    		}
    	catch(Exception e)
    	{
    		addUserStatus = false;
    		System.out.println("An exception occured while trying to save new user details and sending an email"+e);
    	}
    		finally {
        		
    			if (preparedStatement != null) {
    				try {
    					preparedStatement.close();
    					
    				} catch (SQLException e) {}
    			}
    			
    				if (resultSet != null) {
    					try {
    						resultSet.close();
    						
    					} catch (SQLException e) {}
    				}
    				
    				if (connection != null) {
    					try {
    						connection.close();
    						
    					} catch (SQLException e) {}
    				}
    				
    			}
    	return addUserStatus;
    }
    
    public boolean addFBUser(UserDTO userDTO, Long imageSize) {
    	
    	ByteArrayInputStream inputStream = new ByteArrayInputStream(userDTO.getProfilePic());
       	
       	if(imageSize==0)
       	{
       		sqlUserProfile = "update tw_userprofile " +
    			  "set email_id = ?, "+
    			  "contact = ? "+
    			  "where user_id = ?";
       	}
       	else
       	{
       		sqlUserProfile = "update tw_userprofile " +
      			  "set email_id = ?, "+
      			  "contact = ?, tw_profilepic = ?, tw_image_flag = ? "+
      			  "where user_id = ?";
       	}
       	 
       		try {
       			connection = dataSource.getConnection();
       			
       			connection.setAutoCommit(false);
       			
       			preparedStatement = connection.prepareStatement(sqlUserProfile);
       			preparedStatement.setString(1, userDTO.getFbEmailId());
       			preparedStatement.setLong(2, userDTO.getFbContact());
       			if(imageSize==0)
       			{
       				preparedStatement.setInt(3, userDTO.getFbUserId());
       			}
       			else
       			{
       				preparedStatement.setBlob(3,  inputStream);
       				preparedStatement.setString(4,  "Y");
       				preparedStatement.setInt(5, userDTO.getFbUserId());
       			}
       			preparedStatement.executeUpdate();
       			preparedStatement.close();
       			
   			preparedStatement = connection.prepareStatement("select tw_userdetails_id from tw_userprofile where user_id = ?");
   			preparedStatement.setInt(1, userDTO.getFbUserId());
   			resultSet = preparedStatement.executeQuery();
   			 while (resultSet.next())
   			 {
   			    System.out.println("results: " + resultSet.getInt(1));
   			    userDetailsId = resultSet.getInt(1);
   			 }
   			 resultSet.close();
   			 preparedStatement.close();
   			
   			preparedStatement = connection.prepareStatement("update tw_userdetails "+
				"set profession_name = ?, company_name = ?, education_name = ? "+
				"where userdetails_id = ?");
   			preparedStatement.setString(1, userDTO.getProfessionName());
   			preparedStatement.setString(2, userDTO.getCompanyName());
   			preparedStatement.setString(3, userDTO.getEducationName());
   			preparedStatement.setInt(4, userDetailsId);
   			preparedStatement.executeUpdate();
   			preparedStatement.close();
   			
   			connection.commit();
   			
   			addFBUserStatus = true;
   			
   			if(addFBUserStatus)
   				sendEmail.sendConfirmationMail(userDTO, "fbRegister");
       		
   		}
   	catch(Exception e)
   	{
   		addFBUserStatus = false;
   		System.out.println("An exception occured while trying to add a new FB user and sending an email"+e);
   	}
   		finally {
       		
   			if (preparedStatement != null) {
   				try {
   					preparedStatement.close();
   					
   				} catch (SQLException e) {}
   			}
   			
   				if (resultSet != null) {
   					try {
   						resultSet.close();
   						
   					} catch (SQLException e) {}
   				}
   				
   				if (connection != null) {
   					try {
   						connection.close();
   						
   					} catch (SQLException e) {}
   				}
   				
   			}
   	return addFBUserStatus;
   }
    
public boolean saveFbUserName(String fname, String lname) {
    	
   		sqlUserProfile = "INSERT INTO TW_USERPROFILE " +
				"(fname, lname, tw_userdetails_id, tw_facebook_users_id) VALUES (?, ?, ?, ?)";
   		
   		String sqlDetailsProfile = "INSERT INTO TW_USERDETAILS " +
				"(profession_name, company_name, education_name) VALUES (?, ?, ?)";
   		
   		try {
   			connection = dataSource.getConnection();
   			connection.setAutoCommit(false);
   			
   			preparedStatement = connection.prepareStatement(sqlDetailsProfile);
   			preparedStatement.setString(1, "");
   			preparedStatement.setString(2, "");
   			preparedStatement.setString(3, "");
   			preparedStatement.executeUpdate();
   			preparedStatement.close();
   			
   			resultSet = connection.prepareStatement("select max(userdetails_id) from tw_userdetails").executeQuery();
  			 while (resultSet.next())
  			 {
  			    System.out.println("results: " + resultSet.getInt(1));
  			    userDetailsId = resultSet.getInt(1);
  			 }
  			 resultSet.close();
  			 preparedStatement.close();
   			
   			preparedStatement = connection.prepareStatement(sqlUserProfile);
   			preparedStatement.setString(1, fname);
   			preparedStatement.setString(2, lname);
   			preparedStatement.setInt(3, userDetailsId);
   			preparedStatement.setInt(4, 2);
   			preparedStatement.executeUpdate();
   			preparedStatement.close();
   			
   			connection.commit();
   			
   			addFBUserStatus = true;
   		}
   	catch(Exception e)
   	{
   		addFBUserStatus = false;
   		System.out.println("An exception occured while trying to add a new FB username."+e);
   	}
   		finally {
       		
   			if (preparedStatement != null) {
   				try {
   					preparedStatement.close();
   					
   				} catch (SQLException e) {}
   			}
   			
   				if (resultSet != null) {
   					try {
   						resultSet.close();
   						
   					} catch (SQLException e) {}
   				}
   				
   				if (connection != null) {
   					try {
   						connection.close();
   						
   					} catch (SQLException e) {}
   				}
   				
   			}
   	return addFBUserStatus;
   }

    public String checkLogin(Login login) {
    	try
    	{
    		loginStatus = "";
	    	connection = dataSource.getConnection();
	    	
	    	preparedStatement = connection.prepareStatement("select username, password from tw_login where username = ? and password =? and active_Flg = ?");
	    	preparedStatement.setString(1, login.getUsername());
			preparedStatement.setString(2, login.getPassword());
			preparedStatement.setString(3, "Y");
			
	    	resultSet = preparedStatement.executeQuery();
			
			 while (resultSet.next())
			 {
			    username = resultSet.getString("username");
				password = resultSet.getString("password");
				System.out.println("Username is: "+username+" Password is: "+password);
				 if((username.equals(login.getUsername()) && password.equals(login.getPassword())))
				 {
					 System.out.println("inside this");
					 loginStatus = "success";
				 }
			 }
			
			 resultSet.close();
			 preparedStatement.close();
    	}
    	catch(Exception e)
    	{
    		System.out.println("An exception occured while trying to check the login credentials in dao."+e);
    	}
    	finally {
    		
			if (preparedStatement != null) {
				try {
					preparedStatement.close();
					
				} catch (SQLException e) {}
			}
			
				if (resultSet != null) {
					try {
						resultSet.close();
						
					} catch (SQLException e) {}
				}
				
				if (connection != null) {
					try {
						connection.close();
						
					} catch (SQLException e) {}
				}
				
			}
    	
    	return loginStatus;
    }
    
    public UserDTO getFirstandLastName(String username) {
    	try
    	{
    		userDTO = new UserDTO();
	    	connection = dataSource.getConnection();
	    	
	    	preparedStatement = connection.prepareStatement("select ud.fname as fname, ud.lname as lname, ud.user_id as userId, ud.tw_image_flag as imageFlag "+
												    "from tw_userprofile ud, tw_login l "+
												    "where ud.user_id = l.user_id "+
												    "and l.username = ?");
			preparedStatement.setString(1, username);
			
			resultSet = preparedStatement.executeQuery();
			
			 while (resultSet.next())
			 {
			    userDTO.setFname(resultSet.getString("fname"));
			    userDTO.setLname(resultSet.getString("lname"));
			    userDTO.setUserId(resultSet.getInt("userId"));
			    userDTO.setImageFlag(resultSet.getString("imageFlag"));
			 }
    	}
    	catch(Exception e)
    	{
    		System.out.println("An excecption occured while trying to get the first, last name and user id."+e);
    	}
    	finally {
    		
			if (preparedStatement != null) {
				try {
					preparedStatement.close();
					
				} catch (SQLException e) {}
			}
			
				if (resultSet != null) {
					try {
						resultSet.close();
						
					} catch (SQLException e) {}
				}
				
				if (connection != null) {
					try {
						connection.close();
						
					} catch (SQLException e) {}
				}
				
			}
    	return userDTO;
    }
    
    public UserDTO getProfilePicture(int userId) {
    	
    	try
    	{
    		connection = dataSource.getConnection();
    		
    		preparedStatement = connection.prepareStatement("select tw_profilepic as profilepic "+
													"from tw_userprofile "+
													"where user_id = ?");
    		preparedStatement.setInt(1, userId);
    		
    		resultSet = preparedStatement.executeQuery();
    		
			 while (resultSet.next())
			 {
				Blob blob = resultSet.getBlob("profilepic");
			    byte[] bytes = blob.getBytes(1, (int) blob.length());
			    userDTO = new UserDTO();
			    userDTO.setProfilePic(bytes);
			 }
    	}
    	catch(Exception e)
    	{
    		System.out.println("An excecption occured while trying to get the image."+e);
    	}
    	finally {
    		
			if (preparedStatement != null) {
				try {
					preparedStatement.close();
					
				} catch (SQLException e) {}
			}
			
				if (resultSet != null) {
					try {
						resultSet.close();
						
					} catch (SQLException e) {}
				}
				
				if (connection != null) {
					try {
						connection.close();
						
					} catch (SQLException e) {}
				}
				
			}
    	return userDTO;
    }
    
    public UserDTO getProfileInformation(int userId) {
    	
    	try
    	{
    		connection = dataSource.getConnection();
    		
    		
    		
    		preparedStatement = connection.prepareStatement("select up.fname as fname, up.lname as lname, "+
															"up.email_id as emailId, up.contact as contact, "+
															"ud.profession_name as professionName, "+
															"ud.company_name as companyName, up.user_id as userId, "+
															"ud.education_name as educationName, "+
															"up.tw_image_flag as imageFlag "+
															"from tw_userprofile up, tw_userdetails ud "+
															"where up.tw_userdetails_id = ud.userdetails_id "+
															"and up.user_id = ?");
    		preparedStatement.setInt(1, userId);
    		
    		resultSet = preparedStatement.executeQuery();
    		
			 while (resultSet.next())
			 {
			    userDTO = new UserDTO();
			    userDTO.setFname(resultSet.getString("fname"));
			    userDTO.setLname(resultSet.getString("lname"));
			    userDTO.setEmailId(resultSet.getString("emailId"));
			    userDTO.setContact(resultSet.getLong("contact"));
			    userDTO.setProfessionName(resultSet.getString("professionName"));
			    userDTO.setCompanyName(resultSet.getString("companyName"));
			    userDTO.setEducationName(resultSet.getString("educationName"));
			    userDTO.setUserId(resultSet.getInt("userId"));
			    userDTO.setImageFlag(resultSet.getString("imageFlag"));
			 }
    	}
    	catch(Exception e)
    	{
    		System.out.println("An excecption occured while trying to get the image."+e);
    	}
    	finally {
    		
			if (preparedStatement != null) {
				try {
					preparedStatement.close();
					
				} catch (SQLException e) {}
			}
			
				if (resultSet != null) {
					try {
						resultSet.close();
						
					} catch (SQLException e) {}
				}
				
				if (connection != null) {
					try {
						connection.close();
						
					} catch (SQLException e) {}
				}
				
			}
    	return userDTO;
    }
    
    public List<TopQuestions> getTopQuestions() {
    	try
    	{
    		connection = dataSource.getConnection();
	    	
	    	resultSet = connection.prepareStatement("select q.question_name as question_name, a.tw_answer_name as answer_name, "+
													"up.fname as first_name, up.lname as last_name, "+
													"ud.profession_name as profession, ud.company_name as company, "+
													"ud.education_name as education, up.user_id as userId, up.tw_image_flag as imageFlag "+
													"from tw_questions q, tw_answers a, tw_questions_answers qa, "+ 
													"tw_userprofile up, tw_users_answers ua, tw_userdetails ud "+
													"where q.tw_questions_answers_id = qa.tw_question_id "+
													"and a.tw_answer_id = qa.tw_answer_id "+
													"and up.user_id = ua.tw_user_id "+
													"and ua.tw_answer_id = qa.tw_answer_id "+
													"and ud.userdetails_id = up.tw_userdetails_id "+
													"group by q.question_name "+
													"order by a.tw_answer_time desc limit 10").executeQuery();
	    	topQuestions = new ArrayList<TopQuestions>();
	    	
			 while (resultSet.next())
			 {
				topQuestionsObject = new TopQuestions();
				topQuestionsObject.setQuestion_name(resultSet.getString("question_name"));
				topQuestionsObject.setAnswer_name(resultSet.getString("answer_name"));
				topQuestionsObject.setFirst_name(resultSet.getString("first_name"));
				topQuestionsObject.setLast_name(resultSet.getString("last_name"));
				topQuestionsObject.setProfession(resultSet.getString("profession"));
				topQuestionsObject.setCompany_name(resultSet.getString("company"));
				topQuestionsObject.setEducation(resultSet.getString("education"));
				topQuestionsObject.setUserId(resultSet.getInt("userId"));
				topQuestionsObject.setImageFlag(resultSet.getString("imageFlag"));
				topQuestions.add(topQuestionsObject);
			 }
    	}
    	catch(Exception e)
    	{
    		System.out.println("An exception occured while trying to get the top questions."+e);
    	}
    	finally {
    		
			if (preparedStatement != null) {
				try {
					preparedStatement.close();
					
				} catch (SQLException e) {}
			}
			
				if (resultSet != null) {
					try {
						resultSet.close();
						
					} catch (SQLException e) {}
				}
				
				if (connection != null) {
					try {
						connection.close();
						
					} catch (SQLException e) {}
				}
				
			}
    	return topQuestions;
    }
    
    public List<Blogs> displayBlogs() {
    	try
    	{
    		connection = dataSource.getConnection();
	    	
	    	resultSet = connection.prepareStatement("select blogs.tw_blog_topic as blogTopic, blogs.tw_blog_content as blogContent, "+
													"userprofile.fname as fname, userprofile.lname as lname, "+
													"userprofile.contact as contact, userprofile.email_id as emailId, "+
													"ud.profession_name as profession, ud.company_name as company, "+
													"ud.education_name as education, userprofile.user_id as userId, "+
                          							"blogs.number_of_views as numberOfViews, "+
													"userprofile.tw_image_flag as imageFlag "+
													"from tw_blogs blogs, tw_users_blogs ub, "+
													"tw_userprofile userprofile, tw_userdetails ud "+
													"where blogs.tw_blog_id = ub.tw_blog_id "+
													"and userprofile.tw_userdetails_id = ud.userdetails_id "+
													"and userprofile.user_id = ub.tw_user_id "+
													"order by blogs.number_of_views desc, blogs.tw_blog_time desc limit 7").executeQuery();
	    	blogsList = new ArrayList<Blogs>();
	    	
			 while (resultSet.next())
			 {
				blogs = new Blogs();
				blogs.setBlogTopic(resultSet.getString("blogTopic"));
				blogs.setBlogContent(resultSet.getString("blogContent"));
				blogs.setFname(resultSet.getString("fname"));
				blogs.setLname(resultSet.getString("lname"));
				blogs.setContact(resultSet.getLong("contact"));
				blogs.setEmailId(resultSet.getString("emailId"));
				blogs.setProfession(resultSet.getString("profession"));
				blogs.setCompany(resultSet.getString("company"));
				blogs.setEducation(resultSet.getString("education"));
				blogs.setUserId(resultSet.getInt("userId"));
				blogs.setImageFlag(resultSet.getString("imageFlag"));
				blogsList.add(blogs);
			 }
    	}
    	catch(Exception e)
    	{
    		System.out.println("An exception occured while trying to get the latest blogs."+e);
    	}
    	finally {
    		
			if (preparedStatement != null) {
				try {
					preparedStatement.close();
					
				} catch (SQLException e) {}
			}
			
				if (resultSet != null) {
					try {
						resultSet.close();
						
					} catch (SQLException e) {}
				}
				
				if (connection != null) {
					try {
						connection.close();
						
					} catch (SQLException e) {}
				}
				
			}
    	return blogsList;
    }
    
    public List<TopQuestions> getUserAskedQuestions(int userId) {
    	try
    	{
    		connection = dataSource.getConnection();
	    	
    		preparedStatement = connection.prepareStatement("select q.question_name as question_name "+
													"from tw_questions q, tw_userprofile up, "+
													"tw_users_questions uq "+
													"where q.tw_questions_answers_id = uq.tw_question_id "+
													"and uq.tw_user_id = up.user_id "+
													"and up.user_id = ?");
    		preparedStatement.setInt(1, userId);
    		
    		resultSet = preparedStatement.executeQuery();
    		
	    	topQuestions = new ArrayList<TopQuestions>();
	    	
			 while (resultSet.next())
			 {
				topQuestionsObject = new TopQuestions();
				topQuestionsObject.setQuestion_name(resultSet.getString("question_name"));
				topQuestions.add(topQuestionsObject);
			 }
    	}
    	catch(Exception e)
    	{
    		System.out.println("An exception occured while trying to get the top questions."+e);
    	}
    	finally {
    		
			if (preparedStatement != null) {
				try {
					preparedStatement.close();
					
				} catch (SQLException e) {}
			}
			
				if (resultSet != null) {
					try {
						resultSet.close();
						
					} catch (SQLException e) {}
				}
				
				if (connection != null) {
					try {
						connection.close();
						
					} catch (SQLException e) {}
				}
				
			}
    	return topQuestions;
    }
    
    //get answer for search bar
    public TopQuestions getSearchAnswer(String answer) {
    	try
    	{
    		connection = dataSource.getConnection();
    		
    		String query = "select q.question_name as question_name, "+
    				"a.tw_answer_name as answer_name, "+
					"up.fname as first_name, up.lname as last_name, "+
					"up.email_id as emailId, up.contact as contact, "+
					"ud.profession_name as profession, up.user_id as userId, "+
					"ud.company_name as company, up.tw_image_flag as imageFlag, "+
					"ud.education_name as education, up.user_id as userId "+
					"from tw_answers a, tw_questions q, "+
					"tw_questions_answers qa, "+
					"tw_userprofile up, tw_users_answers ua, "+
					"tw_userdetails ud "+
					"where a.tw_answer_id = qa.tw_answer_id "+
					"and q.tw_questions_answers_id = qa.tw_question_id "+
					"and ua.tw_user_id = up.user_id "+
					"and ua.tw_answer_id = a.tw_answer_id "+
					"and ud.userdetails_id = up.tw_userdetails_id "+
					"and a.tw_answer_name = ? "+
                    "order by a.tw_answer_time desc";
	    	
	    	preparedStatement = connection.prepareStatement(query);
	    	
	    	preparedStatement.setString(1, answer);
	    	
	    	resultSet = preparedStatement.executeQuery();
	    	
	    	topQuestions = new ArrayList<TopQuestions>();
	    	
			 while (resultSet.next())
			 {
				topQuestionsObject = new TopQuestions();
				topQuestionsObject.setQuestion_name(resultSet.getString("question_name"));
				topQuestionsObject.setAnswer_name(resultSet.getString("answer_name"));
				topQuestionsObject.setFirst_name(resultSet.getString("first_name"));
				topQuestionsObject.setLast_name(resultSet.getString("last_name"));
				topQuestionsObject.setEmailId(resultSet.getString("emailId"));
				topQuestionsObject.setContact(resultSet.getLong("contact"));
				topQuestionsObject.setProfession(resultSet.getString("profession"));
				topQuestionsObject.setCompany_name(resultSet.getString("company"));
				topQuestionsObject.setEducation(resultSet.getString("education"));
				topQuestionsObject.setUserId(resultSet.getInt("userId"));
				topQuestionsObject.setImageFlag(resultSet.getString("imageFlag"));
			 }
    	}
    	catch(Exception e)
    	{
    		System.out.println("An exception occured while trying to display answer using a search bar."+e);
    	}
    	finally {
    		
			if (preparedStatement != null) {
				try {
					preparedStatement.close();
					
				} catch (SQLException e) {}
			}
			
				if (resultSet != null) {
					try {
						resultSet.close();
						
					} catch (SQLException e) {}
				}
				
				if (connection != null) {
					try {
						connection.close();
						
					} catch (SQLException e) {}
				}
				
			}
    	return topQuestionsObject;
    }
    
    public List<TopQuestions> getAnswers(String question) {
    	try
    	{
    		connection = dataSource.getConnection();
    		
    		String query = "select a.tw_answer_name as answer_name, "+
					"up.fname as first_name, up.lname as last_name, "+
					"ud.profession_name as profession, up.user_id as userId, "+
					"ud.company_name as company, up.tw_image_flag as imageFlag, "+
					"ud.education_name as education, up.user_id as userId, " +
					"q.number_of_views as numberOfViews "+
					"from tw_answers a, tw_questions q, "+ 
					"tw_questions_answers qa, "+
					"tw_userprofile up, tw_users_answers ua, "+
					"tw_userdetails ud "+	
					"where a.tw_answer_id = qa.tw_answer_id "+
					"and q.tw_questions_answers_id = qa.tw_question_id "+
					"and ua.tw_user_id = up.user_id "+
					"and ua.tw_answer_id = a.tw_answer_id "+
					"and ud.userdetails_id = up.tw_userdetails_id "+
					"and q.question_name = ? "+
					"order by a.tw_answer_time desc";
	    	
	    	preparedStatement = connection.prepareStatement(query);
	    	
	    	preparedStatement.setString(1, question);
	    	
	    	resultSet = preparedStatement.executeQuery();
	    	
	    	topQuestions = new ArrayList<TopQuestions>();
	    	
			 while (resultSet.next())
			 {
				topQuestionsObject = new TopQuestions();
				topQuestionsObject.setAnswer_name(resultSet.getString("answer_name"));
				topQuestionsObject.setFirst_name(resultSet.getString("first_name"));
				topQuestionsObject.setLast_name(resultSet.getString("last_name"));
				topQuestionsObject.setProfession(resultSet.getString("profession"));
				topQuestionsObject.setCompany_name(resultSet.getString("company"));
				topQuestionsObject.setEducation(resultSet.getString("education"));
				topQuestionsObject.setUserId(resultSet.getInt("userId"));
				topQuestionsObject.setImageFlag(resultSet.getString("imageFlag"));
				topQuestionsObject.setNumberOfViews(resultSet.getInt("numberOfViews"));
				topQuestions.add(topQuestionsObject);
			 }
    	}
    	catch(Exception e)
    	{
    		System.out.println("An exception occured while trying to get all the answers."+e);
    	}
    	finally {
    		
			if (preparedStatement != null) {
				try {
					preparedStatement.close();
					
				} catch (SQLException e) {}
			}
			
				if (resultSet != null) {
					try {
						resultSet.close();
						
					} catch (SQLException e) {}
				}
				
				if (connection != null) {
					try {
						connection.close();
						
					} catch (SQLException e) {}
				}
				
			}
    	return topQuestions;
    }
    
    public int getNumberOfViewsQuestion(String question) {
    	int numberOfViews = 0;
    	try
    	{
    		connection = dataSource.getConnection();
    		
    		connection.setAutoCommit(false);
    		
			 //to get the existing number of views
		    	preparedStatement = connection.prepareStatement("select number_of_views as numberOfViews from tw_questions where question_name = ?");
		    	
		    	preparedStatement.setString(1, question);
		    	
		    	resultSet = preparedStatement.executeQuery();
		    	
				 while (resultSet.next())
				 {
					 numberOfViews = resultSet.getInt("numberOfViews");
				 }
	   			
	   			preparedStatement = connection.prepareStatement("update tw_questions set number_of_views = ? where question_name = ?");
				preparedStatement.setInt(1, numberOfViews+1);
				preparedStatement.setString(2, question);
				preparedStatement.executeUpdate();
				preparedStatement.close();
	   			
	   			connection.commit();
    	}
    	catch(Exception e)
    	{
    		System.out.println("An exception occured while trying to get all the answers."+e);
    	}
    	finally {
    		
			if (preparedStatement != null) {
				try {
					preparedStatement.close();
					
				} catch (SQLException e) {}
			}
			
				if (resultSet != null) {
					try {
						resultSet.close();
						
					} catch (SQLException e) {}
				}
				
				if (connection != null) {
					try {
						connection.close();
						
					} catch (SQLException e) {}
				}
				
			}
    	return numberOfViews;
    }
    
    public int getNumberOfViewsBlog(String blog) {
    	int numberOfViews = 0;
    	try
    	{
    		connection = dataSource.getConnection();
    		
    		connection.setAutoCommit(false);
    		
			 //to get the existing number of views
		    	preparedStatement = connection.prepareStatement("select number_of_views as numberOfViews from tw_blogs where tw_blog_topic = ?");
		    	
		    	preparedStatement.setString(1, blog);
		    	
		    	resultSet = preparedStatement.executeQuery();
		    	
				 while (resultSet.next())
				 {
					 numberOfViews = resultSet.getInt("numberOfViews");
				 }
				 
	   			preparedStatement = connection.prepareStatement("update tw_blogs set number_of_views = ? where tw_blog_topic = ?");
				preparedStatement.setInt(1, numberOfViews+1);
				preparedStatement.setString(2, blog);
				preparedStatement.executeUpdate();
				preparedStatement.close();
	   			
	   			connection.commit();
    	}
    	catch(Exception e)
    	{
    		System.out.println("An exception occured while trying to get all the answers."+e);
    	}
    	finally {
    		
			if (preparedStatement != null) {
				try {
					preparedStatement.close();
					
				} catch (SQLException e) {}
			}
			
				if (resultSet != null) {
					try {
						resultSet.close();
						
					} catch (SQLException e) {}
				}
				
				if (connection != null) {
					try {
						connection.close();
						
					} catch (SQLException e) {}
				}
				
			}
    	return numberOfViews;
    }
    
    public List<Blogs> getComments(String blogTopic) {
    	try
    	{
    		connection = dataSource.getConnection();
    		
    		String query = "select blogs.tw_blog_topic as blogTopic, blogs.tw_blog_content as blogContent, "+
    				        "c.tw_comment_desc as comment, "+
							"userprofile.fname as fname, userprofile.lname as lname, "+
							"userprofile.contact as contact, userprofile.email_id as emailId, "+
							"ud.profession_name as profession, ud.company_name as company, "+
							"ud.education_name as education, userprofile.user_id as userId, "+
							"userprofile.tw_image_flag as imageFlag "+
							"from tw_blogs blogs, tw_users_blogs ub, "+
							"tw_userprofile userprofile, tw_userdetails ud, "+
                            "tw_comments c, tw_blogs_comments bc, "+
                            "tw_users_comments uc "+
							"where blogs.tw_blog_id = ub.tw_blog_id "+
                            "and blogs.tw_blog_id = bc.tw_blog_id "+
							"and userprofile.tw_userdetails_id = ud.userdetails_id "+
							"and userprofile.user_id = uc.tw_user_id "+
							"and blogs.tw_blog_topic = ? "+
                            "and c.tw_comment_id = bc.tw_comment_id "+
                            "and bc.tw_comment_id = uc.tw_comment_id "+
							"order by c.tw_comment_time desc";
	    	
	    	preparedStatement = connection.prepareStatement(query);
	    	
	    	preparedStatement.setString(1, blogTopic);
	    	
	    	resultSet = preparedStatement.executeQuery();
	    	
	    	blogsList = new ArrayList<Blogs>();
	    	
	    	 while (resultSet.next())
			 {
				blogs = new Blogs();
				blogs.setBlogTopic(resultSet.getString("blogTopic"));
				blogs.setBlogContent(resultSet.getString("blogContent"));
				blogs.setComment(resultSet.getString("comment"));
				blogs.setFname(resultSet.getString("fname"));
				blogs.setLname(resultSet.getString("lname"));
				blogs.setContact(resultSet.getLong("contact"));
				blogs.setEmailId(resultSet.getString("emailId"));
				blogs.setProfession(resultSet.getString("profession"));
				blogs.setCompany(resultSet.getString("company"));
				blogs.setEducation(resultSet.getString("education"));
				blogs.setUserId(resultSet.getInt("userId"));
				blogs.setImageFlag(resultSet.getString("imageFlag"));
				blogsList.add(blogs);
			 }
    	}
    	catch(Exception e)
    	{
    		System.out.println("An exception occured while trying to get comments for a particular blog."+e);
    	}
    	finally {
    		
			if (preparedStatement != null) {
				try {
					preparedStatement.close();
					
				} catch (SQLException e) {}
			}
			
				if (resultSet != null) {
					try {
						resultSet.close();
						
					} catch (SQLException e) {}
				}
				
				if (connection != null) {
					try {
						connection.close();
						
					} catch (SQLException e) {}
				}
				
			}
    	return blogsList;
    }
    
    public List<Blogs> getUserBlogInformation(String blogTopic) {
    	try
    	{
    		connection = dataSource.getConnection();
    		
    		String query = "select blogs.tw_blog_content as blogContent,"+
							"userprofile.fname as fname, userprofile.lname as lname, "+
							"userprofile.contact as contact, userprofile.email_id as emailId, "+
							"ud.profession_name as profession, ud.company_name as company, "+
							"ud.education_name as education, userprofile.user_id as userId, "+
							"userprofile.tw_image_flag as imageFlag "+
							"from tw_blogs blogs, tw_users_blogs ub, "+
							"tw_userprofile userprofile, tw_userdetails ud "+
							"where blogs.tw_blog_topic = ? "+
							"and blogs.tw_blog_id = ub.tw_blog_id "+
							"and ub.tw_user_id = userprofile.user_id "+
							"and userprofile.tw_userdetails_id = ud.userdetails_id";
	    	
	    	preparedStatement = connection.prepareStatement(query);
	    	
	    	preparedStatement.setString(1, blogTopic);
	    	
	    	resultSet = preparedStatement.executeQuery();
	    	
	    	blogsList = new ArrayList<Blogs>();
	    	
	    	 while (resultSet.next())
			 {
				blogs = new Blogs();
				blogs.setBlogContent(resultSet.getString("blogContent"));
				blogs.setFname(resultSet.getString("fname"));
				blogs.setLname(resultSet.getString("lname"));
				blogs.setContact(resultSet.getLong("contact"));
				blogs.setEmailId(resultSet.getString("emailId"));
				blogs.setProfession(resultSet.getString("profession"));
				blogs.setCompany(resultSet.getString("company"));
				blogs.setEducation(resultSet.getString("education"));
				blogs.setUserId(resultSet.getInt("userId"));
				blogs.setImageFlag(resultSet.getString("imageFlag"));
				blogsList.add(blogs);
			 }
    	}
    	catch(Exception e)
    	{
    		System.out.println("An exception occured while trying to get user information who has written the blog."+e);
    	}
    	finally {
    		
			if (preparedStatement != null) {
				try {
					preparedStatement.close();
					
				} catch (SQLException e) {}
			}
			
				if (resultSet != null) {
					try {
						resultSet.close();
						
					} catch (SQLException e) {}
				}
				
				if (connection != null) {
					try {
						connection.close();
						
					} catch (SQLException e) {}
				}
				
			}
    	return blogsList;
    }
    
    public List<TopQuestions> getUsersAnswers(int userId) {
    	try
    	{
    		connection = dataSource.getConnection();
    		
    		String query = "select q.question_name as question_name, a.tw_answer_name as answer_name, "+
							"up.fname as first_name, up.lname as last_name, "+
							"ud.profession_name as profession, up.user_id as userId, "+
							"ud.company_name as company, up.tw_image_flag as imageFlag, "+ 
							"ud.education_name as education "+
							"from tw_answers a, tw_questions q, tw_questions_answers qa, "+
							"tw_userprofile up, tw_users_answers ua, tw_userdetails ud "+
							"where a.tw_answer_id = qa.tw_answer_id "+
							"and q.tw_questions_answers_id = qa.tw_question_id "+ 
							"and ua.tw_user_id = up.user_id "+
							"and ua.tw_answer_id = a.tw_answer_id "+ 
							"and ud.userdetails_id = up.tw_userdetails_id "+
							"and up.user_id = ? "+
							"order by q.tw_question_time desc";
	    	
	    	preparedStatement = connection.prepareStatement(query);
	    	
	    	preparedStatement.setInt(1, userId);
	    	
	    	resultSet = preparedStatement.executeQuery();
	    	
	    	topQuestions = new ArrayList<TopQuestions>();
	    	
			 while (resultSet.next())
			 {
				topQuestionsObject = new TopQuestions();
				topQuestionsObject.setQuestion_name(resultSet.getString("question_name"));
				topQuestionsObject.setAnswer_name(resultSet.getString("answer_name"));
				topQuestionsObject.setFirst_name(resultSet.getString("first_name"));
				topQuestionsObject.setLast_name(resultSet.getString("last_name"));
				topQuestionsObject.setProfession(resultSet.getString("profession"));
				topQuestionsObject.setCompany_name(resultSet.getString("company"));
				topQuestionsObject.setEducation(resultSet.getString("education"));
				topQuestionsObject.setUserId(resultSet.getInt("userId"));
				topQuestionsObject.setImageFlag(resultSet.getString("imageFlag"));
				topQuestions.add(topQuestionsObject);
			 }
    	}
    	catch(Exception e)
    	{
    		System.out.println("An exception occured while trying to get all the answers that user have answered."+e);
    	}
    	finally {
    		
			if (preparedStatement != null) {
				try {
					preparedStatement.close();
					
				} catch (SQLException e) {}
			}
			
				if (resultSet != null) {
					try {
						resultSet.close();
						
					} catch (SQLException e) {}
				}
				
				if (connection != null) {
					try {
						connection.close();
						
					} catch (SQLException e) {}
				}
				
			}
    	return topQuestions;
    }
    
    public List<Blogs> getCommentsBlogs(int userId) {
    	try
    	{
    		connection = dataSource.getConnection();
    		
    		String query = "select blogs.tw_blog_topic as blogTopic, blogs.tw_blog_content as blogContent, "+
    				       "c.tw_comment_desc as comment, "+
							"userprofile.fname as fname, userprofile.lname as lname, "+
							"userprofile.contact as contact, userprofile.email_id as emailId, "+
							"ud.profession_name as profession, ud.company_name as company, "+
							"ud.education_name as education, userprofile.user_id as userId, "+
							"userprofile.tw_image_flag as imageFlag "+
							"from tw_blogs blogs, tw_users_blogs ub, "+
							"tw_userprofile userprofile, tw_userdetails ud, "+
				             "tw_comments c, tw_blogs_comments bc, "+
				              "tw_users_comments uc "+
							"where blogs.tw_blog_id = ub.tw_blog_id "+
				             "and blogs.tw_blog_id = bc.tw_blog_id "+
							"and userprofile.tw_userdetails_id = ud.userdetails_id "+
							"and userprofile.user_id = uc.tw_user_id "+
							"and userprofile.user_id = ? "+
				            "and c.tw_comment_id = bc.tw_comment_id "+
				            "and bc.tw_comment_id = uc.tw_comment_id "+
							"order by c.tw_comment_time desc";
	    	
	    	preparedStatement = connection.prepareStatement(query);
	    	
	    	preparedStatement.setInt(1, userId);
	    	
	    	resultSet = preparedStatement.executeQuery();
	    	
	    	blogsList = new ArrayList<Blogs>();
	    	
			 while (resultSet.next())
			 {
				    blogs = new Blogs();
					blogs.setBlogTopic(resultSet.getString("blogTopic"));
					blogs.setBlogContent(resultSet.getString("blogContent"));
					blogs.setComment(resultSet.getString("comment"));
					blogs.setFname(resultSet.getString("fname"));
					blogs.setLname(resultSet.getString("lname"));
					blogs.setContact(resultSet.getLong("contact"));
					blogs.setEmailId(resultSet.getString("emailId"));
					blogs.setProfession(resultSet.getString("profession"));
					blogs.setCompany(resultSet.getString("company"));
					blogs.setEducation(resultSet.getString("education"));
					blogs.setUserId(resultSet.getInt("userId"));
					blogs.setImageFlag(resultSet.getString("imageFlag"));
					blogsList.add(blogs);
			 }
    	}
    	catch(Exception e)
    	{
    		System.out.println("An exception occured while trying to get all the comments that user has posted."+e);
    	}
    	finally {
    		
			if (preparedStatement != null) {
				try {
					preparedStatement.close();
					
				} catch (SQLException e) {}
			}
			
				if (resultSet != null) {
					try {
						resultSet.close();
						
					} catch (SQLException e) {}
				}
				
				if (connection != null) {
					try {
						connection.close();
						
					} catch (SQLException e) {}
				}
				
			}
    	return blogsList;
    }
    
    public List<Blogs> getUsersBlogs(int userId) {
    	try
    	{
    		connection = dataSource.getConnection();
    		
    		String query = "select blogs.tw_blog_topic as blogTopic, blogs.tw_blog_content as blogContent, "+
							"userprofile.fname as fname, userprofile.lname as lname, "+
							"userprofile.contact as contact, userprofile.email_id as emailId, "+
							"ud.profession_name as profession, ud.company_name as company, "+
							"ud.education_name as education, userprofile.user_id as userId, "+
							"userprofile.tw_image_flag as imageFlag "+
    						"from tw_blogs blogs, tw_users_blogs ub, "+
							"tw_userprofile userprofile, tw_userdetails ud "+
    						"where blogs.tw_blog_id = ub.tw_blog_id "+
							"and userprofile.tw_userdetails_id = ud.userdetails_id "+
    						"and userprofile.user_id = ub.tw_user_id "+
    						"and userprofile.user_id = ? "+
							"order by blogs.tw_blog_time desc";
	    	
	    	preparedStatement = connection.prepareStatement(query);
	    	
	    	preparedStatement.setInt(1, userId);
	    	
	    	resultSet = preparedStatement.executeQuery();
	    	
	    	blogsList = new ArrayList<Blogs>();
	    	
			 while (resultSet.next())
			 {
				    blogs = new Blogs();
					blogs.setBlogTopic(resultSet.getString("blogTopic"));
					blogs.setBlogContent(resultSet.getString("blogContent"));
					blogs.setFname(resultSet.getString("fname"));
					blogs.setLname(resultSet.getString("lname"));
					blogs.setContact(resultSet.getLong("contact"));
					blogs.setEmailId(resultSet.getString("emailId"));
					blogs.setProfession(resultSet.getString("profession"));
					blogs.setCompany(resultSet.getString("company"));
					blogs.setEducation(resultSet.getString("education"));
					blogs.setUserId(resultSet.getInt("userId"));
					blogs.setImageFlag(resultSet.getString("imageFlag"));
					blogsList.add(blogs);
			 }
    	}
    	catch(Exception e)
    	{
    		System.out.println("An exception occured while trying to get all the blogs that user has posted."+e);
    	}
    	finally {
    		
			if (preparedStatement != null) {
				try {
					preparedStatement.close();
					
				} catch (SQLException e) {}
			}
			
				if (resultSet != null) {
					try {
						resultSet.close();
						
					} catch (SQLException e) {}
				}
				
				if (connection != null) {
					try {
						connection.close();
						
					} catch (SQLException e) {}
				}
				
			}
    	return blogsList;
    }
    
  public String findSearchResults(String searchData) {
    	
	  String searchType = "";
    	try
    	{
    		connection = dataSource.getConnection();
    		
    		//to search for a question
	    	preparedStatement = connection.prepareStatement("select question_name as question from tw_questions where question_name = ?");
	    	
	    	preparedStatement.setString(1, searchData);
	    	
	    	resultSet = preparedStatement.executeQuery();
	    	
	    	 while (resultSet.next())
	    	 {
	    		 if(resultSet.getString("question").equals(searchData))
	    			 searchType = "question";
	    	 }
	    	 
	    	 preparedStatement.close();
	    	 resultSet.close();
	    	 
	    	//to search for an answer
		    preparedStatement = connection.prepareStatement("select tw_answer_name as answer from tw_answers where tw_answer_name = ?");
		    	
		    preparedStatement.setString(1, searchData);
		    	
		    resultSet = preparedStatement.executeQuery();
		    while (resultSet.next())
	    	 {
		    if(resultSet.getString("answer").equals(searchData))
   			 searchType = "answer";
	    	 }
		    	 
		    preparedStatement.close();
		    resultSet.close();
		    
		    //to search for a blog
		    preparedStatement = connection.prepareStatement("select tw_blog_topic as blog from tw_blogs where (tw_blog_topic = ? or tw_blog_content = ?)");
		    	
		    preparedStatement.setString(1, searchData);
		    preparedStatement.setString(2, searchData);
		    	
		    resultSet = preparedStatement.executeQuery();
		    	
		    while (resultSet.next())
		    {
		    	if(resultSet.getString("blog").equals(searchData))
	    			 searchType = "blog";
		    }
		    
		    preparedStatement.close();
		    resultSet.close();
		    
		    //to search for a profile name
		    String temp = searchData.split("Profile:")[1].trim();
		    String fname = temp.split(" ")[0].trim();
		    String lname = temp.split(" ")[1].trim();
		    
		    preparedStatement = connection.prepareStatement("select fname as fname, lname as lname, user_id as userId from tw_userprofile where (fname like ? or fname like ?) or (lname like ? or lname like ?)");
		    	
		    preparedStatement.setString(1, "%" + fname + "%");
		    preparedStatement.setString(2, "%" + fname + "%");
		    preparedStatement.setString(3, "%" + lname + "%");
		    preparedStatement.setString(4, "%" + lname + "%");
		    
		    resultSet = preparedStatement.executeQuery();
		    	
		    while (resultSet.next())
		    {
		    	if((resultSet.getString("fname").equalsIgnoreCase(fname) && (resultSet.getString("lname")).equalsIgnoreCase(lname)))
		    	{
	    			 searchType = "profile";
		    	}
		    }
		    	 
		    preparedStatement.close();
		    resultSet.close();
    	}
    	catch(Exception e)
    	{
    		System.out.println("An exception occured while trying to get the search type."+e);
    	}
    	finally {
    		
			if (preparedStatement != null) {
				try {
					preparedStatement.close();
					
				} catch (SQLException e) {}
			}
			
				if (resultSet != null) {
					try {
						resultSet.close();
						
					} catch (SQLException e) {}
				}
				
				if (connection != null) {
					try {
						connection.close();
						
					} catch (SQLException e) {}
				}
				
			}
    	return searchType;
    }
  
  public int getUserId(String fname, String lname) {
  	
	  int userId = 0;
    	try
    	{
    		connection = dataSource.getConnection();
    		
    		//to search for a question
	    	preparedStatement = connection.prepareStatement("select user_id as userId from tw_userprofile where fname = ? and lname = ?");
	    	
	    	preparedStatement.setString(1, fname);
	    	preparedStatement.setString(2, lname);
	    	
	    	resultSet = preparedStatement.executeQuery();
	    	
	    	 while (resultSet.next())
	    	 {
	    		  userId = resultSet.getInt("userId");
	    	 }
	    	 preparedStatement.close();
	    	 resultSet.close();
    	}
    	catch(Exception e)
    	{
    		System.out.println("An exception occured while trying to get the user id."+e);
    	}
    	finally {
    		
			if (preparedStatement != null) {
				try {
					preparedStatement.close();
					
				} catch (SQLException e) {}
			}
			
				if (resultSet != null) {
					try {
						resultSet.close();
						
					} catch (SQLException e) {}
				}
				
				if (connection != null) {
					try {
						connection.close();
						
					} catch (SQLException e) {}
				}
				
			}
    	return userId;
    }
  
  public int checkFBUserId(String fname, String lname) {
	  	
	  int userId = 0;
    	try
    	{
    		connection = dataSource.getConnection();
    		
    		//to search for a question
	    	preparedStatement = connection.prepareStatement("select user_id as userId from tw_userprofile where fname = ? and lname = ? and tw_facebook_users_id = 2");
	    	
	    	preparedStatement.setString(1, fname);
	    	preparedStatement.setString(2, lname); 	
	    	
	    	resultSet = preparedStatement.executeQuery();
	    	
	    	 while (resultSet.next())
	    	 {
	    		  userId = resultSet.getInt("userId");
	    	 }
	    	 preparedStatement.close();
	    	 resultSet.close();
    	}
    	catch(Exception e)
    	{
    		System.out.println("An exception occured while trying to get the user id."+e);
    	}
    	finally {
    		
			if (preparedStatement != null) {
				try {
					preparedStatement.close();
					
				} catch (SQLException e) {}
			}
			
				if (resultSet != null) {
					try {
						resultSet.close();
						
					} catch (SQLException e) {}
				}
				
				if (connection != null) {
					try {
						connection.close();
						
					} catch (SQLException e) {}
				}
				
			}
    	return userId;
    }
    
    public List<String> getAutoSuggestData(String autoSuggestString) {
    	
    	List<String> list = new ArrayList<String>();
    	try
    	{
    		connection = dataSource.getConnection();
    		
    		//to search for a question
	    	preparedStatement = connection.prepareStatement("select question_name as question from tw_questions where question_name like ? or question_name like ?");
	    	
	    	preparedStatement.setString(1, "%" + autoSuggestString + "%");
	    	preparedStatement.setString(2, "%" + autoSuggestString + "%");
	    	
	    	resultSet = preparedStatement.executeQuery();
	    	
	    	 while (resultSet.next())
	    		 list.add(resultSet.getString("question"));
	    	 
	    	 preparedStatement.close();
	    	 resultSet.close();
	    	 
	    	//to search for an answer
		    preparedStatement = connection.prepareStatement("select tw_answer_name as answer from tw_answers where tw_answer_name like ? or tw_answer_name like ?");
		    	
		    preparedStatement.setString(1, "%" + autoSuggestString + "%");
		    preparedStatement.setString(2, "%" + autoSuggestString + "%");
		    	
		    resultSet = preparedStatement.executeQuery();
		    	
		    while (resultSet.next())
		    	list.add(resultSet.getString("answer"));
		    	 
		    preparedStatement.close();
		    resultSet.close();
		    
		    //to search for a blog
		    preparedStatement = connection.prepareStatement("select tw_blog_topic as blog from tw_blogs where (tw_blog_topic like ? or tw_blog_topic like ?) "
		    		+ "or (tw_blog_content like ? or tw_blog_content like ?)");
		    	
		    preparedStatement.setString(1, "%" + autoSuggestString + "%");
		    preparedStatement.setString(2, "%" + autoSuggestString + "%");
		    preparedStatement.setString(3, "%" + autoSuggestString + "%");
		    preparedStatement.setString(4, "%" + autoSuggestString + "%");
		    	
		    resultSet = preparedStatement.executeQuery();
		    	
		    while (resultSet.next())
		    	list.add(resultSet.getString("blog"));
		    
		    preparedStatement.close();
		    resultSet.close();
		    
		    //to search for a profile name
		    preparedStatement = connection.prepareStatement("select fname as fname, lname as lname from tw_userprofile where (fname like ? or fname like ?) or (lname like ? or lname like ?)");
		    	
		    preparedStatement.setString(1, autoSuggestString + "%");
		    preparedStatement.setString(2, "%" + autoSuggestString + "%");
		    preparedStatement.setString(3, autoSuggestString + "%");
		    preparedStatement.setString(4, "%" + autoSuggestString + "%");
		    	
		    resultSet = preparedStatement.executeQuery();
		    	
		    while (resultSet.next())
		    {
		    	list.add("Profile: "+resultSet.getString("fname")+" "+resultSet.getString("lname"));
		    }
		    	 
		    preparedStatement.close();
		    resultSet.close();
    	}
    	catch(Exception e)
    	{
    		System.out.println("An exception occured while trying to get user information who has written the blog."+e);
    	}
    	finally {
    		
			if (preparedStatement != null) {
				try {
					preparedStatement.close();
					
				} catch (SQLException e) {}
			}
			
				if (resultSet != null) {
					try {
						resultSet.close();
						
					} catch (SQLException e) {}
				}
				
				if (connection != null) {
					try {
						connection.close();
						
					} catch (SQLException e) {}
				}
				
			}
    	return list;
    }
}