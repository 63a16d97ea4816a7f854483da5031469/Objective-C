package com.backend.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.core.io.InputStreamResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.awsrelated.utils.UploadUtil;
import com.backend.util.StringUtil;

@Controller
@RequestMapping("api/file")
public class FileRestController {
	
	
	@RequestMapping(value = "/getParams", method = { RequestMethod.POST,
			RequestMethod.GET })
	public @ResponseBody
	void getParams(HttpServletRequest request) {

		Map<String, String[]> parameters = request.getParameterMap();
		
		
		String username = request.getParameter("username");
		String password = request.getParameter("password");

		if (!StringUtil.isNullandEmpty(username)) {
			System.out.println(username);
		}
		if (!StringUtil.isNullandEmpty(password)) {
			System.out.println(password);
		}

		for (String key : parameters.keySet()) {
			// System.out.println(key);
			String[] vals = parameters.get(key);
			for (String val : vals) {
				if (!val.equals("")) {
					System.out.println(key + " -> " + val);
				} else {
					System.out.println(key + "-> is empty");
				}
			}
		}
	}
	
	
	
	@RequestMapping(value = "/uploadMyFile", method = RequestMethod.POST)
	@ResponseBody
	public void handleFileUpload(MultipartHttpServletRequest request,HttpServletRequest httprequest,@ModelAttribute("foo") String foo) throws Exception {
		Iterator<String> itrator = request.getFileNames();
		MultipartFile multiFile = request.getFile(itrator.next());
		try {
			
			
			Map<String, String[]> parameters = httprequest.getParameterMap();
		
			
			String username = httprequest.getParameter("username");
			String password = httprequest.getParameter("password");
			System.out.println("the ddddddddd>>>"+foo);
			if (!StringUtil.isNullandEmpty(username)) {
				System.out.println(username);
			}
			if (!StringUtil.isNullandEmpty(password)) {
				System.out.println(password);
			}

			for (String key : parameters.keySet()) {
				// System.out.println(key);
				String[] vals = parameters.get(key);
				for (String val : vals) {
					if (!val.equals("")) {
						System.out.println(key + " -> " + val);
					} else {
						System.out.println(key + "-> is empty");
					}
				}
			}
			
			InputStream stream=multiFile.getInputStream();
//			//aws upload
			UploadUtil.uploadFile(stream, multiFile.getOriginalFilename());
			
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			throw new Exception("Error while loading the file");
		}
		// return "File Uploaded successfully.";
	}
	
	
	@RequestMapping(value = "/read/{filename}", method = RequestMethod.GET)
	public ResponseEntity<InputStreamResource> downloadStuff(
			@PathVariable String filename) throws IOException {
		System.out.println(filename);
		HttpHeaders respHeaders = new HttpHeaders();
		File file=null;

		try {
			//use aws to download the file based on the file name
			file = UploadUtil.downloadFile(filename);
		} catch (Exception e) {
			return new ResponseEntity<InputStreamResource>(null, respHeaders,
					HttpStatus.NOT_FOUND);
		}

		if (file != null) {

			respHeaders.setContentType(new MediaType("application", "png"));
			respHeaders.setContentLength(file.length());

			InputStreamResource isr = new InputStreamResource(
					new FileInputStream(file));
			return new ResponseEntity<InputStreamResource>(isr, respHeaders,
					HttpStatus.OK);
		}

		return new ResponseEntity<InputStreamResource>(null, respHeaders,
				HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	
	
	
	
	
	
	
	
	
	

}
