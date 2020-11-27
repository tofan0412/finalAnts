<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
  
  <style>
  
  	 .ff{
		width: 100vw;
	  	height: 100vh;
  	 }
  	 .col-sm-4{
  		height: 100vh;
  		width: 40vw;
  	 }
  	 .col-sm-6{
  		height: 100vh;
  		width: 60vw;
  	 }
  	 .center{
  	 	padding: 30%;
  	 }
  </style>
  
</head>
<body>

<div class="ff">
 
    <div class="col-sm-4" style="background-color:lavender;">
    	<img src="../dist/loginimage.png" height="100%" width="100%" alt="Avatar">
    </div>
    
    <div class="col-sm-6" style="background-color:lavenderblush;">
    	<div class="center">
    			<form action="/member/loginFunc" method="get"> 
					<div class="form-group has-feedback">
						<input type="text" class="form-control" name="mem_id" id="mem_id" placeholder="아이디를 입력하세요" value="java">  
						<span class="glyphicon glyphicon-envelope form-control-feedback"></span>
					</div>	
					<div class="form-group has-feedback">
						<input type="password" class="form-control" name="mem_pass"
																placeholder="패스워드를 입력하세요" value="java"> <span
							class="glyphicon glyphicon-lock form-control-feedback"></span>
					</div>
					<div class="row">
						<div class="col-sm-8">
							<div class="checkbox icheck">
								<label> <input type="checkbox" id="rememberMe" name="rememberMe" value=""> Remember Me
								</label>
							</div>
						</div>
						<!-- /.col -->
						<div class="form-group has-feedback">
							<button type="submit" class="btn btn-primary btn-block btn-flat">login</button>
						</div>
						<!-- /.col -->
					</div>
				</form>
	    </div>
    </div>

</div>
    
</body>
</html> 