import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.*;
	
public class Reporting {

	    public static void main(String[] argv) {
	    	String usrName = argv[0];
	    	String password = argv[1];

	        System.out.println("-------- Oracle JDBC Connection Testing ------");
	        System.out.println("-------- Step 1: Registering Oracle Driver ------");
	        try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
	        } catch (ClassNotFoundException e) {
	            System.out.println("Where is your Oracle JDBC Driver? Did you follow the execution steps. ");
	            System.out.println("");
	            System.out.println("*****Open the file and read the comments in the beginning of the file****");
	            System.out.println("");
	            e.printStackTrace();
	            return;
	        }

	        System.out.println("Oracle JDBC Driver Registered Successfully !");


		System.out.println("-------- Step 2: Building a Connection ------");
	        Connection connection = null;
	        try {
	            connection = DriverManager.getConnection(
	                                                     "jdbc:oracle:thin:@csorcl.cs.wpi.edu:1521:orcl", usrName,
	                                                     password);

	        } catch (SQLException e) {
	            System.out.println("Connection Failed! Check output console");
	            e.printStackTrace();
	            return;
	        }

	        if (connection != null) {
	            System.out.println("You made it. Connection is successful. Take control of your database now!");
	        } else {
	            System.out.println("Failed to make connection!");
	        }
	        
		
	        if(argv.length < 3)
	        {
	        	System.out.println("1- Report Patients Basic Information");
	        	System.out.println("2- Report Doctors Basic Information");
	        	System.out.println("3- Report Admissions Information");
	        	System.out.println("4- Update Admissions Payment");
	        }
	        else
	        {
	        	Scanner keyboard = new Scanner(System.in);
	        	if(argv[2].equals("1")) 
	        	{
	        		System.out.print("Enter Patient SSN: ");
	        		String SSN = keyboard.nextLine();
	        		preformQueryPatient(SSN, connection);
	        		
	        	}
	        	else if(argv[2].equals("2")) 
	        	{
	        		System.out.print("Enter Doctor ID: ");
	        		String ID = keyboard.nextLine();
	        		performQueryDoctor(ID, connection);
	        	}
	        	else if(argv[2].equals("3")) 
	        	{
	        		System.out.print("Enter Admission Number: ");
	        		String adNum = keyboard.nextLine();
	        		performQueryAdmission(adNum, connection);
	        	}
	        	else if(argv[2].equals("4")) 
	        	{
	        		System.out.print("Enter Admission Number: ");
	        		String adNum = keyboard.nextLine();
	        		System.out.print("Enter the new total payment: ");
	        		String payment = keyboard.nextLine();
	        		performAdmissionUpdate(adNum, payment, connection);
	        	}
	        }	
	        
	        try {
	        	connection.close();
	        } catch (SQLException e) {
	        	e.printStackTrace();
	        }
	        
	    }
	    
	    public static void preformQueryPatient(String SSN, Connection conn) {
	    	try {
	    		Statement s = conn.createStatement();
	    		String query = "SELECT SSN, FName, LName, Address FROM Patient WHERE SSN = '" + SSN + "'";
				ResultSet resultset = s.executeQuery(query);
				if(resultset.next())
				{
					System.out.println("Patient SSN: " + resultset.getString("SSN"));
					System.out.println("Patient First Name: " + resultset.getString("FName"));
					System.out.println("Patient Last Name: " + resultset.getString("LName"));
					System.out.println("Patient Address: " + resultset.getString("Address"));
				}
				else 
				{
					System.out.println("No one with that SSN.");
				}
				
				resultset.close();
				s.close();
			} catch (SQLException e) {
				e.printStackTrace();
			}
	    	
	    	
	    	
	    }
	    
	    public static void performQueryDoctor(String ID, Connection conn) {
	    	try {
	    		Statement s = conn.createStatement();
	    		String query = "SELECT ID, FName, LName, Gender FROM Doctor WHERE ID = '" + ID + "'";
				ResultSet resultset = s.executeQuery(query);
				if(resultset.next())
				{
					System.out.println("Doctor ID: " + resultset.getString("ID"));
					System.out.println("Doctor First Name: " + resultset.getString("FName"));
					System.out.println("Doctor Last Name: " + resultset.getString("LName"));
					System.out.println("Doctor Gender: " + resultset.getString("Gender"));
				}
				else 
				{
					System.out.println("No one with that doctor ID.");
				}
				
				resultset.close();
				s.close();
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
	    	
	    	
	    	
	    }
	    
	    public static void performQueryAdmission(String num, Connection conn) {
	    	try {
	    		Statement s = conn.createStatement();
	    		String query = "SELECT Num, PatientSSN, StartDate, TotalPayment FROM Admission WHERE Num = '" + num + "'";
				ResultSet resultset = s.executeQuery(query);
				if(resultset.next())
				{
					System.out.println("Admission Number: " + resultset.getString("Num"));
					System.out.println("Patient SSN: " + resultset.getString("PatientSSN"));
					System.out.println("Admission date (start date): " + resultset.getString("StartDate"));
					System.out.println("Total Payment: " + resultset.getString("TotalPayment"));
					
					String query2 = "SELECT RoomNum, StartDate, LeaveDate FROM StayIn WHERE AdmissionNum = '" + num + "'";
					ResultSet resultset2 = s.executeQuery(query2);
					System.out.println("Rooms:");
					while(resultset2.next()) {
						System.out.println("\tRoomNum: " + resultset2.getString("RoomNum") + " FromDate: " + resultset2.getString("StartDate") + " ToDate: " + resultset2.getString("LeaveDate"));
					}
					
					String query3 = "SELECT DoctorID FROM Examine WHERE AdmissionNum = '" + num + "'";
					ResultSet resultset3 = s.executeQuery(query3);
					System.out.println("Doctors examined the patient in this admission:");
					while(resultset3.next()) {
						System.out.println("\tDoctor ID: " + resultset3.getString("DoctorID"));
					}
					
				}
				else 
				{
					System.out.println("no one with that ssn");
				}
				
				resultset.close();
				s.close();
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
	    }
	    	
	    public static void performAdmissionUpdate(String num, String payment, Connection conn) {
		   	try {
		   		String query = "UPDATE Admission Set TotalPayment = '"+ payment + "' WHERE Num = '" + num + "'";
				PreparedStatement ps = conn.prepareStatement(query);
				ps.executeUpdate();		
				ps.close();
			} catch (SQLException e) {
				
				e.printStackTrace();
			}
	    	
	    }
}

