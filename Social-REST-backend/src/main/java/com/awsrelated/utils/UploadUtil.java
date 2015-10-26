package com.awsrelated.utils;


import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import com.amazonaws.auth.AWSCredentials;
import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.s3.AmazonS3;
import com.amazonaws.services.s3.AmazonS3Client;
import com.amazonaws.services.s3.model.GetObjectRequest;
import com.amazonaws.services.s3.model.ObjectMetadata;
import com.amazonaws.services.s3.model.PutObjectRequest;
import com.amazonaws.services.s3.model.S3Object;
 

public class UploadUtil {
	
	private static AWSCredentials credentials=new BasicAWSCredentials(IdentityCons.appid, IdentityCons.appsecret);
	private static AmazonS3 s3client=new AmazonS3Client(credentials);
	
	public static void uploadFile(InputStream input,String name){
		

		PutObjectRequest request=new PutObjectRequest(IdentityCons.bucketName, name, input, new ObjectMetadata());
		s3client.putObject(request);

	
	}
	
//	public static void uploadFileByStream(InputStream inputstream,String name){
//		s3client.putObject(new PutObjectRequest(IdentityCons.bucketName,name, inputstream, null);
//	}
//	
	
	public static File downloadFile(String filename) throws IOException{
		
		
	S3Object obj=	s3client.getObject(new GetObjectRequest(IdentityCons.bucketName, filename));
	InputStream inputStream=obj.getObjectContent();
	
	File file=File.createTempFile(filename, obj.getObjectMetadata().getContentType());
	
	OutputStream os = new FileOutputStream(file);
	int bytesRead = 0;
    byte[] buffer = new byte[8192];
	   while ((bytesRead = inputStream.read(buffer, 0, 8192)) != -1) {
	      os.write(buffer, 0, bytesRead);
	   }
	os.close();
	inputStream.close();
		
	return file;
	}
	
	
	//public static File 
 
}
